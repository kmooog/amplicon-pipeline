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
  - id: db
    type: File
    'sbg:x': -173.021484375
    'sbg:y': 350.3230895996094
outputs:
  - id: uchime_out
    outputSource:
      - uchime/uchime_out
    type: File
    'sbg:x': 211.48309326171875
    'sbg:y': 231.94369506835938
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
    'sbg:x': 46.614017486572266
    'sbg:y': 7.116480827331543
  - id: awk
    in:
      - id: file
        source: prinseq/prinseq_out
    out:
      - id: awk_results
    run: ./awk.cwl
    'sbg:x': 161.02073669433594
    'sbg:y': 7.095749855041504
  - id: sed
    in:
      - id: input
        source: awk/awk_results
    out:
      - id: awk_results
    run: ./sed.cwl
    'sbg:x': 274.4481506347656
    'sbg:y': 7.137210845947266
  - id: uchime
    in:
      - id: db
        source: db
      - id: file
        source: sed/awk_results
      - id: out
        default: uchime.result
    out:
      - id: uchime_out
    run: ./uchime.cwl
    'sbg:x': 34.950111389160156
    'sbg:y': 232.34693908691406
requirements: []
