
#!/bin/bash

dir=$1              # Base
qt=$2
rcts=$3             # Base/Lasku

sh_dir=$dir/Manage_files

echo "INIT: inputs2.sh"
echo "Inputs2-logi löytyy tiedostosta $dir/Logs/Inputs2.txt"
echo "Kakkoskierrokselle menee vaan ne, joissa on 'round2'-tiedosto.."
echo __________________________________________________________________________________________
echo 'KORJATUT Input&jobfiles FromTxts' > $dir/Logs/Inputs2.txt
pwd >> $dir/Logs/Inputs2.txt

echo "Ajetaan FromTxt-scriptit kansiosta $sh_dir" >> $dir/Logs/Inputs2.txt

for j in $(seq -f "%02g" 1 10); do
  cd $dir/$rcts/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $dir/Logs/Inputs2.txt
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2-${qt}; do
    cd $subdir/def2-${qt}/${i}
    wrkdir=$(pwd)
    if [[ -e $wrkdir/round2 ]]; then
      mkdir $wrkdir/inp1
      mv $wrkdir/${i}.inp $wrkdir/inp1/${i}.inp
      mv $wrkdir/${i}.job $wrkdir/inp1/${i}.job
      bash $sh_dir/inpFromTxt.sh $(cat $wrkdir/inp2.txt) >> $dir/Logs/Inputs2.txt
      bash $sh_dir/jobFromTxt.sh $(cat $wrkdir/job2.txt) >> $dir/Logs/Inputs2.txt

      echo $wrkdir >> $dir/Logs/Inputs2.txt
      ls $wrkdir >> $dir/Logs/Inputs2.txt
    fi
  done
done

echo "Nyt pitäs olla KORJATUTKIN input ja jobfiles kunnossa :O " >> $dir/Logs/Inputs2.txt
