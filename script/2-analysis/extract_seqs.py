from Bio import SeqIO
import sys 

argvs = sys.argv
vsearch_msa = argvs[1]

count_cluster_size = 0
tmp_clusters = ["",""]
tmp_cluster_members = []
out_fasta = open("centroids_remove_tripleton.fa","w")
out_tmp = open("removed_3","w")
max_num = 0

for record in SeqIO.parse(open(vsearch_msa), "fasta"):
   if str(record.id) != "consensus":
      if int(record.id.replace("*","").replace(">","")[0:3]) > max_num:
         max_num = int(record.id.replace("*","").replace(">","")[0:3])
      if record.id.find("*") != -1:
         if count_cluster_size > 3:
            out_fasta.write(">" + tmp_clusters[0] + "\n")
            out_fasta.write(tmp_clusters[1] + "\n")
            for tmp in tmp_cluster_members:
               out_tmp.write(tmp + "\n")
         tmp_clusters = ["",""]
         count_cluster_size = 1
         tmp_clusters[0] = str(record.id)
         tmp_clusters[1] = str(record.seq)
         tmp_cluster_members = [str(record.id)]
      else:
         count_cluster_size += 1
         tmp_cluster_members.append(str(record.id))

if count_cluster_size > 3:
   out_fasta.write(">" + tmp_clusters[0] + "\n")
   out_fasta.write(tmp_clusters[1] + "\n")
   for tmp in tmp_cluster_members:
      out_tmp.write(tmp + "\n")


tmprange = range(0,max_num)
ab_list = [[] for i in tmprange]
cluster_id = 0
for a in open("removed_3"):
   if len(a) > 1:
      sample_id = ""
      if a[0] == "*":
         sample_id = a[1:4]
         for i in tmprange:
            ab_list[i].append(0)
         ab_list[int(sample_id) - 1][-1] += 1
         cluster_id += 1
         #if cluster_id < 100:
         #   print ("{0} % is done!".format(cluster_id / 164010 * 100))
         #   print(ab_list)
         if cluster_id %10000 == 0:
            print ("{0} % is done!".format(cluster_id / 164010  * 100))
            print(str(len(ab_list)))
            print(str(len(ab_list[0])))
      else:
         sample_id = a[0:3]
         ab_list[int(sample_id) - 1][-1] += 1
print("file read! start normalize")
#for i in tmprange:
#   ab_list[i] = [t / sum(ab_list[i]) for t in ab_list[i]]
#ab_list = [[t * 1.0 / sum(ab_list[i]) for t in ab_list[i]] for i in tmprange]
print("start output")

out = open("result_removed3.csv", "w")
out.write(','.join([str(i+1).zfill(3) for i in tmprange]))
out.write("\n")

for s in range(len(ab_list[0])):
   tmplist = []
   for i in tmprange:
      tmplist.append(ab_list[i][s])
   out.write(','.join([str(i) for i in tmplist]))
   out.write('\n')
