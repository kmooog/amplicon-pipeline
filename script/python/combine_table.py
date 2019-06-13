max_dir_num = 6
taxon_maps = ["class_mapped","family_mapped","genus_mapped","kingdom_mapped","order_mapped","phylum_mapped"]
for taxon in taxon_maps:
   taxon_dict = {}
   taxon_list = []
   for i in range (1, max_dir_num):
      tmp_taxon_dict = {}
      padding_num = str(i).zfill(3)
      with open(padding_num + "/" + taxon) as f:
         for line in f:
            tax_name = line.strip().split("\t")[0]
            num = int(line.strip().split("\t")[1])  
            tmp_taxon_dict[tax_name] = num
            if tax_name not in taxon_list:
               taxon_list.append(tax_name)
      taxon_list.sort()
      taxon_dict[i] = tmp_taxon_dict
   taxon_list.sort()   
   with open("merged_" + taxon ,"w") as out:
      for i in range (1, max_dir_num):
         out.write("\t" + str(i).zfill(3))
      out.write("\n")
      for tmp_tax_name in taxon_list:
         out.write(tmp_tax_name)
         for i in range (1, max_dir_num):
            if tmp_tax_name in taxon_dict[i]:
               out.write("\t" + str(taxon_dict[i][tmp_tax_name]))
            else:
               out.write("\t" + "0")
         out.write("\n")




