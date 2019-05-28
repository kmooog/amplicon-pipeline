cwlVersion: v1.0
class: CommandLineTool
baseCommand: sed
arguments: ["'s/@/>/'"]
inputs:
  input:
    type: File
    inputBinding:
      position: 1
outputs:
  results: stdout



