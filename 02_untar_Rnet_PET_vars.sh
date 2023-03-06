#!/bin/bash

set -ex

#-------------------
# LENTIS data that is downloaded ends up in the top LENTIS scratch folder. 
# this script first move the tarzip files into the right subfolders, before untarring them. 
#
# untar LENTIS data in folder
# delete tar.gz files 
#-------------------

# choose one freq to untar:

freq='fx'
declare -a vars
vars=(orog)

# freq='day'
# declare -a vars
# vars=(tas tasmax tasmin hurs rsds rsus rlds rlus sfcWind)



# switches for scenario to untar [do (1) or don't (0)]
scenario_h=1
scenario_s=0

# -------- no user edits below this license

LENTISSCRATCH=/scratch/nklm/LENTIS/

cmordir=/scratch/nklm/cmorisation/cmorised-results/EC-EARTH-AOGCM/


# Let's go... 
for var in ${vars[@]}; do
 
 if (( $scenario_h ))    # -------- historical
 then
    echo; echo " *** UNTARRING PD ***"; echo
    scenario=h
 elif (( $scenario_h ))  # -------- scenario_future
 then
    echo; echo " *** UNTARRING 2K ***"; echo
    scenario=s
 fi

 for i in {1..16}; do
   for j in {0..9}; do
      memberdir=${cmordir}${scenario}"$(printf "%02d" $i)"${j}/CMIP6/CMIP/KNMI/EC-Earth3/historical/r1i1p5f1/${freq}/
      mkdir -p ${memberdir}
      cd ${memberdir}
      tar -xvzf ${LENTISSCRATCH}/${scenario}"$(printf "%02d" $i)"${j}_${freq}_${var}.tar.gz -C ${memberdir} ;
      chmod -R u+w ${memberdir} ;
      #rm ${LENTISSCRATCH}/${scenario}"$(printf "%02d" $i)"${j}_${freq}_${var}.tar.gz
   done ;
 done 
done


