# preprocessing

- Edit file paths in `preprocessing_amplicon_all.sh` for your system.
- Please prepare illumina paired end files on your current directory like this. This pipeline is for ~999 samples.
  - `1_1.fq.gz`, `1_2.fq.gz`, `2_1.fq.gz`, `2_2.fq.gz`..., `100_2.fq.gz`
- Run `sh /path/to/script/preprocessing_amplicon_all.sh 1 100` (100 is just an example.)
- Merge output files ``for i in `seq -f %03g 1 721`;do cat ${i}/chimera_filtered.fa | sed s/\>/\>${i}_/g >> all_amplicon_seqs.fa; done``  

# parse_preprocessed_data

- Edit file paths in `parse_preprocessed_data.sh` for your system.
- Run `sh /path/to/script/parse_preprocessed_data.sh` 
