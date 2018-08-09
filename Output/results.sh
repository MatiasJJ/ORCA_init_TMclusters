#!/bin/bash

base=$1               # Base
rcts=$2               # Laskun kansion nimi
rcts_dir=$3           # laskun kansion polku
logs_dir=$4           # logit tänne
qt=$5                 # Q vai T

res_dir=$rcts_dir/Tulokset
res_file="Results_${rcts}_${qt}.txt"
echo "Logi löytyy tiedostosta $res_dir/$res_file"

echo "Tulokset $rcts" > $res_dir/$res_file
echo "Species,days,hours,mins,secs,Species,E_HF,E_CCSD,E_CCSD(T)" >> $res_dir/$res_file

for j in $(seq -f "%02g" 1 10); do
cd $rcts_dir/Reaction$j
subdir=$(pwd)
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2; do
    cd $subdir/def2-${qt}/${i}-${qt}/
    wrkdir=$(pwd)
    echo "" >> $res_dir/$res_file
    printf "$i-${qt}," >> $res_dir/$res_file
    grep -i 'total run time' ${wrkdir}/${i}-${qt}.out | awk -v ORS="," '{print $4}' >> $res_dir/$res_file
    grep -i 'total run time' ${wrkdir}/${i}-${qt}.out | awk -v ORS="," '{print $6}' >> $res_dir/$res_file
    grep -i 'total run time' ${wrkdir}/${i}-${qt}.out | awk -v ORS="," '{print $8}' >> $res_dir/$res_file
    grep -i 'total run time' ${wrkdir}/${i}-${qt}.out | awk -v ORS="," '{print $10}' >> $res_dir/$res_file
    #    grep -i "finished by error" ${wrkdir}/${i}-${qt}.out >> $res_dir/$res_file
    grep "Exit code" ${wrkdir}/${i}-${qt}.out >> $res_dir/$res_file

    printf "$i-${qt}," >> $res_dir/$res_file
    grep -i 'total energy' ${wrkdir}/${i}-${qt}.out | awk -v ORS="," '{print $4}' >> $res_dir/$res_file
    grep -i 'E(CCSD)' ${wrkdir}/${i}-${qt}.out | awk -v ORS="," '{print $3}' >> $res_dir/$res_file
    grep -i 'E(CCSD(T))' ${wrkdir}/${i}-${qt}.out | awk -v ORS="," '{print $3}' >> $res_dir/$res_file
    cd $subdir
  done
  echo "" >> $res_dir/$res_file
  echo "________________________________________________________________________________________________________________________" >> $res_dir/$res_file
done
