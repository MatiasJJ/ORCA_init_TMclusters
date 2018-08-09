#!/bin/bash

base=$1               # Base
rcts=$2               # Laskun kansion nimi
rcts_dir=$3           # laskun kansion polku
logs_dir=$4           # logit tänne

echo "INIT: gbw.sh"
echo "Gbw-logi löytyy tiedostosta $logs_dir/Gbw.txt"
echo __________________________________________________________________________________________
echo 'Kopsataan orbitaalit' > $logs_dir/Gbw.txt
pwd >> $logs_dir/Gbw.txt

for j in $(seq -f "%02g" 1 10); do
  cd $rcts_dir/Reaction$j
  subdir=$(pwd)
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2; do
    cp $subdir/def2-T/${i}-T/${i}-T.gbw $subdir/def2-Q/${i}-Q/${i}-Q.gbw
    echo "$i-Q.gbw kopioitu" >> $logs_dir/Gbw.txt
  done
done
