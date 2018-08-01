
#!/bin/bash

dir=$1              # Base
qt=$2
rcts=$3             # Base/Lasku

echo "INIT: submit_all.sh"
echo "Submit-logi löytyy tiedostosta $dir/Logs/Submit_all.txt"
echo __________________________________________________________________________________________
echo 'Submit all to Taito' > $dir/Logs/Submit_all.txt
pwd >> $dir/Logs/Submit_all.txt

for j in $(seq -f "%02g" 1 10); do
  cd $dir/$rcts/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $dir/Logs/Submit_all.txt
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2-${qt}; do
    cd $subdir/def2-${qt}/$i
    wrkdir=$(pwd)
    echo $wrkdir >> $dir/Logs/Submit_all.txt
    #sbatch $wrkdir/${i}.job
    echo "Submitted batch job $i to Taito" >> $dir/Logs/Submit_all.txt
  done
done

echo "Nyt pitäs olla input ja jobfiles kunnossa :O " >> $dir/Logs/Submit_all.txt
