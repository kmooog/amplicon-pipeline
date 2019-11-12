for i in `seq -f %03g ${1} ${2}`
do
  cat ${i}/chimera_filtered.fa | sed -e 's/>/>'$i'_/' >> all.fq
done
