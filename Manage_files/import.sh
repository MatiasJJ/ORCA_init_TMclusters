#!/bin/bash

base=$1               # Base
rcts=$2               # Laskun kansion nimi
rcts_dir=$3           # laskun kansion polku
logs_dir=$4           # logit tänne
qt=$5                 # Q vai T

coord_dir=$base/Coord_all

if [ $qt = "T" ]; then
  echo "Mikä metodi? RHF/UHF/RKS/UKS ISOLLA"
  echo "DFT:n perään funktionaali esim TPSSh"
  read method                                                   # Käyttäjä määrittelee metodin
  echo $method > $logs_dir/method.txt
elif [ $qt = "Q" ]; then
  method=$(cat $logs_dir/method.txt)
fi

echo "INIT: import.sh"                                        # nii että mitä ollaa tekemäässä
echo "Import-logi löytyy tiedostosta $logs_dir/Import${qt}.txt"
echo __________________________________________________________________________________________
echo 'Input-fileet kansioihin' > $logs_dir/Import${qt}.txt         # Logia
pwd >> $logs_dir/Import${qt}.txt

for j in $(seq -f "%02g" 1 10); do                            # Reaction-kansiot läpi
cd $rcts_dir/Reaction$j
subdir=$(pwd)
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2; do   # Species-kansiot läpi
    cd $subdir/def2-${qt}/${i}-${qt}/                         # T ja Q erikseen
    wrkdir=$(pwd)
    cp $base/Input/* $wrkdir                                   # Tarvittavat input-fileet Species-kansioihin

    cp $coord_dir/${i%%_*2}.xyz $wrkdir                       # Oikea koordinaatisto mukaan

    mkdir $wrkdir/Jobit

    echo "$wrkdir/sbatch_sh.job" > $wrkdir/Jobit/job.txt            # Eka jobfile ja scriptiin luettava tiedosto
    echo "parallel" >> $wrkdir/Jobit/job.txt                        # @jono
    echo "96" >> $wrkdir/Jobit/job.txt                              # @core
    echo "4" >> $wrkdir/Jobit/job.txt                               # @node
    echo "24:00:00" >> $wrkdir/Jobit/job.txt                        # @time
    echo "5200" >> $wrkdir/Jobit/job.txt                            # @memcpu
    echo "${i}-${qt}" >> $wrkdir/Jobit/job.txt                      # @jobname
    echo "$wrkdir/${i}-${qt}.job" >> $wrkdir/Jobit/job.txt          # lopullinen jobfile

    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F1b_def2" ]; then
      echo "$wrkdir/orca_shB.inp" > $wrkdir/Jobit/inp.txt              # Eka input-file ja scriptiin luettava tiedosto jos BSSE
    else
      echo "$wrkdir/orca_sh.inp" > $wrkdir/Jobit/inp.txt              # Eka input-file ja scriptiin luettava tiedosto jos normi
    fi

    echo "$method" >> $wrkdir/Jobit/inp.txt                         # @method
    echo "def2-${qt}ZVPP" >> $wrkdir/Jobit/inp.txt                  # @basis
    echo "4400" >> $wrkdir/Jobit/inp.txt                            # @maxMem
    echo "96" >> $wrkdir/Jobit/inp.txt                              # @nprocs
    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F2no_def2" ] || [ $i = "${j}F2o_def2" ]; then
      echo "0" >> $wrkdir/Jobit/inp.txt                             # @charge jos frag2
    else
      echo "1" >> $wrkdir/Jobit/inp.txt                             # @charge jos complex tai frag1
    fi
    echo "1"  >> $wrkdir/Jobit/inp.txt                              # @multi

    echo ${i%%_*2}.xyz >> $wrkdir/Jobit/inp.txt                     # @xyzfile
    echo "$wrkdir/${i}-${qt}.inp" >> $wrkdir/Jobit/inp.txt          # lopullinen input-file jos normi

    #Pienille molekyyleille
    echo "$wrkdir/sbatch_sh.job" > $wrkdir/Jobit/job2.txt
    echo "serial" >> $wrkdir/Jobit/job2.txt                         # @jono
    echo "1" >> $wrkdir/Jobit/job2.txt
    echo "1" >> $wrkdir/Jobit/job2.txt
    echo "8:00:00" >> $wrkdir/Jobit/job2.txt
    echo "4000" >> $wrkdir/Jobit/job2.txt                           # @memcpu
    echo "${i}-${qt}" >> $wrkdir/Jobit/job2.txt
    echo "$wrkdir/${i}-${qt}.job" >> $wrkdir/Jobit/job2.txt

    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F1b_def2" ]; then
      echo "$wrkdir/orca_shB.inp" > $wrkdir/Jobit/inp2.txt              # Eka input-file ja scriptiin luettava tiedosto jos BSSE
    else
      echo "$wrkdir/orca_sh.inp" > $wrkdir/Jobit/inp2.txt              # Eka input-file ja scriptiin luettava tiedosto jos normi
    fi
    echo "$method" >> $wrkdir/Jobit/inp2.txt
    echo "def2-${qt}ZVPP" >> $wrkdir/Jobit/inp2.txt
    echo "3800" >> $wrkdir/Jobit/inp2.txt
    echo "1" >> $wrkdir/Jobit/inp2.txt
    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F2no_def2" ] || [ $i = "${j}F2o_def2" ]; then
      echo "0" >> $wrkdir/Jobit/inp2.txt
    else
      echo "1" >> $wrkdir/Jobit/inp2.txt
    fi
    echo "1"  >> $wrkdir/Jobit/inp2.txt

    echo ${i%%_*2}.xyz >> $wrkdir/Jobit/inp2.txt

    echo "$wrkdir/${i}-${qt}.inp" >> $wrkdir/Jobit/inp2.txt

    #SUURILLE molekyyleille
    echo "$wrkdir/sbatch_sh.job" > $wrkdir/Jobit/job3.txt
    echo "hugemem" >> $wrkdir/Jobit/job3.txt                          # @jono
    echo "40" >> $wrkdir/Jobit/job3.txt
    echo "1" >> $wrkdir/Jobit/job3.txt
    echo "32:00:00" >> $wrkdir/Jobit/job3.txt
    echo "37000" >> $wrkdir/Jobit/job3.txt                            # @memcpu
    echo "${i}-${qt}" >> $wrkdir/Jobit/job3.txt
    echo "$wrkdir/${i}-${qt}.job" >> $wrkdir/Jobit/job3.txt

    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F1b_def2" ]; then
      echo "$wrkdir/orca_shB.inp" > $wrkdir/Jobit/inp3.txt              # Eka input-file ja scriptiin luettava tiedosto jos BSSE
    else
      echo "$wrkdir/orca_sh.inp" > $wrkdir/Jobit/inp3.txt              # Eka input-file ja scriptiin luettava tiedosto jos normi
    fi
    echo "$method" >> $wrkdir/Jobit/inp3.txt
    echo "def2-${qt}ZVPP" >> $wrkdir/Jobit/inp3.txt
    echo "36000" >> $wrkdir/Jobit/inp3.txt
    echo "40" >> $wrkdir/Jobit/inp3.txt
    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F2no_def2" ] || [ $i = "${j}F2o_def2" ]; then
      echo "0" >> $wrkdir/Jobit/inp3.txt
    else
      echo "1" >> $wrkdir/Jobit/inp3.txt
    fi
    echo "1"  >> $wrkdir/Jobit/inp3.txt

    echo ${i%%_*2}.xyz >> $wrkdir/Jobit/inp3.txt

    echo "$wrkdir/${i}-${qt}.inp" >> $wrkdir/Jobit/inp3.txt


    pwd >> $logs_dir/Import${qt}.txt
    ls $wrkdir >> $logs_dir/Import${qt}.txt

  done
echo "____________________________________________________________________________" >> $logs_dir/Import${qt}.txt
done

echo "Input-tiedostot kansioisssaan" >> $logs_dir/Import${qt}.txt
