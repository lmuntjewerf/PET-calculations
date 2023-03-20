#!/bin/bash

#set -ex

#-------------------
# Download the variables to calculate Rnet and PET from daily LENTIS output
# Day --> those are: tas, tasmax, tasmin, hurs, rsds, sfcWind
# fx --> orog
#
# Can not do too much at once due to queue limititations (100 jobs is the nf-queue limit on Atos. 10x10 is OK running+queuing...)
#-------------------

scenario='s'


for i in {1..16}; do 
  for j in {0..9}; do 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} orog fx ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} tas day ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} tasmax day ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} tasmin day ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} hurs day ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} rsds day ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} sfcWind day ; 
  done; 
done
