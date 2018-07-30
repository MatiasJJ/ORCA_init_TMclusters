
#!/bin/bash

dir=$1

echo 'Minkä nimiseen kansioon halut kaikki reaktiot? esim. Laskut_ORCA_HF'
read rcts

echo $rcts > $dir/Logs/rcts.txt

log=Mkdirs.txt
tree=Tree_dirs.txt
echo "INIT: mkdirs.sh"
echo "Mkdirs-logi löytyy tiedostosta $dir/Logs/$log"
echo "Kansiorakenne löytyy tiedostosta $dir/Logs/$tree"
echo __________________________________________________________________________________________
echo "Tehään reaktiokansiot ${rcts}:n alle. " > $dir/Logs/$log

mkdir $rcts
cd $dir/$rcts

echo 'rcts-kansio:' >> $dir/Logs/$log
pwd >> $dir/Logs/$log

for i in $(seq -f "%02g" 1 10); do
  mkdir $dir/$rcts/Reaction$i
  echo "Reaction$i DONE" >> $dir/Logs/$log
done

echo _______________________ >> $dir/Logs/$log
echo 'Reaction-kansiot tehty..' >> $dir/Logs/$log
echo _______________________ >> $dir/Logs/$log

echo 'Tehdään Reaction-kansioihin alikansiot' >> $dir/Logs/$log
for j in $(seq -f "%02g" 1 10); do
  cd $dir/$rcts/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $dir/Logs/$log
  mkdir $subdir/def2-Q $subdir/def2-T
  for i in def2-Q def2-T; do
    mkdir $subdir/${i}/${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}${i}
  done
  ls $subdir/def2-Q >> $dir/Logs/$log
  ls $subdir/def2-T >> $dir/Logs/$log
  cd ..
done

echo "Nyt pitäs olla kaikki kansiot tehty.." >> $dir/Logs/$log
tree $dir/$rcts > $dir/Logs/$tree
