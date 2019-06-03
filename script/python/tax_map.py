import sys 

argvs = sys.argv

blast_result = sys.argv[1]
db = sys.argv[2]

kingdom = open("kingdom_mapped","w")
phylum = open("phylum_mapped","w")
classs = open("class_mapped","w")
order = open("order_mapped","w")
family = open("family_mapped","w")
genus = open("genus_mapped","w")

output_file_list = [kingdom, phylum, classs, order, family, genus]

db_dict = {}

kingdom_dict = {}
phylum_dict = {}
class_dict = {}
order_dict = {}
family_dict = {}
genus_dict = {}

for db_line in open(db):
	if db_line.split()[0] != "primaryAccession" and db_line.strip().split("\t")[3][:-1].split(";")[0] in ["Bacteria","Archaea"]:
		#Bacteria かArchaeaでFilterの必要
		db_list = db_line.strip().split("\t")
		tax_id = db_list[0]
		tax = db_list[3][:-1]
		tax_annotated_list = tax.split(";")
		for i in range(6-len(tax_annotated_list)):
			tax_annotated_list.append("unidentified")
		kingdom_dict[tax_id] = tax_annotated_list[0]
		phylum_dict[tax_id] = tax_annotated_list[1]
		class_dict[tax_id] = tax_annotated_list[2]
		order_dict[tax_id] = tax_annotated_list[3]
		family_dict[tax_id] = tax_annotated_list[4]
		genus_dict[tax_id] = tax_annotated_list[5]

count_dict = {}
tax_list = ["kingdom", "phylum", "class", "order", "family", "genus"]
dict_list = [kingdom_dict, phylum_dict, class_dict, order_dict, family_dict, genus_dict]


for tax in tax_list:
	count_dict[tax] = {}

for blast_result_line in open(blast_result):
	blast_result_list = blast_result_line.strip().split("\t")
	tax_id = blast_result_list[1].split(".")[0]
	for i in range(6):
		annotated_tax = dict_list[i][tax_id]
		if annotated_tax not in count_dict[tax_list[i]]:
			count_dict[tax_list[i]][annotated_tax] = 1
		else :
			count_dict[tax_list[i]][annotated_tax] += 1


for i in range(6):
	for t in count_dict[tax_list[i]].items():
		outline = t[0] + "\t" + str(t[1])
		output_file_list[i].write(outline + "\n")







