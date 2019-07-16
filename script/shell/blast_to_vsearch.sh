#!/bin/sh
#$ -cwd
#$ -N blast_to_v 
/home/kumay/software/ncbi-blast-2.9.0+/bin/blastn -query doubleton_removed.fa -db /home/kumay/database/SILVA_132_SSURef_tax_silva.fasta -evalue 1e-5 -max_target_seqs 1 -out blast_to_silva -outfmt 6 
