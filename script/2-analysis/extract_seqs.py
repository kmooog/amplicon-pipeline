from Bio import SeqIO


seqlist = []


for a in open("removed_3"):
   if a.find("*") != -1:
      seqlist.append(a.strip())
print("finish reading a file")
count = 0
print(len(seqlist))
with open("vsearch_out.msa", "r") as handle:
   out = open("centroids_remove_tripleton.fa","w")
   for record in SeqIO.parse(handle, "fasta"):
      if seqlist[count] ==  str(record.id):
         #seqlist.remove(str(record.id))
         if count < len(seqlist) - 1:
            count +=1
         if count % 1000 == 0:
            print(count) 
         out.write(">"+str(record.id)+"\n")
         out.write(str(record.seq).replace("-","")+"\n")