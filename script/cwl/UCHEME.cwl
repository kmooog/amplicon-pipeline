cwlVersion: v1.0
class: CommandLineTool
baseCommand: ~/uchime4.2.40_i86linux32
arguments: ["--dont_gzip"]
inputs:
  file:
    type: File
    inputBinding:
      position: 1
      prefix: --input
  db:
    type: File
    inputBinding:
      position: 2
      prefix: --db
  out:
    type: string
    inputBinding:
      position: 3
      prefix: --uchimeout

outputs:
  tg_out1:
    type: File
    outputBinding:
      glob: 'results.uchime'
