#!/bin/bash

set -ex

#-------------------
# LENTIS data that is downloaded ends up in the top LENTIS scratch folder. 
# this script first move the tarzip files into the right subfolders, before untarring them. 
#
# uncomment 'fx' or 'day', to use one freq at the same time 
#
# untar LENTIS data in folder
# delete tar.gz files 
#-------------------

# uncomment, use one freq at the same time 
#freq='fx'
#declare -a vars
#vars=(orog)

# uncomment, use one freq at the same time 
freq='day'
declare -a vars
vars=(tas tasmax tasmin hurs rsds sfcWind)


# switches for scenario to untar [do (1) or don't (0)]
scenario_h=0
scenario_s=1

# indir and outdir location of data 
LENTISSCRATCH=/scratch/nklm/LENTIS/
cmordir=$SCRATCH




# -------- no user edits below this line

for var in ${vars[@]}; do

 # -------- historical
 if (( $scenario_h ))
 then
    echo; echo " *** UNTARRING PD ***"; echo
    scenario=h
    scenfull=historical
 # -------- scenario_future
 elif (( $scenario_s ))
 then 
    echo; echo " *** UNTARRING 2K ***"; echo
    scenario=s
    scenfull=ssp245
 fi

 for i in {10..16}; do
    for j in {0..9}; do
       memberdir=${cmordir}${scenario}"$(printf "%02d" $i)"${j}/CMIP6/CMIP/KNMI/EC-Earth3/${scenfull}/r1i1p5f1/${freq}/
       mkdir -p ${memberdir}
       cd ${memberdir}
       tar -xvzf ${LENTISSCRATCH}/${scenario}"$(printf "%02d" $i)"${j}_${freq}_${var}.tar.gz -C ${memberdir} ;
       chmod -R u+w ${memberdir} ;
       #rm ${LENTISSCRATCH}/${scenario}"$(printf "%02d" $i)"${j}_${freq}_${var}.tar.gz
    done ;
 done
done

