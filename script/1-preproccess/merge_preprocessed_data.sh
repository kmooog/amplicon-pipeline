for i in `seq -f %03g ${1} ${2}`
do
  cat ${i}/prinseq_out.fastq | sed -e 's/>/>'$i'_/' >> all.fq
done
