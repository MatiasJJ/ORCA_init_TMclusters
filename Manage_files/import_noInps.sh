#!/bin/bash

dir=$1              # Base
qt=$2
rcts=$3             # Base/Lasku

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
    pwd >> $dir/Logs/Import.txt
    ls $wrkdir >> $dir/Logs/Import.txt
  done
cd ..
echo "____________________________________________________________________________" >> $dir/Logs/Import.txt
done

echo "Input-tiedostot kansioisssaan" >> $dir/Logs/Import.txt
