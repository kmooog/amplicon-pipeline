cwlVersion: v1.0
class: CommandLineTool
baseCommand: cat
arguments: ["(NR - 1) % 4 < 2"]
inputs:
  file:
    type: File
    inputBinding:
      position: 1
outputs:
  awk_results:
    type: stdout
stdout: awkout.txt
