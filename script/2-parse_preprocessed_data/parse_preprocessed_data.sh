#!/bin/sh
#$ -cwd
#$ -N amplicon-pipeline-2
module load singularity
singularity exec /home/kumay/test_container/amplicon-pipeline-latest.img cwl-runner ~/amplicon-pipeline/script/2-parse_preprocessed_data/parse_preprocessed_data.cwl --merged_fasta all_amplicon_seqs.fa --blastdb_dir /home/kumay/database/  --blastdb SILVA_132_SSURef_tax_silva.fasta --taxmap /home/kumay/database/taxmap_slv_ssu_ref_132.txt
