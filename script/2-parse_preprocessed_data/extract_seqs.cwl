cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["python3", "/root/amplicon-pipeline/script/2-parse_preprocessed_data/extract_seqs.py"]
inputs:
  merged_fasta:
    type: File
    inputBinding:
      position: 1

outputs:
  centroids_remove_tripleton: 
    type: File
    outputBinding:
      glob: centroids_remove_tripleton.fa
  result_removed_tripleton_with_ID: 
    type: File
    outputBinding:
      glob: result_removed_tripleton_with_ID.csv
  rename_list: 
    type: File
    outputBinding:
      glob: rename_list.csv
