#!/bin/bash

dir=$1              # Base
qt=$2
rcts=$3             # Base/Lasku

echo "Mikä metodi? RHF/UHF/RKS/UKS ISOLLA"
read method

echo "INIT: import.sh"
echo "Import-logi löytyy tiedostosta $dir/Logs/Import.txt"
echo __________________________________________________________________________________________
echo 'Input-fileet kansioihin' > $dir/Logs/Import.txt
pwd >> $dir/Logs/Import.txt

for j in $(seq -f "%02g" 1 10); do
cd $dir/$rcts/Reaction$j
subdir=$(pwd)
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2; do
    cd $subdir/def2-${qt}/${i}-${qt}/
    wrkdir=$(pwd)
    cp $dir/Input/* $wrkdir

    echo "$wrkdir/sbatch_sh.job" > $wrkdir/job.txt
    echo "96" >> $wrkdir/job.txt
    echo "4" >> $wrkdir/job.txt
    echo "24:00:00" >> $wrkdir/job.txt
    echo "${i}-${qt}" >> $wrkdir/job.txt
    echo "$wrkdir/${i}-${qt}.job" >> $wrkdir/job.txt

    echo "$wrkdir/orca_sh.inp" > $wrkdir/inp.txt
    echo "$method" >> $wrkdir/inp.txt
    echo "def2-${qt}ZVPP" >> $wrkdir/inp.txt
    echo "4400" >> $wrkdir/inp.txt
    echo "96" >> $wrkdir/inp.txt
    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F2no_def2" ] || [ $i = "${j}F2o_def2" ]; then
      echo "0" >> $wrkdir/inp.txt
    else
      echo "1" >> $wrkdir/inp.txt
    fi
    echo "1"  >> $wrkdir/inp.txt
    echo "$wrkdir/*.xyz" >> $wrkdir/inp.txt
    echo "$wrkdir/${i}-${qt}.inp" >> $wrkdir/inp.txt

    pwd >> $dir/Logs/Import.txt
    ls $wrkdir >> $dir/Logs/Import.txt
  done
cd ..
echo "____________________________________________________________________________" >> $dir/Logs/Import.txt
done

echo "Input-tiedostot kansioisssaan" >> $dir/Logs/Import.txt
