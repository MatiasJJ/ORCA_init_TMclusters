
#!/bin/bash

base=$1
rcts=$2
rcts_dir=$3
logs_dir=$4

log=Mkdirs${qt}.txt
tree=Tree_dirs.txt
echo "INIT: mkdirs.sh"
echo "Mkdirs-logi löytyy tiedostosta $logs_dir/$log"
echo __________________________________________________________________________________________
echo "Tehään reaktiokansiot ${rcts}:n alle. " > $logs_dir/$log

cd $rcts_dir

echo 'rcts-kansio:' >> $logs_dir/$log
pwd >> $logs_dir/$log

for i in $(seq -f "%02g" 1 10); do
  mkdir $rcts_dir/Reaction$i
  echo "Reaction$i DONE" >> $logs_dir/$log
done

echo _______________________ >> $logs_dir/$log
echo 'Reaction-kansiot tehty..' >> $logs_dir/$log
echo _______________________ >> $logs_dir/$log

echo 'Tehdään Reaction-kansioihin alikansiot' >> $logs_dir/$log
for j in $(seq -f "%02g" 1 10); do
  cd $rcts_dir/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $logs_dir/$log
  mkdir $subdir/def2-Q $subdir/def2-T
  for i in def2-Q def2-T; do
    mkdir $subdir/${i}/${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}${i}
  done
  ls $subdir/def2-Q >> $logs_dir/$log
  ls $subdir/def2-T >> $logs_dir/$log
  cd ..
done

echo "Nyt pitäs olla kaikki kansiot tehty.." >> $logs_dir/$log
