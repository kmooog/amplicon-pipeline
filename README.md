# Requirements

This pipeline is for UGE server with Singularity container environment. Docker also may work, but never tested.
If your server use different job scheduler, please edit wrapper scripts (`preprocessing_amplicon_all.sh` and `parse_preprocessed_data.sh`).

# Run scripts

## preprocessing

- Edit file paths in `/amplicon-pipeline/script/1-preproccess/preprocessing_amplicon_all.sh` for your system.
- Please prepare illumina paired end files on your current directory like this. This pipeline is for ~999 samples.
  - `1_1.fq.gz`, `1_2.fq.gz`, `2_1.fq.gz`, `2_2.fq.gz`..., `100_2.fq.gz`
- Run `sh /path/to/script/preprocessing_amplicon_all.sh 1 100` (100 is just an example.)
- Merge output files ``for i in `seq -f %03g 1 721`;do cat ${i}/chimera_filtered.fa | sed s/\>/\>${i}_/g >> all_amplicon_seqs.fa; done``  

## OTU clustering, taxonomy mapping (using SILVA database)

- Put `all_amplicon_seqs.fa` (result of preprocessing) in your current directory.
- Download SILVA database (`SILVA_132_SSURef_tax_silva.fasta` and `taxmap_slv_ssu_ref_132.txt`) from https://www.arb-silva.de/download/archive/
- Edit file paths in `/amplicon-pipeline/script/2-parse_preprocessed_data/parse_preprocessed_data.sh` for your system.
- Run `qsub /path/to/script/parse_preprocessed_data.sh`.
