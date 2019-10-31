#!/bin/sh
#$ -cwd
#$ -N meta_p
for i in `seq -f %03g 1 722`
do
  cat ${i}/prinseq_out.fastq >> all.fq
done
