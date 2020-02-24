from Bio import SeqIO
import sys
from pathlib import Path

p = Path("/home/kumay/metagenome_data/amplicon_all/")
files = list(p.glob("vsearch_out*"))

remove_file = Path("/home/kumay/metagenome_data/amplicon_all/vsearch_out")
files.remove(remove_file)

cluster_seq_dict = {} # seq -> cluster

with open("all_OTUs","w") as out:
   for i,a in enumerate(files):
      with open(a, "r") as handle:
         count = 0
         for record in SeqIO.parse(handle, "fasta"):
            out.write(str(a).replace("vsearch_out","").split("/")[-1] + "\t" + str(record.id) + "\n")


