cwlVersion: v1.0
class: CommandLineTool
baseCommand: sed
arguments: ["'s/@/>/'"]
stdout: sedout.txt
inputs:
  input:
    type: File
    inputBinding:
      position: 1
outputs:
  awk_results: 
    type: stdout
