cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["python", "/root/amplicon-pipeline/script/2-parse_preprocessed_data/tax_map.py"]
inputs:
  taxmap:
    type: File
    inputBinding:
      position: 1
      prefix: -taxmap
  rename_list:
    type: File
    inputBinding:
      position: 1
      prefix: -rename_list
  blast_result:
    type: File
    inputBinding:
      position: 1
      prefix: -blast_result


outputs:
  OTU_taxon: 
    type: File
    outputBinding:
      glob: OTU_taxon
