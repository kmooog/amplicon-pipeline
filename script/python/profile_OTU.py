from Bio import SeqIO
import sys
from pathlib import Path

p = Path("/home/kumay/metagenome_data/amplicon_all/")
files = list(p.glob("vsearch_out*"))

remove_file = Path("/home/kumay/metagenome_data/amplicon_all/vsearch_out")
files.remove(remove_file)

cluster_seq_dict = {} # seq -> cluster

ID_list = []

with open("chimera_filtered.fa", "r") as handle:
   for record in SeqIO.parse(handle, "fasta"):
      ID_list.append(str(record.id))


with open("OTUs","w") as out:
   for i,a in enumerate(files):
      with open(a, "r") as handle:
         count = 0
         for record in SeqIO.parse(handle, "fasta"):
            if str(record.id) in ID_list:
               count += 1
         out.write(str(a).split("/")[-1].replace("vsearch_out","") + "," + str(count) + "\n")
      if (i % 100000) == 0:
         print (i)


