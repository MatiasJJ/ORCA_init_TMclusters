
#!/bin/bash

base=$1               # Base
rcts=$2               # Laskun kansion nimi
rcts_dir=$3           # laskun kansion polku
logs_dir=$4           # logit tänne
qt=$5                 # Q vai T

sh_dir=$base/Manage_files
log="Mol123${qt}.txt"

echo "INIT: mol123.sh"
echo "mol123-logi löytyy tiedostosta $logs_dir/$log"
echo "Pienille 'mol2'-tiedosto ja isoille 'mol3'.." > $logs_dir/$log
echo __________________________________________________________________________________________

#Pienille mol2
for j in {'01','10'}; do
  cd $rcts_dir/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $logs_dir/$log
  for i in ${j}{F2b_,F2no_,F2o_}def2-${qt}; do
    cd $subdir/def2-${qt}/${i}
    wrkdir=$(pwd)
    touch $wrkdir/mol2
    echo $wrkdir >> $logs_dir/$log
    ls $wrkdir >> $logs_dir/$log
  done
done

#Semi-Pienille mol3
for j in {'06','07','08'}; do
  cd $rcts_dir/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $logs_dir/$log
  for i in ${j}{F2b_,F2no_,F2o_}def2-${qt}; do
    cd $subdir/def2-${qt}/${i}
    wrkdir=$(pwd)
    touch $wrkdir/mol3
    echo $wrkdir >> $logs_dir/$log
    ls $wrkdir >> $logs_dir/$log
  done
done

#Bigmem mol4
for j in {'02','03'}; do
  cd $rcts_dir/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $logs_dir/$log
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2-${qt}; do
    cd $subdir/def2-${qt}/${i}
    wrkdir=$(pwd)
    touch $wrkdir/mol4
    echo $wrkdir >> $logs_dir/$log
    ls $wrkdir >> $logs_dir/$log
  done
done

#Hugemem mol5
for j in '04'; do
  cd $rcts_dir/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $logs_dir/$log
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2-${qt}; do
    cd $subdir/def2-${qt}/${i}
    wrkdir=$(pwd)
    touch $wrkdir/mol5
    echo $wrkdir >> $logs_dir/$log
    ls $wrkdir >> $logs_dir/$log
  done
done


echo "Nyt pitäs olla pienet ja isot mollet kunnossa :O " >> $logs_dir/$log
