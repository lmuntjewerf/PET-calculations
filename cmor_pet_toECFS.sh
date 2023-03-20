#!/bin/bash

set -ex

# ==================
# this script makes tar.gz files from all cmorized variable folders
# *tar.gz files are stored in the FREQUENCY folders (3hr, Amon etc)
# Arguments: 
#    $1 is EXP (h011 etc)
#    $2 is FREQUENCY (3hr, Amon etc)
# ==================



EXP=$1

FREQUENCY=$2


scenario=${EXP:0:1}
rcode=r1i1p5f1

if [ $scenario == 'h' ];
then
    twoletter=PD
    rperiod=CMIP
    rscenario=historical
elif [ $scenario == 's' ];
then
    twoletter=2K
    rperiod=CMIP
    rscenario=ssp245
fi



# ==================
# no need for user edits below
# info about where on ECFS it will go to
scenariofolder=${EXP:0:1}'xxx/'  # n.b. this can be hxxx or sxxx
ecfsdir='ec:/nklm/LENTIS/ec-earth/cmorised_by_var/'

tempfolder=$SCRATCH/cmor_temp/${EXP}/
mkdir -p ${tempfolder}

# get relevant info from path string cutting with delimiter '/'
cmordir=${SCRATCH}/cmorisation/cmorised-results

#put the path back together for the namelist
cmorpath=${cmordir}/EC-EARTH-AOGCM/${EXP}/CMIP6/${rperiod}/KNMI/EC-Earth3/${rscenario}/${rcode}/
cd ${cmorpath}

cd ${FREQUENCY}
for var in pet; do
  echo ${var};
  tar -czvf ${tempfolder}${EXP}_${FREQUENCY}_${var}.tar.gz ${cmorpath}/${FREQUENCY}/${var}                   # tar the file
  ecfsdir_var=${ecfsdir}${scenariofolder}${FREQUENCY}/${var}                                                 # define the ECFS folder
  emv -o ${tempfolder}${EXP}_${FREQUENCY}_${var}.tar.gz ${ecfsdir_var}/             # -o: overwrite if already existing ;move (previous ecp/copy) tar file to ECFS -e if not already existing, otherwise keep old 
done  ;



