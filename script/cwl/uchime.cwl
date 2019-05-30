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

outputs:
  tg_out1:
    type: File
    outputBinding:
      glob: 'results.uchime'
