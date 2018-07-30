
#!/bin/bash

dir=$(pwd)

echo "Mihin laitetaan logi?"
read log
echo "Logi löytyy tiedostosta $dir/$log"

echo 'Ajetaan FromTxt-scriptit' > $dir/$log
pwd >> $dir/$log

for j in $(seq -f "%02g" 1 10); do
  cd $dir/Reaction$j
  subdir=$(pwd)
  echo $subdir >> $dir/$log
  for i in def2-Q def2-T; do
     $subdir/${i}/${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}${i}
  done
  ls >> $dir/$log
  cd ..
done

echo "Nyt pitäs olla kaikki.." >> $dir/$log

scriptit ajetaan näin:
bash inpFromTxt.sh $(cat 01C_def-Q_inp.txt)
bash jobFromTxt.sh $(cat 01C_def-Q_job.txt)

Reaction-kansion sisällä:
for i in ./*/; do cd $i; bash inpFromTxt.sh $(cat inp.txt); bash jobFromTxt.sh $(cat job.txt); cd ..; done

scripti joka vie joka Reaction$i/$iSpesies -kansioon pohjat kaikista tiedostoista:
bash vieTiedostot.sh
