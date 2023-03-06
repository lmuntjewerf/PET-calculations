#!/bin/bash


# **************************** LM notes ****************************************
# This script generates the folders on the tape storage where the tar zipped 
# files will be stored with 05_submit_bring_vars_to_ECFS.sh
# 
# Only has to run this once for a frequence
# 
# **************************** LM notes ****************************************

ecfsdir='ec:/nklm/LENTIS/ec-earth/cmorised_by_var/'

frequency=day

#  make the ECFS dirs
for scenariofolder in hxxx sxxx; do
  for var in pet rnet; do
    echo ${var}; 
    emkdir -p ${ecfsdir}${scenariofolder}/${frequency}/${var}
  done  ; 
done