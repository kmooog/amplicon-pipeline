#!/bin/sh
#$ -cwd
#$ -N profile_OTU 
module load singularity
singularity exec /usr/local/biotools/b/biopython:1.70--np112py36_1 python /home/kumay/amplicon-pipeline/script/python/profile_OTU.py
