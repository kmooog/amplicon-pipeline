
import sys
sys.path.append("/usr/local/lib/python3.6/dist-packages")
from Bio import SeqIO

with open("centroids_remove_tripleton_hyphen_removed.fa","w") as out:
   for record in SeqIO.parse(open("centroids_remove_tripleton.fa"), "fasta"):
      tmpstr = str(record.id)
      tmpseq = str(record.seq).replace("-","N")
      out.write(">" + tmpstr + "\n" + tmpseq + "\n")
