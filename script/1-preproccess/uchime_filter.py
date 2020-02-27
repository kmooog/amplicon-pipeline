import sys 

argvs = sys.argv

uchemeout = sys.argv[1]
fasta = sys.argv[2]
not_chimera_list = []
output = open("chimera_filtered.fa","w")

for ucheme_line in open(uchemeout):
	tmplist = ucheme_line.strip().split("\t")
	tag = tmplist[1]
	chimera_or_not = tmplist[-1]
	if chimera_or_not == "N":
		not_chimera_list.append(tag)

flag = False

for fasta_line in open(fasta):
	fasta_line = fasta_line.strip()
	if fasta_line[0] == ">" :
		if fasta_line.replace(">","") in not_chimera_list:
			output.write(fasta_line + "\n")
			flag = True
		else:
			flag = False
	elif flag == True:
		output.write(fasta_line + "\n")
output.close()





