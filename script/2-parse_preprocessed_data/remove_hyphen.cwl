class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - python3
  - /root/amplicon-pipeline/script/2-parse_preprocessed_data/remove_hyphen.py
inputs:
  - id: centroids_remove_tripleton
    type: File
    inputBinding:
      position: 1
outputs:
  - id: centroids_remove_tripleton_hyphen_removed
    type: File
    outputBinding:
      glob: centroids_remove_tripleton_hyphen_removed.fa
