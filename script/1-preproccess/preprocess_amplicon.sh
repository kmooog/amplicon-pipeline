#!/bin/sh
#$ -cwd
#$ -N amplicon-1-preproccess
module load singularity
singularity exec /home/kumay/test_container/amplicon-pipeline-latest.img cwltool /root/amplicon-pipeline/script/1-preproccess/amplicon_preprocess_workflow.cwl --file1 ${1}_1.fq.gz --file2 ${1}_2.fq.gz --db /home/kumay/gold/gold.fa --phix /home/kumay/amplicon-pipeline/util-data/phix
