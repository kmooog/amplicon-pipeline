from argparse import ArgumentParser
def parser():
    argparser = ArgumentParser()
    argparser.add_argument('-taxmap', type=open,
                           help='location of taxmap_slv_ssu_ref_132.txt')
    argparser.add_argument('-rename_list', type=open,
                           help='location of rename_list.csv')
    argparser.add_argument('-blast_result', type=open,
                           help='location of blast_result')
    return argparser.parse_args()

if __name__ == '__main__':
    args = parser()
    taxmap = args.taxmap
    tax_dict = {}
    for a in taxmap:
        tax_dict[a.split()[0]] = a.strip()

    rename = args.rename_list
    blast = args.blast_result
    blast_dict = {}
    for a in blast:
        blast_dict[a.split()[0]] = a.split()[1]

    out_file = open("OTU_taxon", "w")

    for a in rename:
        id_tmp = a.split(",")[0]
        raw_id = a.split(",")[1].strip()
        out = ""
        if "*"+raw_id in blast_dict:
            out = id_tmp + "\t" + tax_dict[blast_dict["*"+raw_id].split(".")[0]].split()[3]
        else:
            out = id_tmp + "\t" + "unassigned"

        out_file.write(out + "\n")
    out_file.close()
