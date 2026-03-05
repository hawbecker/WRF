# PR Report: CANOPY fix19 Validation (A/B/C/D)

This report is PR-friendly for GitHub rendering. All figure and data assets referenced below are tracked under `dev_test/pr_report_fix19/`.

## Data Files

- `data/canopy_ab_summary_A_vs_B_1h_fix19.csv`
- `data/canopy_ab_summary_B_vs_C_10min_fix19.csv`
- `data/canopy_ab_summary_B_vs_D_10min_fix19.csv`
- `data/windspeed_profile_points_B_vs_D_10min.txt`

## A vs B (1h): 2D-LAD baseline consistency

### Quantitative summary

- `CANOPYHGT_2D`, `T2`, `U10`, `V10`, `WSPD10`, `HFX`, and `LH` are all exactly zero-difference (`max_abs_diff=0`, `rmse=0`).
- `CANOPYLAI_2D` has expected static offset (`max_abs_diff=4`, `mean_abs_diff=4`, `rmse=4`).

### Figures

![A vs B CANOPYHGT](figures/A_vs_B_1h/map_CANOPYHGT_2D.png)
![A vs B CANOPYLAI](figures/A_vs_B_1h/map_CANOPYLAI_2D.png)
![A vs B T2](figures/A_vs_B_1h/map_T2.png)
![A vs B U10](figures/A_vs_B_1h/map_U10.png)
![A vs B V10](figures/A_vs_B_1h/map_V10.png)
![A vs B WSPD10](figures/A_vs_B_1h/map_WSPD10.png)
![A vs B HFX](figures/A_vs_B_1h/map_HFX.png)
![A vs B LH](figures/A_vs_B_1h/map_LH.png)

## B vs C (10min): 3D-LAD + height sensitivity

### Quantitative summary

- Structural fields:
  - `CANOPYLAD_3D`: `max_abs_diff=0.305`, `mean_abs_diff=0.129`, `rmse=0.159`
  - `CANOPYHGT_2D`: `max_abs_diff=10`, `mean_abs_diff=10`, `rmse=10`
- Near-surface meteorology and fluxes:
  - `T2`: `max_abs_diff=2.157`, `rmse=0.052`
  - `WSPD10`: `max_abs_diff=0.762`, `mean_abs_diff=0.165`, `rmse=0.184`
  - `HFX`: `max_abs_diff=30.097`, `rmse=0.663`
  - `LH`: `max_abs_diff=12.854`, `rmse=0.500`

### Figures

![B vs C CANOPYLAD_3D](figures/B_vs_C_10min/map_CANOPYLAD_3D.png)
![B vs C CANOPYHGT](figures/B_vs_C_10min/map_CANOPYHGT_2D.png)
![B vs C CANOPYLAI](figures/B_vs_C_10min/map_CANOPYLAI_2D.png)
![B vs C T2](figures/B_vs_C_10min/map_T2.png)
![B vs C U10](figures/B_vs_C_10min/map_U10.png)
![B vs C V10](figures/B_vs_C_10min/map_V10.png)
![B vs C HFX](figures/B_vs_C_10min/map_HFX.png)
![B vs C LH](figures/B_vs_C_10min/map_LH.png)
![B vs C WSPD10](figures/B_vs_C_10min/map_WSPD10.png)

## B vs D (10min): alternative height scenario

### Quantitative summary

- Structural fields:
  - `CANOPYLAD_3D`: no difference (`max_abs_diff=0`, `rmse=0`)
  - `CANOPYHGT_2D`: `max_abs_diff=20`, `mean_abs_diff=15`, `rmse=15.811`
- Near-surface meteorology and fluxes:
  - `T2`: `max_abs_diff=2.124`, `rmse=0.045`
  - `WSPD10`: `max_abs_diff=0.565`, `mean_abs_diff=0.092`, `rmse=0.115`
  - `HFX`: `max_abs_diff=28.049`, `rmse=0.547`
  - `LH`: `max_abs_diff=11.459`, `rmse=0.348`

### Figures

![B vs D CANOPYHGT](figures/B_vs_D_10min/map_CANOPYHGT_2D.png)
![B vs D CANOPYLAD_3D](figures/B_vs_D_10min/map_CANOPYLAD_3D.png)
![B vs D CANOPYLAI](figures/B_vs_D_10min/map_CANOPYLAI_2D.png)
![B vs D T2](figures/B_vs_D_10min/map_T2.png)
![B vs D U10](figures/B_vs_D_10min/map_U10.png)
![B vs D V10](figures/B_vs_D_10min/map_V10.png)
![B vs D HFX](figures/B_vs_D_10min/map_HFX.png)
![B vs D LH](figures/B_vs_D_10min/map_LH.png)
![B vs D WSPD10](figures/B_vs_D_10min/map_WSPD10.png)

## B vs D vertical wind diagnostics

### Profile point selection

- See `data/windspeed_profile_points_B_vs_D_10min.txt`:
  - `caseB_3dlad: j=0, i=0, selection=max CANOPYHGT_2D=50.00 m`
  - `caseD_althgt: j=0, i=50, selection=max CANOPYHGT_2D=60.00 m`

### Figures

![B vs D windspeed west-east vs height](figures/wind_vertical_B_vs_D_10min/windspeed_west_east_vs_height.png)
![B vs D canopy-active-cell windspeed profile](figures/wind_vertical_B_vs_D_10min/windspeed_profile_canopy_active_cell.png)
