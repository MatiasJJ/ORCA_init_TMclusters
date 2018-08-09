
#!/bin/bash

base=$1               # Base
rcts=$2               # Laskun kansion nimi
rcts_dir=$3           # laskun kansion polku
logs_dir=$4           # logit tänne
qt=$5                 # Q vai T

sh_dir=$base/Manage_files

echo "INIT: bsse_coord_toinp.sh"
echo "BSSEinp-logi löytyy tiedostosta $logs_dir/Bsse_coord_toinp${qt}.txt"
echo __________________________________________________________________________________________
echo 'BSSE-coordinaatistot input-fileisiin' > $logs_dir/Bsse_coord_toinp${qt}.txt
pwd >> $logs_dir/Bsse_coord_toinp${qt}.txt

for j in $(seq -f "%02g" 1 10); do
  cd $rcts_dir/Reaction$j
  subdir=$(pwd)
  for i in ${j}{F1b_,F2b_}def2; do
    cd $subdir/def2-${qt}/${i}-${qt}
    wrkdir=$(pwd)
    while read k; do
      echo "$k"
    done < $wrkdir/${i%%_*2}.xyz >> $wrkdir/${i}-${qt}.inp
    echo '*' >> $wrkdir/${i}-${qt}.inp
    echo $wrkdir >> $logs_dir/Bsse_coord_toinp${qt}.txt
    ls $wrkdir >> $logs_dir/Bsse_coord_toinp${qt}.txt
  done
done

echo "Nyt pitäs olla BSSE inputit kunnossa :O " >> $logs_dir/Bsse_coord_toinp${qt}.txt
