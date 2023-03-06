# PET Calculations

To calculate PET we use of the pyet package to estimate potential evapotranspiration (Estimation of Potential Evapotranspiration)[https://github.com/pyet-org/pyet]
We use the method ASCE Penman-Monteith

This requires the following cmorised DAILY data:
- rsds,rsus,rlds,rlus,tas,tasmin,tasmax,sfcWind and hurs (DAILY)
- orog (fixed) 

## Output

Output is netcdf files: 
- PET (daily, mm day-1). The surface potential evapotranspiration with the ASCE Penman-Montheith method is calculated with the package pyet: Estimation of Potential Evapotranspiration [https://github.com/pyet-org/pyet] using the following LENTIS variables: daily tmean (tas_day), daily wind speed (sfcWind_day), net radiation at the surface in [MJ/m2day] (rn = ((rsds_day - rsus_day) - (rlds_day - rlus_day)) * 86400 / 1000000) daily tmax (tasmax_day), daily tmin (tasmin_day), daily rh (hurs_day) fixed elevation (orog_fx) and fixed latitude (ds.lat) in the following equation: pet_pm_asce = pyet.pm_asce(tmean, wind, rn=rn, elevation=elevation, lat=lat, tmax=tmax, tmin=tmin, rh=rh
- Rnet (daily, W m-2). Surface Net Radiation is calculated as rnet=(SWin-SWout)-(LWin-LWout) i.e. the cmorised LENTIS variables: rnet = ((rsds - rsus) - (rlds - rlus))

## How to use the scripts here

You only need scripts 01* to 05* to generate the PET data. Underneath some of these scripts are functional scripts that are called. You don't need to touch these. Unless for example you want another method for PET calculations, then changes need to be made to `calc_Rnet_PET.py`

### Download necessary files from ECFS and Untar these
- `01_download_Rnet_PET_vars_from_ECFS.sh`
- `02_untar_Rnet_PET_vars.sh`

### Calculate Rnet and PET
- `03_submit_PET_rnet_calc.sh`
    - `run_Rnet_PET_calc_args.sh`
        - `calc_Rnet_PET.py`

### Tar and bring the new data to ECFS
- `04_make_ecfs_folders.sh`
- `05_submit_bring_vars_to_ECFS.sh`
    - `cmor_rnet_pet_toECFS.sh`
