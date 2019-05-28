cwlVersion: v1.0
class: CommandLineTool
baseCommand: awk
arguments: ["'(NR - 1) % 4 < 2'"]
inputs:
  input:
    type: File
    inputBinding:
      position: 1
outputs:
  results: stdout

