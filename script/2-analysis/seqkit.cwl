cwlVersion: v1.0
class: CommandLineTool
baseCommand: seqkit
arguments: ["fq2fa"]
inputs:
  input:
    type: File
    inputBinding:
      position: 1
  output:
    type: string
    inputBinding:
      position: 2
      prefix: -o

outputs:
  fasta: 
    type: File
    outputBinding:
      glob: all.fa