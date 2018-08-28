#!/bin/bash

base=$1               # Base
rcts=$2               # Laskun kansion nimi
rcts_dir=$3           # laskun kansion polku
logs_dir=$4           # logit tänne
qt=$5                 # Q vai T

sh_dir=$base/Manage_files

echo "INIT: inputs.sh"
echo "Inputs-logi löytyy tiedostosta $logs_dir/Inputs${qt}.txt"
echo "Pienille 'mol2'-tiedosto, semi-pienille 'mol3', isoille 'mol4' ja valtaville 'mol5'.."
echo __________________________________________________________________________________________
echo 'Input&jobfiles FromTxts' > $logs_dir/Inputs${qt}.txt
pwd >> $logs_dir/Inputs${qt}.txt

echo "Ajetaan FromTxt-scriptit kansiosta $sh_dir" >> $logs_dir/Inputs${qt}.txt

for j in $(seq -f "%02g" 1 10); do
  cd $rcts_dir/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $logs_dir/Inputs${qt}.txt
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2-${qt}; do
    cd $subdir/def2-${qt}/${i}
    wrkdir=$(pwd)
    if [[ -e $wrkdir/mol2 ]]; then
      bash $sh_dir/inpFromTxt.sh $(cat $wrkdir/Jobit/inp2.txt) $logs_dir >> $logs_dir/Inputs${qt}.txt
      bash $sh_dir/jobFromTxt.sh $(cat $wrkdir/Jobit/job2.txt) >> $logs_dir/Inputs${qt}.txt
    elif [[ -e $wrkdir/mol3 ]]; then
      bash $sh_dir/inpFromTxt.sh $(cat $wrkdir/Jobit/inp3.txt) $logs_dir >> $logs_dir/Inputs${qt}.txt
      bash $sh_dir/jobFromTxt.sh $(cat $wrkdir/Jobit/job3.txt) >> $logs_dir/Inputs${qt}.txt
    elif [[ -e $wrkdir/mol4 ]]; then
      bash $sh_dir/inpFromTxt.sh $(cat $wrkdir/Jobit/inp4.txt) $logs_dir >> $logs_dir/Inputs${qt}.txt
      bash $sh_dir/jobFromTxt.sh $(cat $wrkdir/Jobit/job4.txt) >> $logs_dir/Inputs${qt}.txt
    elif [[ -e $wrkdir/mol5 ]]; then
      bash $sh_dir/inpFromTxt.sh $(cat $wrkdir/Jobit/inp5.txt) $logs_dir >> $logs_dir/Inputs${qt}.txt
      bash $sh_dir/jobFromTxt.sh $(cat $wrkdir/Jobit/job5.txt) >> $logs_dir/Inputs${qt}.txt
    else
    bash $sh_dir/inpFromTxt.sh $(cat $wrkdir/Jobit/inp.txt) $logs_dir >> $logs_dir/Inputs${qt}.txt
    bash $sh_dir/jobFromTxt.sh $(cat $wrkdir/Jobit/job.txt) >> $logs_dir/Inputs${qt}.txt
    fi
    echo $wrkdir >> $logs_dir/Inputs${qt}.txt
    ls $wrkdir >> $logs_dir/Inputs${qt}.txt
  done
done

echo "Nyt pitäs olla input ja jobfiles kunnossa :O " >> $logs_dir/Inputs${qt}.txt
