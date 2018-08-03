#!/bin/bash

dir=$1              # Base
qt=$2
rcts=$3             # Base/Lasku

res_dir=$dir/Tulokset

echo "Logi löytyy tiedostosta $res_dir/Results_$rcts.txt"

echo "Tulokset $rcts" > $res_dir/Results.txt
echo "Species,days,hours,mins,secs,Species,E_HF,E_CCSD,E_CCSD(T)" >> $res_dir/Results_$rcts.txt


for j in $(seq -f "%02g" 1 10); do
cd Reaction$j
subdir=$(pwd)
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2; do
#    echo "$i-${qt^^}," >> $res_dir/Results_$rcts.txt
    cd $subdir/def2-${qt^^}/${i}-${qt^^}/
    wrkdir=$(pwd)
    echo "" >> $res_dir/Results_$rcts.txt
    printf "$i-${qt^^}," >> $res_dir/Results_$rcts.txt
    grep -i 'total run time' ${wrkdir}/${i}-${qt^^}.out | awk -v ORS="," '{print $4}' >> $res_dir/Results_$rcts.txt
    grep -i 'total run time' ${wrkdir}/${i}-${qt^^}.out | awk -v ORS="," '{print $6}' >> $res_dir/Results_$rcts.txt
    grep -i 'total run time' ${wrkdir}/${i}-${qt^^}.out | awk -v ORS="," '{print $8}' >> $res_dir/Results_$rcts.txt
    grep -i 'total run time' ${wrkdir}/${i}-${qt^^}.out | awk -v ORS="," '{print $10}' >> $res_dir/Results_$rcts.txt
    #    grep -i "finished by error" ${wrkdir}/${i}-${qt^^}.out >> $res_dir/Results_$rcts.txt
    grep "Exit code" ${wrkdir}/${i}-${qt^^}.out >> $res_dir/Results_$rcts.txt

    printf "$i-${qt^^}," >> $res_dir/Results_$rcts.txt
    grep -i 'total energy' ${wrkdir}/${i}-${qt^^}.out | awk -v ORS="," '{print $4}' >> $res_dir/Results_$rcts.txt
    grep -i 'E(CCSD)' ${wrkdir}/${i}-${qt^^}.out | awk -v ORS="," '{print $3}' >> $res_dir/Results_$rcts.txt
    grep -i 'E(CCSD(T))' ${wrkdir}/${i}-${qt^^}.out | awk -v ORS="," '{print $3}' >> $res_dir/Results_$rcts.txt
    echo "" >> $res_dir/Results_$rcts.txt
    cd $subdir
  done
  cd ..
  echo "________________________________________________________________________________________________________________________" >> $res_dir/Results_$rcts.txt
done
