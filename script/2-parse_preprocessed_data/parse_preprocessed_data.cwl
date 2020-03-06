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
    type: Directory
    'sbg:x': -237.0044708251953
    'sbg:y': 187.9877166748047
  - id: blastdb
    type: string
    'sbg:x': -171.01116943359375
    'sbg:y': 298.0055847167969
  - id: taxmap
    type: File
    'sbg:x': -38.49720764160156
    'sbg:y': -118.52177429199219
outputs:
  - id: centroid
    outputSource:
      - vsearch/centroid
    type: File
    'sbg:x': -411.4994201660156
    'sbg:y': 336.49609375
  - id: msaout
    outputSource:
      - vsearch/msaout
    type: File
    'sbg:x': -431.0133972167969
    'sbg:y': -129.00892639160156
  - id: centroids_remove_tripleton
    outputSource:
      - extract_seqs/centroids_remove_tripleton
    type: File
    'sbg:x': -346.00335693359375
    'sbg:y': 221.49273681640625
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
    'sbg:x': -232.5083770751953
    'sbg:y': -210.51841735839844
  - id: OTU_taxon
    outputSource:
      - tax_map/OTU_taxon
    type: File
    'sbg:x': 162.03237915039062
    'sbg:y': -84.97655487060547
steps:
  - id: vsearch
    in:
      - id: merged_fasta
        source: merged_fasta
      - id: out_centroid
        default: vsearch_out
      - id: out_msa
        default: vsearch_out.msa
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
        source: remove_hyphen/centroids_remove_tripleton_hyphen_removed
      - id: evalue
        default: '1e-15'
      - id: max_target_seqs
        default: '1'
      - id: num_threads
        default: '10'
      - id: outfile
        default: blast_result.tsv
      - id: outfmt
        default: '6'
    out:
      - id: blast_out
    run: ./blast.cwl
    'sbg:x': -43.52511978149414
    'sbg:y': 132.50613403320312
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
    'sbg:x': 44.52177047729492
    'sbg:y': 12.487160682678223
  - id: remove_hyphen
    in:
      - id: centroids_remove_tripleton
        source: extract_seqs/centroids_remove_tripleton
    out:
      - id: centroids_remove_tripleton_hyphen_removed
    run: ./remove_hyphen.cwl
    'sbg:x': -244.59251403808594
    'sbg:y': 66.13996887207031
requirements: []
