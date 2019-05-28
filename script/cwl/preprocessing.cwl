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
  - id: uchimeDB
    type: string
    'sbg:x': -241
    'sbg:y': -99
  - id: db
    type: File
    'sbg:x': -89.68148803710938
    'sbg:y': 297.21234130859375
outputs:
  - id: vsearch_out
    outputSource:
      - _v_s_e_a_r_c_h/vsearch_out1
    type: File
    'sbg:x': 649.3626098632812
    'sbg:y': 125.9189224243164
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
    'sbg:x': -168
    'sbg:y': 113
  - id: bowtie2
    in:
      - id: bowtie_log
        default: bowtie_log
      - id: filename
        source: flash/flash_out
      - id: phix
        source: uchimeDB
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
    'sbg:x': 54.320674896240234
    'sbg:y': -1
  - id: _u_c_h_e_m_e
    in:
      - id: db
        source: db
      - id: file
        source: prinseq/prinseq_out
      - id: out
        default: results.uchime
    out:
      - id: tg_out1
    run: ./UCHEME.cwl
    'sbg:x': 55.49169921875
    'sbg:y': 223.9887237548828
  - id: sed
    in:
      - id: input
        source: awk/results
    out:
      - id: results
    run: ./sed.cwl
    'sbg:x': 324.8255310058594
    'sbg:y': 161.04556274414062
  - id: awk
    in:
      - id: input
        source: _u_c_h_e_m_e/tg_out1
    out:
      - id: results
    run: ./awk.cwl
    'sbg:x': 185.3628692626953
    'sbg:y': 194.79324340820312
  - id: _v_s_e_a_r_c_h
    in:
      - id: file
        source: sed/results
      - id: vsearch_id
        default: '0.97'
      - id: vsearch_out1
        default: vsearch_out
      - id: vsearch_out2
        default: vsearch_out
    out:
      - id: vsearch_out1
    run: ./VSEARCH.cwl
    'sbg:x': 493.625732421875
    'sbg:y': 123
requirements: []
