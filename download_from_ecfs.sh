#!/bin/bash
#
# **************************** LM notes ****************************************
# SLUM Batch script adaped from https://confluence.ecmwf.int/display/UDOC/HPC2020%3A+ecfs1.sh
#
# For downloading LENTIS data from the ECFS 
# Provide arguments in command line
#
#  How to run: 
# sbatch ./download_from_ecfs.sh h 010 tas day
# for i in {1..16}; do for j in {0..9}; do sbatch ./download_from_ecfs.sh h "$(printf "%02d" $i)"${j} tas day ; done; done 
#
#
# **************************** end LM notes ************************************
scenario=$1
member=$2
variable=$3
frequency=$4


# **************************** LICENSE START ***********************************
#
# Copyright 2021 ECMWF. This software is distributed under the terms
# of the Apache License version 2.0. In applying this license, ECMWF does not
# waive the privileges and immunities granted to it by virtue of its status as
# an Intergovernmental Organization or submit itself to any jurisdiction.
#
# ***************************** LICENSE END ************************************
#
# ecfs1          USER SERVICES  NOVEMBER 2021 - ECMWF
#
#
#       This shell-script:
#
#            - executes a MARS request
#            - sets an ECFS directory
#            - archives the contents of a directory
#              (containing the output of the MARS request)
#            - lists the contents of the archived ECFS directory
#            - copies the ECFS directory back to a Unix directory
#
#       This shell script produces the standard output file
#
#          ecfs1.<JOB-ID>.out
#
#       in the workdir directory, containing the log of job execution.   
#
#
#-------------------------------
# setting options for SLURM
#-------------------------------
# Options that are specified within the script file should precede the
# first executable shell command in the file.
# All options, which are case sensitive, are preceded by #SBATCH.
# These lines become active only when the script is submitted
# using the "sbatch" command.
# All job output is written to the workdir directory, by default.
 
 
#SBATCH --qos=ef
 
        # Specifies that your job will run in the queue (Quality Of
        # Service) "ef".
 
#SBATCH --job-name=ecfs1
 
        # Assigns the specified name to the request
 
#SBATCH --output=out/ecfs1.%j.out
 
        # Specifies the name and location of STDOUT where %j is the job-id
        # The file will be # written in the workdir directory if it is a
        # relative path. If not given, the default is slurm-%j.out in the
        # workdir.
 
#SBATCH --error=out/ecfs1.%j.out
 
        # Specifies the name and location of STDERR where %j is the job-id
        # The file will be # written in the workdir directory if it is a
        # relative path. If not given, the default is slurm-%j.out in the
        # workdir.
 
#SBATCH --chdir=/scratch/nklm/LENTIS/
 
        # Sets the working directory of the batch script before it is
        # executed.
 

 
 
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

els -l ec:/nklm/LENTIS/ec-earth/cmorised_by_var/${scenario}xxx/${frequency}/${variable}/${scenario}${member}_${frequency}_${variable}.tar.gz

ecp ec:/nklm/LENTIS/ec-earth/cmorised_by_var/${scenario}xxx/${frequency}/${variable}/${scenario}${member}_${frequency}_${variable}.tar.gz $SCRATCH/LENTIS/.

 
#-------------------------------
# ECFS commands                 # (for more information type: man ecfs)
#-------------------------------
 
#epwd ec:                        # Show the current ECFS working directory in
                                # the specified domain ('ec:/uid' by default).
 
#ecd ec:                         # Set the environment variable ECDIR used to
                                # maintain the current ec: working directory
                                # for ECFS to the path specified
                                # (default value '/uid').
 
#els -l ec:                      # Show the contents of the ECFS directory
                                # ec:/uid. The leading characters * b - indicate
                                # the following:
                                #   *:  file in TSM
                                #   b:  file in HPSS with backup
                                #   -:  file in HPSS without backup
 
#emkdir ec:batch_ex1             # Create the ECFS directory
                                # ec:/uid/batch_ex1.
 
#ecp * ec:batch_ex1              # Copy the contents of the current working
                                # directory ($SCRATCHDIR) to the ECFS
                                # directory ec:/uid/batch_ex1.
                                # If the target directory does not exist
                                # it is created automatically.
                                # It is possible to use wild characters
                                # (* , ? ) in the specification of the
                                # filenames to be copied.
 
#els -l ec:                      # Show the contents of the ECFS directory
                                # ec:/uid. After the execution of the previous
                                # command the directory ec:/uid/batch_ex1
                                # is present.
 
#els -l ec:batch_ex1             # Show the contents of the ECFS directory
                                # ec:/uid/batch_ex1.
 
 
#ecp ec:batch_ex1/* $SCRATCHDIR/batch_ex1
 
                                # Retrieve the contents of the ECFS directory
                                # ec:/uid/batch_ex1 and put it in a
                                # directory $SCRATCHDIR/batch_ex1.
                                # If the target directory does not exist
                                # it is created automatically.
 
#ls -al $SCRATCHDIR/batch_ex1
                                # Show the contents of the directory
                                # $SCRATCHDIR/batch_ex1.
   
#ecd ec:batch_ex1                # Change ECFS working directory to
                                # ec:/uid/batch_ex1.
 
#erm ec:*                        # Remove the contents of the ECFS directory
                                # ec:/uid/batch_ex1.
 
#els -l ec:                      # Show the contents of the ECFS directory
                                # ec:/uid/batch_ex1.
 
#ecd ..                          # Change ECFS working directory back
                                # to parent directory.
 
#ermdir ec:batch_ex1             # Remove the ECFS directory ec:/uid/batch_ex1.
 
 
#-------------------------------
# tidy up by deleting unwanted files
#-------------------------------
# This is done automatically when using $SCRATCHDIR.
 
exit 0
 
# End of example job 'ecfs1'
