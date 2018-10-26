#!/bin/bash

base=$1               # Base
rcts=$2               # Laskun kansion nimi
rcts_dir=$3           # laskun kansion polku
logs_dir=$4           # logit tänne
qt=$5                 # Q vai T

sh_dir=$base/Manage_files

echo "INIT: Coord_toinp.sh"
echo "coord-logi löytyy tiedostosta $logs_dir/Coord_toinp${qt}.txt"
echo __________________________________________________________________________________________
echo 'Koordinaatistot input-fileisiin' > $logs_dir/Coord_toinp${qt}.txt
pwd >> $logs_dir/Coord_toinp${qt}.txt

for j in $(seq -f "%02g" 1 10); do
  cd $rcts_dir/Reaction$j
  subdir=$(pwd)
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2; do
    cd $subdir/def2-${qt}/${i}-${qt}
    wrkdir=$(pwd)

    tail -n +3 $wrkdir/${i%%_*2}.xyz >> $wrkdir/${i}-${qt}.inp
    echo '*' >> $wrkdir/${i}-${qt}.inp

    #while read k; do
    #  echo "$k"
    #done < $(tail -n +3 $wrkdir/${i%%_*2}.xyz) >> $wrkdir/${i}-${qt}.inp
    #echo '*' >> $wrkdir/${i}-${qt}.inp
    
    echo $wrkdir >> $logs_dir/Coord_toinp${qt}.txt
    ls $wrkdir >> $logs_dir/Coord_toinp${qt}.txt
  done
done

echo "Nyt pitäs olla koordinaatit inputeissa :O " >> $logs_dir/Coord_toinp${qt}.txt
