#!/bin/bash
#
# **************************** LM notes ****************************************
#
# Script to calculate monthly means of PET
# 
#
#
# **************************** end LM notes ************************************


# switches for scenario to untar [do (1) or don't (0)]
scenario_h=0
scenario_s=1


cmordir=$SCRATCH

# -------- historical
 if (( $scenario_h ))
 then
    scenario=h
    scenfull='historical'
    startyear=2000
    endyear=2009
    rval=1
 fi
 
# -------- SSP2-4.5
 if (( $scenario_s ))
 then
    scenario=s
    scenfull='ssp245'
    startyear=2075
    endyear=2084
    rval=5
 fi

 for i in {10..16}; do
   for j in {0..9}; do
     ens_member=${scenario}"$(printf "%02d" $i)"${j}
     
     daydir=${cmordir}/${ens_member}/CMIP6/CMIP/KNMI/EC-Earth3/${scenfull}/r1i1p5f1/day/pet/gr/v20220601/
     mondir=${cmordir}/${ens_member}/CMIP6/CMIP/KNMI/EC-Earth3/${scenfull}/r1i1p5f1/Amon/pet/gr/v20220601/
     mkdir -p $mondir
     
     #if (( $ens_member=='h010'))
     #then
     #  echo 'do manually; with r1i0p5f1'
     #  for year in $(seq $startyear $endyear); do 
     #    cdo -monmean ${daydir}/pet_day_EC-Earth3_${scenfull}_r1i1p5f1_gr_${year}0101-${year}1231.nc ${mondir}/pet_mon_EC-Earth3_${scenfull}_r1i1p5f1_gr_${year}01-${year}12.nc
     #  done 
     #else
     for year in $(seq $startyear $endyear); do 
         cdo -monmean ${daydir}/pet_day_EC-Earth3_${scenfull}_r${rval}"$(printf "%02d" $i)"${j}i${j}p5f1_gr_${year}0101-${year}1231.nc ${mondir}/pet_mon_EC-Earth3_${scenfull}_r${rval}"$(printf "%02d" $i)"${j}i${j}p5f1_gr_${year}01-${year}12.nc
     done      
     #fi
     
   done
 done 

