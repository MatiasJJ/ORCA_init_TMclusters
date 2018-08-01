
#!/bin/bash

dir=$1              # Base
qt=$2
rcts=$3             # Base/Lasku

echo "INIT: submit_all2.sh"
echo "Submit-logi löytyy tiedostosta $dir/Logs/Submit_all2.txt"
echo __________________________________________________________________________________________
echo 'Submit KORJATUT to Taito' > $dir/Logs/Submit_all2.txt
pwd >> $dir/Logs/Submit_all2.txt

for j in $(seq -f "%02g" 1 10); do
  cd $dir/$rcts/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $dir/Logs/Submit_all2.txt
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2-${qt}; do
    cd $subdir/def2-${qt}/$i
    wrkdir=$(pwd)
    echo $wrkdir >> $dir/Logs/Submit_all2.txt
    #sbatch $wrkdir/${i}2.job
    echo "Submitted batch job $i to Taito" >> $dir/Logs/Submit_all2.txt
  done
done

echo "Nyt pitäs olla input ja jobfiles kunnossa :O " >> $dir/Logs/Submit_all2.txt
