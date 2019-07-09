#!/bin/sh
#$ -cwd
#$ -N meta_p
module load singularity
singularity exec /home/kumay/test_container/amplicon-pipeline-latest.img vsearch --cluster_size all_amplicon_seqs.fa --centroid vsearch_out --clusters vsearch_out --id 0.97 
