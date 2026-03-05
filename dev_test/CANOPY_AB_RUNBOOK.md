# Canopy A/B Validation Runbook

This runbook compares legacy `lai.txt` forcing (A) against 3D canopy fields in `wrfinput` (B) using the same case setup.

## Paths

- Case directory: `/glade/work/hawbecker/WRF/VS-WRF-MCANOPY-ASR/dev_test`
- Updated canopy prep script: `/glade/work/hawbecker/WRF/VS-WRF-MCANOPY-ASR/scripts/add_lad_variables.py`
- Comparison script: `/glade/work/hawbecker/WRF/VS-WRF-MCANOPY-ASR/scripts/compare_canopy_ab.py`

## Case A: legacy `lai.txt` pathway

1. Ensure namelist uses the legacy path settings for canopy LAD input.
2. Submit run:

```bash
cd /glade/work/hawbecker/WRF/VS-WRF-MCANOPY-ASR/dev_test
qsub submit_wrf.sh
```

3. Save output artifact (example):

```bash
cp wrfout_d01_2025-06-04_06_00_00 wrfout_caseA_legacy.nc
```

## Case B: 3D canopy in `wrfinput`

1. Populate canopy vars from `lai.txt` into `wrfinput_d01`:

```bash
cd /glade/work/hawbecker/WRF/VS-WRF-MCANOPY-ASR/dev_test
python /glade/work/hawbecker/WRF/VS-WRF-MCANOPY-ASR/scripts/add_lad_variables.py wrfinput_d01 --from-lai-file lai.txt
```

Optional overrides:

```bash
# set explicit canopy level count (if compatible with wrfinput canopy_levels)
python /glade/work/hawbecker/WRF/VS-WRF-MCANOPY-ASR/scripts/add_lad_variables.py wrfinput_d01 10 --from-lai-file lai.txt

# force canopy height value (m)
python /glade/work/hawbecker/WRF/VS-WRF-MCANOPY-ASR/scripts/add_lad_variables.py wrfinput_d01 --from-lai-file lai.txt --canopy-height 50.0
```

2. Ensure namelist toggles to use 3D canopy LAD path.
3. Submit run:

```bash
qsub submit_wrf.sh
```

4. Save output artifact (example):

```bash
cp wrfout_d01_2025-06-04_06_00_00 wrfout_caseB_3dlad.nc
```

## Compare A vs B

```bash
python /glade/work/hawbecker/WRF/VS-WRF-MCANOPY-ASR/scripts/compare_canopy_ab.py \
  --baseline wrfout_caseA_legacy.nc \
  --test wrfout_caseB_3dlad.nc \
  --outdir ab_compare \
  --time-index 0
```

Outputs:
- `ab_compare/canopy_ab_summary.csv`
- `ab_compare/profile_*.png` (for canopy-level vars)
- `ab_compare/map_*.png` (for vars with x/y dimensions)

## Notes

- `add_lad_variables.py` creates a timestamped backup of `wrfinput_d01` before edits.
- The script rewrites canopy fields to match the requested/profile level count and removes legacy canopy variable names.
- For strict bitwise reproducibility checks, compare both with and without OpenMP/MPI changes and fixed decomposition.

## Validated Results (A/B/C/D)

Naming used below:
- **A**: legacy `lai.txt` pathway (`caseA_legacy`)
- **B**: 3D LAD pathway with matching profile (`caseB_3dlad`)
- **C**: modified LAD profile (`caseC_altlad`)
- **D**: heterogeneous canopy height (`caseD_althgt`, 30 m west half / 60 m east half)

### A vs B (1 hour)

- Comparison artifacts: `ab_tests/ab_compare_A_vs_B_1h_fix19/`
- Summary CSV: `ab_tests/ab_compare_A_vs_B_1h_fix19/canopy_ab_summary.csv`
- Key figure examples:
  - `ab_tests/ab_compare_A_vs_B_1h_fix19/map_CANOPYHGT_2D.png`
  - `ab_tests/ab_compare_A_vs_B_1h_fix19/map_T2.png`
  - `ab_tests/ab_compare_A_vs_B_1h_fix19/map_WSPD10.png`

![A vs B: CANOPYHGT_2D map](ab_tests/ab_compare_A_vs_B_1h_fix19/map_CANOPYHGT_2D.png)

![A vs B: T2 map](ab_tests/ab_compare_A_vs_B_1h_fix19/map_T2.png)

![A vs B: WSPD10 map](ab_tests/ab_compare_A_vs_B_1h_fix19/map_WSPD10.png)

Observed outcome:
- With `num_canopy_levels = 19` in the 3D-LAD case, prognostic fields match at 1 hour (`T2`, `U10`, `V10`, `HFX`, `LH` diffs = 0).
- `CANOPYLAI_2D` appears only in the 3D-LAD pathway and is therefore expected to differ from legacy output.

### B vs C (10 minutes, modified LAD)

- Comparison artifacts: `ab_tests/ab_compare_B_vs_C_10min_fix19/`
- Summary CSV: `ab_tests/ab_compare_B_vs_C_10min_fix19/canopy_ab_summary.csv`
- Key figure examples:
  - `ab_tests/ab_compare_B_vs_C_10min_fix19/map_CANOPYLAD_3D.png`
  - `ab_tests/ab_compare_B_vs_C_10min_fix19/map_HFX.png`
  - `ab_tests/ab_compare_B_vs_C_10min_fix19/map_WSPD10.png`

![B vs C: CANOPYLAD_3D map](ab_tests/ab_compare_B_vs_C_10min_fix19/map_CANOPYLAD_3D.png)

![B vs C: HFX map](ab_tests/ab_compare_B_vs_C_10min_fix19/map_HFX.png)

![B vs C: WSPD10 map](ab_tests/ab_compare_B_vs_C_10min_fix19/map_WSPD10.png)

Observed outcome:
- Clear, significant differences as expected from altered LAD profile.

### B vs D (10 minutes, heterogeneous canopy height)

- Comparison artifacts: `ab_tests/ab_compare_B_vs_D_10min_fix19/`
- Summary CSV: `ab_tests/ab_compare_B_vs_D_10min_fix19/canopy_ab_summary.csv`
- Key figure examples:
  - `ab_tests/ab_compare_B_vs_D_10min_fix19/map_CANOPYHGT_2D.png`
  - `ab_tests/ab_compare_B_vs_D_10min_fix19/map_T2.png`
  - `ab_tests/ab_compare_B_vs_D_10min_fix19/map_WSPD10.png`

![B vs D: CANOPYHGT_2D map](ab_tests/ab_compare_B_vs_D_10min_fix19/map_CANOPYHGT_2D.png)

![B vs D: T2 map](ab_tests/ab_compare_B_vs_D_10min_fix19/map_T2.png)

![B vs D: WSPD10 map](ab_tests/ab_compare_B_vs_D_10min_fix19/map_WSPD10.png)

Observed outcome:
- `CANOPYHGT_2D` differs as designed (30/60 m split).
- Resulting meteorology changes are nonzero within 10 minutes, confirming canopy-height forcing is active.

### Vertical wind diagnostics (B vs D, 10 minutes)

- Diagnostic artifacts: `ab_tests/wind_vertical_B_vs_D_10min/`
- West-east vs height slice figure:
  - `ab_tests/wind_vertical_B_vs_D_10min/windspeed_west_east_vs_height.png`
- Canopy-active point profile figure:
  - `ab_tests/wind_vertical_B_vs_D_10min/windspeed_profile_canopy_active_cell.png`
- Profile values dump:
  - `ab_tests/wind_vertical_B_vs_D_10min/windspeed_profile_points.txt`

![B vs D: windspeed west-east vs height](ab_tests/wind_vertical_B_vs_D_10min/windspeed_west_east_vs_height.png)

![B vs D: windspeed profile at canopy-active cell](ab_tests/wind_vertical_B_vs_D_10min/windspeed_profile_canopy_active_cell.png)

Interpretation:
- The west-east/height slice (lowest levels) shows where wind-speed structure changes after applying heterogeneous canopy height.
- The canopy-active cell profile gives a direct vertical comparison of wind speed with height between the two cases.

### Timing files

Timing sidecars are written alongside each comparison:
- `timing_summary.csv`
- `timing_summary.txt`

Current timing values are sourced from PBS stdout and are most useful for relative run-time checks between paired cases.

## Viewing / export

- In VS Code, open this file and use **Markdown: Open Preview**.
- Direct image viewing: click any `.png` path above in the Explorer.
- PDF export from terminal:

```bash
cd /glade/work/hawbecker/WRF/VS-WRF-MCANOPY-ASR/dev_test
pandoc CANOPY_AB_RUNBOOK.md -o CANOPY_AB_RUNBOOK.pdf
```

- HTML export (alternative):

```bash
cd /glade/work/hawbecker/WRF/VS-WRF-MCANOPY-ASR/dev_test
pandoc CANOPY_AB_RUNBOOK.md -o CANOPY_AB_RUNBOOK.html
```
