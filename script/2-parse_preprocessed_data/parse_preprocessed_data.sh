#!/bin/sh
#$ -cwd
#$ -N amplicon-pipeline-2
module load singularity
singularity exec /home/kumay/test_container/amplicon-pipeline-latest.img cwltool /root/amplicon-pipeline/script/2-parse_preprocessed_data/amplicon_analysis_workflow.cwl --merged_fasta all_amplicon_seqs.fa
