#!/bin/sh
#$ -cwd
#$ -N remove_double 

python /home/kumay/amplicon-pipeline/script/python/remove_singleton_all_double.py vsearch_out
