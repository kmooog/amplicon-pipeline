class: Workflow
cwlVersion: v1.0
id: parce_preprocessed_data
label: parce_preprocessed_data.cwl
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: merged_fasta
    type: File
    'sbg:x': -684.3931274414062
    'sbg:y': 27
  - id: blastdb_dir
    type: Directory?
    'sbg:x': -249.3931121826172
    'sbg:y': 155.0003662109375
  - id: blastdb
    type: string?
    'sbg:x': -201
    'sbg:y': 313
  - id: taxmap
    type: File
    'sbg:x': -31.885332107543945
    'sbg:y': -177.75778198242188
outputs:
  - id: centroid
    outputSource:
      - vsearch/centroid
    type: File
    'sbg:x': -410.3930969238281
    'sbg:y': 326.9978332519531
  - id: msaout
    outputSource:
      - vsearch/msaout
    type: File
    'sbg:x': -467.3930969238281
    'sbg:y': -153.00216674804688
  - id: centroids_remove_tripleton
    outputSource:
      - extract_seqs/centroids_remove_tripleton
    type: File
    'sbg:x': -355.3930969238281
    'sbg:y': 202.99783325195312
  - id: rename_list
    outputSource:
      - extract_seqs/rename_list
    type: File
    'sbg:x': -148.1865234375
    'sbg:y': -72.5906753540039
  - id: result_removed_tripleton_with_ID
    outputSource:
      - extract_seqs/result_removed_tripleton_with_ID
    type: File
    'sbg:x': -255.3931121826172
    'sbg:y': -260.9996337890625
  - id: OTU_taxon
    outputSource:
      - tax_map/OTU_taxon
    type: File
    'sbg:x': 249.20274353027344
    'sbg:y': -22.317363739013672
steps:
  - id: vsearch
    in:
      - id: merged_fasta
        source: merged_fasta
    out:
      - id: centroid
      - id: msaout
    run: ./vsearch.cwl
    'sbg:x': -507
    'sbg:y': 26
  - id: extract_seqs
    in:
      - id: merged_fasta
        source: vsearch/msaout
    out:
      - id: centroids_remove_tripleton
      - id: rename_list
      - id: result_removed_tripleton_with_ID
    run: ./extract_seqs.cwl
    'sbg:x': -362
    'sbg:y': 8
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
    'sbg:x': -111
    'sbg:y': 149
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
    'sbg:x': 103.23834228515625
    'sbg:y': -22.585493087768555
requirements: []
