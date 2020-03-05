cwlVersion: v1.0
class: CommandLineTool
baseCommand: /root/ncbi-blast-2.10.0+/bin/blastn
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.blastdb_dir)
        writable: False

inputs:
  blastdb_dir:
    type: Directory?
  blastdb:
    type: string?
    inputBinding:
      prefix: -db
      valueFrom: $(inputs.blastdb_dir.path)/$(inputs.blastdb)
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
      
      

