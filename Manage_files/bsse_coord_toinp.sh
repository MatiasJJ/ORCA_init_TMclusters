
#!/bin/bash

dir=$1              # Base
qt=$2
rcts=$3             # Base/Lasku
round=$4


sh_dir=$dir/Manage_files

echo "INIT: bsse_coord_toinp.sh"
echo "BSSEinp-logi löytyy tiedostosta $dir/Logs/Bsse_coord_toinp.txt"
echo __________________________________________________________________________________________
echo 'BSSE-coordinaatistot input-fileisiin' > $dir/Logs/Bsse_coord_toinp.txt
pwd >> $dir/Logs/Bsse_coord_toinp.txt

for j in $(seq -f "%02g" 1 10); do
  cd $dir/$rcts/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $dir/Logs/Bsse_coord_toinp.txt
  for i in ${j}{F1b_,F2b_}def2; do
    cd $subdir/def2-${qt}/${i}-${qt}
    wrkdir=$(pwd)
    while read k; do
      echo "$k"
    done < $wrkdir/${i%%_*2}.xyz >> $wrkdir/${i}-${qt}.inp
    echo '*' >> $wrkdir/${i}-${qt}.inp
    echo $wrkdir >> $dir/Logs/Bsse_coord_toinp.txt
    ls $wrkdir >> $dir/Logs/Bsse_coord_toinp.txt
  done
done

echo "Nyt pitäs olla BSSE inputit kunnossa :O " >> $dir/Logs/Bsse_coord_toinp.txt

if [ $round = "1" ]; then
  mv $dir/Logs/Bsse_coord_toinp.txt $dir/Logs/Bsse_coord_toinp1.txt
fi

if [ $round = "2" ]; then
  mv $dir/Logs/Bsse_coord_toinp.txt $dir/Logs/Bsse_coord_toinp2.txt
fi
