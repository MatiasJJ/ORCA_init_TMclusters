
#!/bin/bash

base=$1               # Base
rcts=$2               # Laskun kansion nimi
rcts_dir=$3           # laskun kansion polku
logs_dir=$4           # logit tänne
qt=$5                 # Q vai T

echo "INIT: submit_all.sh"
echo "Submit-logi löytyy tiedostosta $logs_dir/Submit_all${qt}.txt"
echo __________________________________________________________________________________________
echo 'Submit all to Taito' > $logs_dir/Submit_all${qt}.txt
pwd >> $logs_dir/Submit_all${qt}.txt

for j in $(seq -f "%02g" 1 10); do
  cd $rcts_dir/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $logs_dir/Submit_all${qt}.txt
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2-${qt}; do
    cd $subdir/def2-${qt}/$i
    wrkdir=$(pwd)
    echo $wrkdir >> $logs_dir/Submit_all${qt}.txt
    #sbatch $wrkdir/${i}.job
    echo "Submitted batch job $i to Taito" >> $logs_dir/Submit_all${qt}.txt
  done
done

echo "Nyt pitäs olla input ja jobfiles kunnossa :O " >> $logs_dir/Submit_all${qt}.txt
