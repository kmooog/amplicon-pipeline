class: Workflow
cwlVersion: v1.0
id: analysis
label: Analysis
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: taxmap
    type: File
    'sbg:x': 84.73381042480469
    'sbg:y': -238.82733154296875
  - id: blastdb
    type:
      - string
      - type: array
        items: string
    'sbg:x': -144
    'sbg:y': 138
  - id: blastdb_dir
    type:
      - Directory
      - type: array
        items: Directory
    'sbg:x': -171
    'sbg:y': 20
  - id: merged_fasta
    type: File
    'sbg:x': -424.765625
    'sbg:y': -98.5
outputs:
  - id: result_removed_tripleton_with_ID
    outputSource:
      - extract_seqs/result_removed_tripleton_with_ID
    type: File
    'sbg:x': -262.2182922363281
    'sbg:y': -310.64324951171875
  - id: rename_list
    outputSource:
      - extract_seqs/rename_list
    type: File
    'sbg:x': -36.83453369140625
    'sbg:y': -265.94964599609375
  - id: centroids_remove_tripleton
    outputSource:
      - extract_seqs/centroids_remove_tripleton
    type: File
    'sbg:x': -265.7366027832031
    'sbg:y': 115.30303192138672
  - id: blast_out
    outputSource:
      - blast/blast_out
    type: File
    'sbg:x': 108
    'sbg:y': 26
  - id: OTU_taxon
    outputSource:
      - tax_map/OTU_taxon
    type: File
    'sbg:x': 350.6017761230469
    'sbg:y': -104.72566223144531
steps:
  - id: extract_seqs
    in:
      - id: merged_fasta
        source: merged_fasta
    out:
      - id: centroids_remove_tripleton
      - id: rename_list
      - id: result_removed_tripleton_with_ID
    run: ./extract_seqs.cwl
    'sbg:x': -274
    'sbg:y': -98
  - id: blast
    in:
      - id: blastdb
        source: blastdb
      - id: blastdb_dir
        source: blastdb_dir
      - id: blastinput
        source: extract_seqs/centroids_remove_tripleton
      - id: evalue
        default: '1e-15'
      - id: max_target_seqs
        default: '1'
      - id: num_threads
        default: '10'
      - id: outfile
        default: blast_out
      - id: outfmt
        default: '6'
    out:
      - id: blast_out
    run: ./blast.cwl
    'sbg:x': -29
    'sbg:y': 23
  - id: tax_map
    in:
      - id: blast_result
        source: blast/blast_out
      - id: rename_list
        source: extract_seqs/rename_list
      - id: taxmap
        source: taxmap
    out:
      - id: OTU_taxon
    run: ./tax_map.cwl
    'sbg:x': 188.3510284423828
    'sbg:y': -104.6755142211914
requirements: []
