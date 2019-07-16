#!/bin/sh
#$ -cwd
#$ -N remove_triple

python /home/kumay/amplicon-pipeline/script/python/remove_singleton_all_triple.py vsearch_out
