#!/bin/bash

set -ex

#-------------------
# LENTIS data that is downloaded ends up in the top LENTIS scratch folder. 
# this script first move the tarzip files into the right subfolders, before untarring them. 
#
# untar LENTIS data in folder
# delete tar.gz files 
#-------------------

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


# -------- historical
for var in ${vars[@]}; do
 if (( $scenario_h ))
 then
    echo; echo " *** UNTARRING PD ***"; echo
    scenario=h

    for i in {2..2}; do
      for j in {6..6}; do
         memberdir=${cmordir}${scenario}"$(printf "%02d" $i)"${j}/CMIP6/CMIP/KNMI/EC-Earth3/historical/r1i1p5f1/${freq}/
         mkdir -p ${memberdir}
         cd ${memberdir}
         tar -xvzf ${LENTISSCRATCH}/${scenario}"$(printf "%02d" $i)"${j}_${freq}_${var}.tar.gz -C ${memberdir} ;
         chmod -R u+w ${memberdir} ;
         #rm ${LENTISSCRATCH}/${scenario}"$(printf "%02d" $i)"${j}_${freq}_${var}.tar.gz
      done ;
    done
 fi


 # -------- scenario_future
 if (( $scenario_s ))
 then
  echo; echo " *** UNTARRING 2K ***"; echo
  scenario=s
  directory=/usr/people/muntjewe/nobackup/nobackup_1/LENTIS/ec-earth/cmorised_by_var/${scenario}xxx/${freq}/${var}/
  mkdir -p ${directory}
  cd ${directory}
  for i in {11..16}; do
    for j in {0..9}; do
       mkdir -p ${scenario}"$(printf "%02d" $i)"${j}_${freq}_${var} ;
       tar -xvzf ${LENTISSCRATCH}/${scenario}"$(printf "%02d" $i)"${j}_${freq}_${var}.tar.gz -C ${scenario}"$(printf "%02d" $i)"${j}_${freq}_${var} ;
       chmod -R u+w ${scenario}"$(printf "%02d" $i)"${j}_${freq}_${var} ;
       #rm ${LENTISSCRATCH}/${scenario}"$(printf "%02d" $i)"${j}_${freq}_${var}.tar.gz
    done ;
  done
 fi

done
