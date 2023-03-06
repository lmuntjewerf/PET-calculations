#!/bin/bash

#set -ex

#-------------------
# calculate Rnet and PET for daily LENTIS output
# this script takes arguments:
#
# scenario=$1
# member=$2
# frequency=$3
#-------------------

scenario=$1
member=$2
freq=$3


cmordir='/scratch/nklm/cmorisation/cmorised-results/EC-EARTH-AOGCM/'

ensmember=${scenario}${member}
diri=${cmordir}/${ensmember}/CMIP6/CMIP/KNMI/EC-Earth3/historical/r1i1p5f1/

if (( $scenario == 'h' ))
  then
  startyear=2000
  endyear=2009
elif (( $scenario == 's' ))
  then
  startyear=2075
  endyear=2084
fi

for year in $(seq $startyear $endyear); do 
  python3 calc_Rnet_PET.py --diri $diri --freq $freq -y $year
done
