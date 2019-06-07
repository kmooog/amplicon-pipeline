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
  - id: db
    type: File
    'sbg:x': 194.66928100585938
    'sbg:y': 222.19114685058594
  - id: phix
    type: string
    'sbg:x': -223.34405517578125
    'sbg:y': -62.66566848754883
  - id: blastdb
    type: string
    'sbg:x': 886.5867919921875
    'sbg:y': 284.07550048828125
  - id: tax_map_db
    type: File
    'sbg:x': 1192.77099609375
    'sbg:y': -31.138456344604492
outputs:
  - id: tax_mapped_tsv
    outputSource:
      - tax_map/tax_mapped_tsv
    type: 'File[]'
    'sbg:x': 1620.6024169921875
    'sbg:y': 85.61833953857422
  - id: vsearch_out_file
    outputSource:
      - vsearch/vsearch_out_file
    type: 'File[]'
    'sbg:x': 865.1642456054688
    'sbg:y': 11.99949836730957
  - id: singleton_removed
    outputSource:
      - remove_singleton/singleton_removed
    type: File
    'sbg:x': 1051.8125
    'sbg:y': 310.15185546875
  - id: blast_out
    outputSource:
      - blast/blast_out
    type: File
    'sbg:x': 1237.9244384765625
    'sbg:y': 215.03489685058594
  - id: chimera_filtered
    outputSource:
      - uchime_filter/chimera_filtered
    type: File
    'sbg:x': 702.7150268554688
    'sbg:y': -43.58048629760742
  - id: uchime_out
    outputSource:
      - uchime/uchime_out
    type: File
    'sbg:x': 527.0778198242188
    'sbg:y': 318.7576599121094
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
  - id: prinseq
    in:
      - id: input
        source: bowtie2/bowtie_out
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
  - id: uchime
    in:
      - id: db
        source: db
      - id: file
        source: sed/sed_results
      - id: out
        default: uchime.result
    out:
      - id: uchime_out
    run: ./uchime.cwl
    'sbg:x': 402.75079345703125
    'sbg:y': 228.0128936767578
  - id: uchime_filter
    in:
      - id: fasta
        source: sed/sed_results
      - id: uchimeout
        source: uchime/uchime_out
    out:
      - id: chimera_filtered
    run: ./uchime_filter.cwl
    'sbg:x': 554.0096435546875
    'sbg:y': 77.7540283203125
  - id: sed
    in:
      - id: input
        source: awk/awk_results
    out:
      - id: sed_results
    run: ./sed.cwl
    'sbg:x': 322.2137145996094
    'sbg:y': 8.990326881408691
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
      - id: bowtie_out
    run: ./bowtie2.cwl
    'sbg:x': -102.98512268066406
    'sbg:y': 9.3588285446167
  - id: vsearch
    in:
      - id: file
        source: uchime_filter/chimera_filtered
      - id: vsearch_id
        default: '0.97'
      - id: vsearch_out1
        default: vsearch_out
      - id: vsearch_out2
        default: vsearch_out
    out:
      - id: vsearch_out_file
    run: ./vsearch.cwl
    'sbg:x': 740.3447265625
    'sbg:y': 158.96749877929688
  - id: remove_singleton
    in:
      - id: vsearch_out
        source:
          - vsearch/vsearch_out_file
    out:
      - id: singleton_removed
    run: ./remove_singleton.cwl
    'sbg:x': 892.5120849609375
    'sbg:y': 163.56808471679688
  - id: blast
    in:
      - id: blastdb
        source: blastdb
      - id: blastinput
        source: remove_singleton/singleton_removed
      - id: evalue
        default: '1e-5'
      - id: max_target_seqs
        default: '1'
      - id: outfile
        default: blast_result.tsv
      - id: outfmt
        default: '6'
    out:
      - id: blast_out
    run: ./blast.cwl
    'sbg:x': 1104.7105712890625
    'sbg:y': 88.17594909667969
  - id: tax_map
    in:
      - id: blast_out
        source: blast/blast_out
      - id: tax_map_db
        source: tax_map_db
    out:
      - id: tax_mapped_tsv
    run: ./tax_map.cwl
    'sbg:x': 1354.213623046875
    'sbg:y': 76.85502624511719
requirements: []
