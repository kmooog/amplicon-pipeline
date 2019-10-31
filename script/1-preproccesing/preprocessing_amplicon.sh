#!/bin/sh
#$ -cwd
#$ -N meta_p
module load singularity
singularity exec /home/kumay/test_container/amplicon-pipeline-latest.img cwltool /root/amplicon-pipeline/script/1-preproccesing/amplicon_preprocessing_workflow.cwl --file1 ${1}_1.fq.gz --file2 ${1}_2.fq.gz --db /home/kumay/gold/gold.fa --phix /home/kumay/amplicon-pipeline/util-data/phix --blastdb /home/kumay/database/SILVA_132_SSURef_tax_silva.fasta --tax_map_db /home/kumay/database/taxmap_slv_ssu_ref_132.txt
