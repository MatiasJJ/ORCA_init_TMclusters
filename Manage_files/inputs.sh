
#!/bin/bash

dir=$1              # Base
qt=$2
rcts=$3             # Base/Lasku

sh_dir=$dir/Manage_files

echo "INIT: inputs.sh"
echo "Inputs-logi löytyy tiedostosta $dir/Logs/Inputs.txt"
echo __________________________________________________________________________________________
echo 'Input&jobfiles FromTxts' > $dir/Logs/Inputs.txt
pwd >> $dir/Logs/Inputs.txt

echo "Ajetaan FromTxt-scriptit kansiosta $sh_dir" >> $dir/Logs/Inputs.txt

for j in $(seq -f "%02g" 1 10); do
  cd $dir/$rcts/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $dir/Logs/Inputs.txt
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2-${qt}; do
    cd $subdir/def2-${qt}/${i}
    wrkdir=$(pwd)
    bash $sh_dir/inpFromTxt.sh $(cat $wrkdir/inp.txt) >> $dir/Logs/Inputs.txt
    bash $sh_dir/jobFromTxt.sh $(cat $wrkdir/job.txt) >> $dir/Logs/Inputs.txt
    echo $wrkdir >> $dir/Logs/Inputs.txt
    ls $wrkdir >> $dir/Logs/Inputs.txt
  done
done

echo "Nyt pitäs olla input ja jobfiles kunnossa :O " >> $dir/Logs/Inputs.txt
