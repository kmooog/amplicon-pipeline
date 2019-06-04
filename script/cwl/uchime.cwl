cwlVersion: v1.0
class: CommandLineTool
baseCommand: /root/uchime4.2.40_i86linux32
inputs:
  file:
    type: File
    inputBinding:
      position: 1
      prefix: --input
  out:
    type: string
    inputBinding:
      position: 3
      prefix: --uchimeout
  db:
    type: File
    inputBinding:
      position: 2
      prefix: --db
outputs:
  uchime_out:
    type: File
    outputBinding:
      glob: 'uchime.result'
