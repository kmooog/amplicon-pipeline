import sys 

argvs = sys.argv

vsearch_out = sys.argv[1]

output = open("doubleton_removed.fa","w")
centroids = []
flag = False
i = 0

for vsearch_centroids in open(vsearch_out):
	vsearch_centroids = vsearch_centroids.strip()
	if vsearch_centroids[0] == ">":
		with open(vsearch_out + str(i)) as f:
			clusters = f.read()
			cluster_num = clusters.count(">")
			if cluster_num > 2:
				flag = True
				output.write(">" + str(cluster_num) + "_" + vsearch_centroids.replace(">","") + "\n")
			else:
				flag = False
		i += 1
	elif flag == True:
		output.write(vsearch_centroids + "\n")
