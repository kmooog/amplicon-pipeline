for i in `seq -f %03g ${1} ${2}`
do
  mkdir ${i} 
  cd ${i}
  cp ../${i}_1.fq.gz .
  cp ../${i}_2.fq.gz .
  qsub /home/kumay/amplicon-pipeline/script/1-preproccess/preprocess_amplicon.sh ${i}
  cd ..
done
