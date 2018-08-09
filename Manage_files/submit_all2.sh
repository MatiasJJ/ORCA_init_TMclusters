
#!/bin/bash

base=$1               # Base
rcts=$2               # Laskun kansion nimi
rcts_dir=$3           # laskun kansion polku
logs_dir=$4           # logit tänne
qt=$5                 # Q vai T

echo "INIT: submit_all2.sh"
echo "Submit-logi löytyy tiedostosta $logs_dir/Submit_all2${qt}.txt"
echo __________________________________________________________________________________________
if [ -e $logs_dir/nextRound.txt ]; then
  echo "Uudestaan lähtee $(cat $logs_dir/nextRound.txt)"

  echo 'Uudestaan nämä:' > $logs_dir/Submit_all2${qt}.txt
  pwd >> $logs_dir/Submit_all2${qt}.txt

# Yritä saada tähän joku järkevä tapa jolla looppi tietää mitä ajaa ja miten se pääsee sinne kansioon
# Yks tapa on käyttää taas flägitiedostoo..

#  for j in $(seq -f "%02g" 1 10); do
#    cd $rcts_dir/Reaction$j
#    subdir=$(pwd)
#    for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2-${qt}; do
#      cd $subdir/def2-${qt}/$i
#      wrkdir=$(pwd)
#      echo $wrkdir >> $logs_dir/Submit_all2${qt}.txt
#      #sbatch $wrkdir/${i}2.job
#      echo "Submitted batch job $i to Taito" >> $logs_dir/Submit_all2${qt}.txt
#    done
#  done

#  echo "Nyt pitäs olla input ja jobfiles kunnossa :O " >> $logs_dir/Submit_all2${qt}.txt

else
  echo "Seuraavalle kierrokselle menevät pitää kirjottaa tiedostoon $logs_dir/nextRound.txt"
fi






# echo 'Niistä poistetaan sit ne huonot *.tmp* *.err *.out *.loc *prop* *.ges -tiedostot.'


# rm -f *.tmp* *.err *.out *.loc *prop* *.ges
