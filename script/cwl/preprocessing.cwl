class: Workflow
cwlVersion: v1.0
id: preprocessing
label: PreProcessing
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: file1
    type: File
    'sbg:x': -565
    'sbg:y': 191.14759826660156
  - id: file2
    type: File
    'sbg:x': -561
    'sbg:y': -33
  - id: phix
    type: string
    'sbg:x': -241
    'sbg:y': -99
  - id: uchime_db
    type: File
    'sbg:x': -334.9885559082031
    'sbg:y': 315.44915771484375
outputs:
  - id: vsearch_out_file
    outputSource:
      - vsearch/vsearch_out_file
    type: File
    'sbg:x': 557.50537109375
    'sbg:y': 206.38201904296875
steps:
  - id: trimgalore
    in:
      - id: file1
        source: file1
      - id: file2
        source: file2
    out:
      - id: tg_out1
      - id: tg_out2
    run: ./trimgalore.cwl
    'sbg:x': -387.7679443359375
    'sbg:y': 99.3417739868164
  - id: flash
    in:
      - id: file1
        source: trimgalore/tg_out1
      - id: file2
        source: trimgalore/tg_out2
    out:
      - id: flash_out
    run: ./flash.cwl
    'sbg:x': -236.87680053710938
    'sbg:y': 100.70056915283203
  - id: bowtie2
    in:
      - id: bowtie_log
        default: bowtie_log
      - id: filename
        source: flash/flash_out
      - id: phix
        source: phix
      - id: unmapped
        default: unmapped.fq
    out:
      - id: flash_out
    run: ./bowtie2.cwl
    'sbg:x': -83.16877746582031
    'sbg:y': 6.438818454742432
  - id: prinseq
    in:
      - id: input
        source: bowtie2/flash_out
      - id: lc_method
        default: dust
      - id: lc_threshold
        default: '7'
      - id: output
        default: prinseq_out
    out:
      - id: prinseq_out
    run: ./prinseq.cwl
    'sbg:x': 30.464506149291992
    'sbg:y': 63.068843841552734
  - id: uchime
    in:
      - id: db
        source: uchime_db
      - id: file
        source: prinseq/prinseq_out
      - id: out
        default: results.uchime
    out:
      - id: tg_out1
    run: ./uchime.cwl
    'sbg:x': -109.81233215332031
    'sbg:y': 236.52935791015625
  - id: vsearch
    in:
      - id: file
        source: sed/awk_results
      - id: vsearch_id
        default: '0.97'
      - id: vsearch_out1
        default: vsearch_out
      - id: vsearch_out2
        default: vsearch_out
    out:
      - id: vsearch_out_file
    run: ./vsearch.cwl
    'sbg:x': 373.4743347167969
    'sbg:y': 211.10076904296875
  - id: awk
    in:
      - id: file
        source: uchime/tg_out1
    out:
      - id: awk_results
    run: ./awk.cwl
    'sbg:x': 76.54421997070312
    'sbg:y': 237.54876708984375
  - id: sed
    in:
      - id: input
        source: awk/awk_results
    out:
      - id: awk_results
    run: ./sed.cwl
    'sbg:x': 207.5487518310547
    'sbg:y': 235.8321990966797
requirements: []
