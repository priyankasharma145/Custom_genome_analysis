######################################################
# Bash script loop_map.sh to loop through fastq files and send Map jobs
# using input file arguments.sh
# Last update: 2018_01_12
# cpacyna
######################################################

#! /bin/bash
#$ -l mem_free=3G
#$ -l h_vmem=3G
#$ -l h_fsize=500G
#$ -m e
#$ -M priyanka_sharma@DFCI.HARVARD.EDU

#Load arguments

# activate environment


# Set the number of threads
export OMP_NUM_THREADS=6

qsub -cwd -V trimming.sh   


