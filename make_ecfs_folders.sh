#!/bin/bash


ecfsdir='ec:/nklm/LENTIS/ec-earth/cmorised_by_var/'

frequency=day

#  make the ECFS dirs
for scenariofolder in hxxx sxxx; do
  for var in pet rnet; do
    echo ${var}; 
    emkdir -p ${ecfsdir}${scenariofolder}/${frequency}/${var}
  done  ; 
done