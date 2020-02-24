#!/bin/sh
#$ -cwd
#$ -N meta_p
module load singularity
singularity exec /home/kumay/test_container/amplicon-pipeline-latest.img vsearch --cluster_fast all_amplicon_seqs.fa --sizeout --centroid vsearch_out --msaout vsearch_out.msa --id 0.97 

