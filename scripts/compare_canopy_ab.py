#!/usr/bin/env python3
"""Compare two WRF outputs for canopy-focused A/B validation.

Outputs:
- CSV with max/mean/RMSE absolute differences per variable
- Domain-mean vertical profile plots for canopy-level variables
- 2D map plots of baseline/test/diff for selected variables
"""

import argparse
import csv
import datetime as dt
import os
import re

import numpy as np
import xarray as xr


def rmse(a, b):
    diff = a - b
    return float(np.sqrt(np.nanmean(diff * diff)))


def safe_time_select(da, time_index):
    if "Time" in da.dims:
        idx = min(max(int(time_index), 0), int(da.sizes["Time"]) - 1)
        return da.isel(Time=idx)
    return da


def get_variable_or_derived(ds, varname, time_index):
    if varname in ds.variables:
        return safe_time_select(ds[varname], time_index)

    # Derived 10 m wind speed from U10/V10 for clearer wind diagnostics.
    if varname == "WSPD10" and "U10" in ds.variables and "V10" in ds.variables:
        u10 = safe_time_select(ds["U10"], time_index)
        v10 = safe_time_select(ds["V10"], time_index)
        return np.sqrt(u10 * u10 + v10 * v10)

    return None


def summarize_variable(base, test):
    valid = xr.where(np.isfinite(base) & np.isfinite(test), 1.0, np.nan)
    base_m = base * valid
    test_m = test * valid
    diff = (test_m - base_m).values
    return {
        "max_abs_diff": float(np.nanmax(np.abs(diff))),
        "mean_abs_diff": float(np.nanmean(np.abs(diff))),
        "rmse": rmse(test_m.values, base_m.values),
    }


def parse_wrf_times(ds):
    if "Times" not in ds.variables:
        return []
    times = ds["Times"].values
    parsed = []
    for row in times:
        if hasattr(row, "tobytes"):
            text = row.tobytes().decode("utf-8", errors="ignore").strip("\x00").strip()
        else:
            chars = "".join([c.decode("utf-8", errors="ignore") if hasattr(c, "decode") else str(c) for c in row])
            text = chars.strip("\x00").strip()
        if not text:
            continue
        parsed.append(dt.datetime.strptime(text, "%Y-%m-%d_%H:%M:%S"))
    return parsed


def timing_from_wrfout(ds):
    times = parse_wrf_times(ds)
    if len(times) < 2:
        return {
            "frames": len(times),
            "sim_start": times[0].isoformat() if times else "",
            "sim_end": times[-1].isoformat() if times else "",
            "sim_span_sec": 0.0,
            "output_dt_mean_sec": 0.0,
            "output_dt_min_sec": 0.0,
            "output_dt_max_sec": 0.0,
        }

    diffs = np.array([(times[i] - times[i - 1]).total_seconds() for i in range(1, len(times))], dtype=float)
    return {
        "frames": len(times),
        "sim_start": times[0].isoformat(),
        "sim_end": times[-1].isoformat(),
        "sim_span_sec": float((times[-1] - times[0]).total_seconds()),
        "output_dt_mean_sec": float(np.mean(diffs)),
        "output_dt_min_sec": float(np.min(diffs)),
        "output_dt_max_sec": float(np.max(diffs)),
    }


def parse_pbs_wallclock(stdout_path):
    if not stdout_path:
        return None
    if not os.path.exists(stdout_path):
        return None

    with open(stdout_path, "r", encoding="utf-8", errors="ignore") as handle:
        lines = [line.strip() for line in handle if line.strip()]
    if len(lines) < 2:
        return None

    fmt = "%a %b %d %I:%M:%S %p %Z %Y"
    start = None
    end = None
    date_pat = re.compile(r"^[A-Za-z]{3} [A-Za-z]{3}\s+\d{1,2} ")
    for line in lines:
        if start is None and date_pat.match(line):
            try:
                start = dt.datetime.strptime(line, fmt)
            except Exception:
                start = None
    for line in reversed(lines):
        if date_pat.match(line):
            try:
                end = dt.datetime.strptime(line, fmt)
                break
            except Exception:
                end = None
    if start is None or end is None:
        return None
    return float((end - start).total_seconds())


def try_import_matplotlib():
    try:
        import matplotlib.pyplot as plt

        return plt
    except Exception:
        return None


def plot_profile(plt, base, test, varname, out_png):
    vertical_dim = None
    for candidate in ("canopy_levels", "canlev"):
        if candidate in base.dims:
            vertical_dim = candidate
            break
    if vertical_dim is None:
        return

    other_dims = [d for d in base.dims if d != vertical_dim]
    b = base.mean(dim=other_dims, skipna=True).values
    t = test.mean(dim=other_dims, skipna=True).values
    z = np.arange(1, b.shape[0] + 1)

    plt.figure(figsize=(5, 5))
    plt.plot(b, z, "-o", label="A baseline")
    plt.plot(t, z, "-s", label="B test")
    plt.gca().invert_yaxis()
    plt.xlabel(varname)
    plt.ylabel(vertical_dim)
    plt.title(f"Domain-mean profile: {varname}")
    plt.grid(True, alpha=0.3)
    plt.legend()
    plt.tight_layout()
    plt.savefig(out_png, dpi=140)
    plt.close()


def plot_map_triplet(plt, base2d, test2d, varname, out_png):
    diff = test2d - base2d
    vmax = np.nanmax(np.abs(diff.values))
    vmax = vmax if np.isfinite(vmax) and vmax > 0 else 1.0

    fig, axes = plt.subplots(1, 3, figsize=(12, 4), constrained_layout=True)
    im0 = axes[0].imshow(base2d.values, origin="lower")
    axes[0].set_title(f"A: {varname}")
    plt.colorbar(im0, ax=axes[0], fraction=0.046, pad=0.04)

    im1 = axes[1].imshow(test2d.values, origin="lower")
    axes[1].set_title(f"B: {varname}")
    plt.colorbar(im1, ax=axes[1], fraction=0.046, pad=0.04)

    im2 = axes[2].imshow(diff.values, origin="lower", cmap="RdBu_r", vmin=-vmax, vmax=vmax)
    axes[2].set_title(f"B - A: {varname}")
    plt.colorbar(im2, ax=axes[2], fraction=0.046, pad=0.04)

    for ax in axes:
        ax.set_xlabel("x")
        ax.set_ylabel("y")
    fig.savefig(out_png, dpi=140)
    plt.close(fig)


def build_parser():
    parser = argparse.ArgumentParser(description="Compare two canopy-related WRF outputs")
    parser.add_argument("--baseline", required=True, help="Baseline wrfout path (A)")
    parser.add_argument("--test", required=True, help="Test wrfout path (B)")
    parser.add_argument("--outdir", default="ab_compare", help="Output directory")
    parser.add_argument("--time-index", type=int, default=0, help="Time index for map/profile plots")
    parser.add_argument(
        "--vars",
        default="CANOPYLAD_3D,CANOPY_NORMZ,CANOPYHGT_2D,CANOPYLAI_2D,LAD3D,LAD_Z_3D,CANOPYZ2D,T2,U10,V10,WSPD10,HFX,LH",
        help="Comma-separated variable list",
    )
    parser.add_argument("--stdout-a", default=None, help="Optional PBS stdout file for baseline case")
    parser.add_argument("--stdout-b", default=None, help="Optional PBS stdout file for test case")
    return parser


def main():
    args = build_parser().parse_args()
    os.makedirs(args.outdir, exist_ok=True)

    ds_a = xr.open_dataset(args.baseline, engine="netcdf4")
    ds_b = xr.open_dataset(args.test, engine="netcdf4")

    var_list = [v.strip() for v in args.vars.split(",") if v.strip()]
    rows = []

    plt = try_import_matplotlib()

    for varname in var_list:
        a = get_variable_or_derived(ds_a, varname, args.time_index)
        b = get_variable_or_derived(ds_b, varname, args.time_index)
        if a is None or b is None:
            continue

        if a.shape != b.shape:
            continue

        stats = summarize_variable(a, b)
        rows.append({"variable": varname, **stats})

        if plt is None:
            continue

        if any(d in a.dims for d in ("canopy_levels", "canlev")):
            plot_profile(plt, a, b, varname, os.path.join(args.outdir, f"profile_{varname}.png"))

        map_dims = set(a.dims)
        if {"south_north", "west_east"}.issubset(map_dims):
            other = [d for d in a.dims if d not in ("south_north", "west_east")]
            a2d = a.mean(dim=other, skipna=True) if other else a
            b2d = b.mean(dim=other, skipna=True) if other else b
            plot_map_triplet(plt, a2d, b2d, varname, os.path.join(args.outdir, f"map_{varname}.png"))

    csv_path = os.path.join(args.outdir, "canopy_ab_summary.csv")
    with open(csv_path, "w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["variable", "max_abs_diff", "mean_abs_diff", "rmse"])
        writer.writeheader()
        for row in rows:
            writer.writerow(row)

    timing_a = timing_from_wrfout(ds_a)
    timing_b = timing_from_wrfout(ds_b)
    wall_a = parse_pbs_wallclock(args.stdout_a)
    wall_b = parse_pbs_wallclock(args.stdout_b)

    timing_csv = os.path.join(args.outdir, "timing_summary.csv")
    with open(timing_csv, "w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "case",
            "frames",
            "sim_start",
            "sim_end",
            "sim_span_sec",
            "output_dt_mean_sec",
            "output_dt_min_sec",
            "output_dt_max_sec",
            "wallclock_sec",
            "sim_sec_per_wallclock_sec",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        def row(case, t, wall):
            ratio = float(t["sim_span_sec"] / wall) if wall and wall > 0 else 0.0
            return {
                "case": case,
                "frames": t["frames"],
                "sim_start": t["sim_start"],
                "sim_end": t["sim_end"],
                "sim_span_sec": t["sim_span_sec"],
                "output_dt_mean_sec": t["output_dt_mean_sec"],
                "output_dt_min_sec": t["output_dt_min_sec"],
                "output_dt_max_sec": t["output_dt_max_sec"],
                "wallclock_sec": wall if wall is not None else "",
                "sim_sec_per_wallclock_sec": ratio,
            }

        writer.writerow(row("A_baseline", timing_a, wall_a))
        writer.writerow(row("B_test", timing_b, wall_b))

    timing_txt = os.path.join(args.outdir, "timing_summary.txt")
    with open(timing_txt, "w", encoding="utf-8") as handle:
        handle.write("Timing summary\n")
        handle.write("==============\n")
        handle.write(
            f"A: frames={timing_a['frames']} sim_span={timing_a['sim_span_sec']}s "
            f"dt_mean={timing_a['output_dt_mean_sec']}s wallclock={wall_a if wall_a is not None else 'n/a'}s\n"
        )
        handle.write(
            f"B: frames={timing_b['frames']} sim_span={timing_b['sim_span_sec']}s "
            f"dt_mean={timing_b['output_dt_mean_sec']}s wallclock={wall_b if wall_b is not None else 'n/a'}s\n"
        )
        if wall_a and wall_b and wall_a > 0 and wall_b > 0:
            speedup = wall_a / wall_b
            handle.write(f"Wallclock speedup (A/B): {speedup:.4f}\n")

    ds_a.close()
    ds_b.close()

    print(f"Wrote summary: {csv_path}")
    print(f"Wrote timing: {timing_csv}")
    if plt is None:
        print("matplotlib unavailable; skipped plot generation")
    else:
        print(f"Plots written in: {args.outdir}")


if __name__ == "__main__":
    main()
