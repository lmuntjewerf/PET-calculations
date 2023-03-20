# PET Calculations

This repo is a set of scripts to calculate daily potential evapotranspiration for the 3200 year large ensemble KNMI-LENTIS dataset. 
To calculate PET we use of the pyet package to estimate potential evapotranspiration (Estimation of Potential Evapotranspiration)[https://github.com/pyet-org/pyet]. 
We use the method ASCE Penman-Monteith. 

This requires the following cmorised DAILY data:
- rsds,tas,tasmin,tasmax,sfcWind and hurs (DAILY)
- orog (fixed) 

## Output

Output is netcdf files: 
- PET (daily, mm day-1). The surface potential evapotranspiration with the ASCE Penman-Montheith method is calculated with the package pyet: Estimation of Potential Evapotranspiration [https://github.com/pyet-org/pyet] using the following LENTIS variables: daily tmean in degC (tas_day - 273.15), daily wind speed (sfcWind_day), incoming shortwave radiation at the surface in [MJ/m2day] (rsds_day * 86400 / 1000000), daily tmax in degC (tasmax_day - 273.15), daily tmin in degC (tasmin_day - 273.15), daily rh (hurs_day) fixed elevation (orog_fx) and fixed latitude (ds.lat) in the following equation: `pet_pm_asce = pyet.pm_asce(tmean, wind, rs=rs, elevation=elevation, lat=lat, tmax=tmax, tmin=tmin, rh=rh)`. 


## How to use the scripts here

Here we describe the scripts that were used to generate and archive the PET data. Underneath some of these scripts are functional scripts that are called. If you want another method for PET calculations, you can make changes to `calc_PET.py`

### Download necessary files from the HPSS (ECFS) and untar the files:
- `01_download_PET_vars_from_ECFS.sh`
    - `download_from_ecfs.sh`
- `02_untar_PET_vars.sh`

### Calculate PET
- `03_submit_PET_rnet_calc.sh`
    - `run_PET_calc_args.sh`
        - `calc_PET.py`

### Make monthly meabs
- `04_calc_monmean.sh` 

### Tar and bring the new data to ECFS
- `make_ecfs_folders.sh`
- `05_submit_vars_to_ECFS.sh`
    - `cmor_pet_toECFS.sh`

### Others
- `check_climo_PET.ipynb`: notebook for a quick look what the climatology timeseries of De Bilt look like for the present-day and the future climate, and the timeseries of a 10-year time slice. 