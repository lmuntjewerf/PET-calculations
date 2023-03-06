#!/bin/bash

#set -ex

#-------------------
# Download the variables to calculate Rnet and PET from daily LENTIS output
# Day --> those are: tas, tasmax, tasmin, hurs, rsds, rsus, rlds, rlus, sfcWind
# fx --> orog
#
# Can not do too much at once due to queue limititations (50 jobs? I dont know. but 10x10 is OK running+queuing... but 2x10x10 is not...)
# so, setting i to 1..1 and j to 0..9, this gives 100 jobs
#-------------------

# choose one:
scenario='h' # for PD
#scenario='s' # for 2K

cd /home/nklm/VAREX-LE_script_train/ectrans/

for i in {1..16}; do 
  for j in {0..9}; do 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} orog fx ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} tas day ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} tasmax day ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} tasmin day ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} hurs day ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} rsds day ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} rsus day ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} rlds day ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} rlus day ; 
    sbatch ./download_from_ecfs.sh $scenario "$(printf "%02d" $i)"${j} sfcWind day ; 
  done; 
done
