cwlVersion: v1.0
class: CommandLineTool
baseCommand: /root/ncbi-blast-2.9.0+/bin/blastn
inputs:
  blastdb:
    type: string
    inputBinding:
      prefix: -db 
  blastinput:
    type: File
    inputBinding:
      prefix: -query
  outfmt:
    type: string
    inputBinding:
      prefix: -outfmt 
  outfile:
    type: string
    inputBinding:
      prefix: -out 
  evalue:
    type: string
    inputBinding:
      prefix: -evalue
  max_target_seqs:
    type: string
    inputBinding:
      prefix: -max_target_seqs
  num_threads:
    type: string
    inputBinding:
      prefix: -num_threads

outputs:
  blast_out:
    type: File
    outputBinding:
      glob: blast_result.tsv
      
      

