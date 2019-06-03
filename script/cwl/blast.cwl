cwlVersion: v1.0
class: CommandLineTool
baseCommand: /root/ncbi-blast-2.9.0+/bin/blastn
arguments: [-outfmt 6 -out blast_result.tsv -evalue 1e-5]
inputs:
  blastdb:
    type: string
    inputBinding:
      position: 1
      prefix: -db 
  blastinput:
    type: File
    inputBinding:
      position: 2
      prefix: -query
outputs:
  blast_out:
    type: File
    outputBinding:
      glob: blast_result.tsv
      
      

