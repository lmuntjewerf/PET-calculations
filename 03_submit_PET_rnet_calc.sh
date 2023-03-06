#!/bin/bash

# **************************** LM notes ****************************************
#
# Script for submitting the Rnet_PET calculation as a job
# Provide arguments in command line
#
# This scripts call calc_Rnet_PET.py via run_Rnet_PET_calc_args.sh
#
# Arguments: scenario letter (h or s), the three ensemble member numbers, the frequence (day or month)
#
#  How to run: 
#  sbatch ./03_submit_slurm.sh h 010 day
#  for i in {1..16}; do for j in {0..9}; do sbatch ./03_submit_slurm.sh h "$(printf "%02d" $i)"${j} day ; done; done 
#
#
# **************************** end LM notes ************************************
scenario=$1
member=$2
frequency=$3

#-------------------------------
# setting options for SLURM
#-------------------------------
# Options that are specified within the script file should precede the
# first executable shell command in the file.
# All options, which are case sensitive, are preceded by #SBATCH.
# These lines become active only when the script is submitted
# using the "sbatch" command.
# All job output is written to the workdir directory, by default.
 
 
#SBATCH --qos=nf
 
        # Specifies that your job will run in the queue (Quality Of
        # Service) "ef".
 
#SBATCH --job-name=rnet-pet
 
        # Assigns the specified name to the request
 
#SBATCH --output=out/rnet-pet.%j.out
 
        # Specifies the name and location of STDOUT where %j is the job-id
        # The file will be # written in the workdir directory if it is a
        # relative path. If not given, the default is slurm-%j.out in the
        # workdir.
 
#SBATCH --error=out/rnet-pet.%j.out
 
        # Specifies the name and location of STDERR where %j is the job-id
        # The file will be # written in the workdir directory if it is a
        # relative path. If not given, the default is slurm-%j.out in the
        # workdir.
 
#SBATCH --chdir=/scratch/nklm/
 
        # Sets the working directory of the batch script before it is
        # executed.

#SBATCH --time=24:00:00

 
 
#-------------------------------
# setting environment variables
#-------------------------------

export PATH=$PATH:.             # Allows you to run any of your programs or
                                # scripts held in the current directory (not
                                # required if already done in your .user_profile
                                # or .user_kshrc)
set -ev
 
#-------------------------------
# commands to be executed
#-------------------------------

cd /home/nklm/Px_drought/PET

./run_Rnet_PET_calc_args.sh $scenario $member $frequency