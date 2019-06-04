import sys 

argvs = sys.argv

vsearch_out = sys.argv[1]

output = open("singleton_removed.fa","w")
centroids = []
flag = False
i = 0

for vsearch_centroids in open(vsearch_out):
	vsearch_centroids = vsearch_centroids.strip()
	if vsearch_centroids[0] == ">":
		with open(sys.argv[i + 2]) as f:
			clusters = f.read()
			if clusters.count(">") > 1:
				flag = True
				output.write(">" + str(i) + "_" + vsearch_centroids.replace(">","") + "\n")
			else:
				flag = False
		i += 1
	elif flag == True:
		output.write(vsearch_centroids + "\n")
