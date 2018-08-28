#!/bin/bash

base=$1               # Base
rcts=$2               # Laskun kansion nimi
rcts_dir=$3           # laskun kansion polku
logs_dir=$4           # logit tänne
qt=$5                 # Q vai T

coord_dir=$base/Coord_all

if [ $qt = "T" ]; then
  echo "Mikä metodi? RHF/UHF/RKS/UKS ISOLLA"
  read method                                                   # Käyttäjä määrittelee metodin
  echo $method > $logs_dir/method.txt
  if [ $method = "RKS" ] || [ $method = "UKS" ]; then
    echo "Mikä DFT-funktionaali? (ORCA keyword esim TPSSh tai wB97X-D3)"
    read functional
    echo $functional > $logs_dir/functional.txt
  fi
elif [ $qt = "Q" ]; then
  method=$(cat $logs_dir/method.txt)
  if [[ -e $logs_dir/functional.txt  ]]; then
    functional=$(cat $logs_dir/functional.txt)
  fi
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

  #Normi molekyyleille
    echo "$wrkdir/sbatch_sh.job" > $wrkdir/Jobit/job.txt            # Eka jobfile ja scriptiin luettava tiedosto
    echo "parallel" >> $wrkdir/Jobit/job.txt                        # @jono
    echo "96" >> $wrkdir/Jobit/job.txt                              # @core
    echo "4" >> $wrkdir/Jobit/job.txt                               # @node
    echo "72:00:00" >> $wrkdir/Jobit/job.txt                        # @time
    echo "5200" >> $wrkdir/Jobit/job.txt                            # @memcpu
    echo "${i}-${qt}" >> $wrkdir/Jobit/job.txt                      # @jobname
    echo "$wrkdir/${i}-${qt}.job" >> $wrkdir/Jobit/job.txt          # lopullinen jobfile

    if [[ -e $logs_dir/functional.txt ]]; then
      echo "$wrkdir/orca_sh_DFT.inp" > $wrkdir/Jobit/inp.txt        # Eka input-file ja scriptiin luettava tiedosto jos DFT
    else
      echo "$wrkdir/orca_sh_HF.inp" > $wrkdir/Jobit/inp.txt            # Eka input-file ja scriptiin luettava tiedosto jo HF
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
    echo "$wrkdir/sbatch_sh.job" > $wrkdir/Jobit/job2.txt           # Eka jobfile ja scriptiin luettava tiedosto
    echo "serial" >> $wrkdir/Jobit/job2.txt                         # @jono
    echo "1" >> $wrkdir/Jobit/job2.txt                              # @core
    echo "1" >> $wrkdir/Jobit/job2.txt                              # @node
    echo "8:00:00" >> $wrkdir/Jobit/job2.txt                        # @time
    echo "4000" >> $wrkdir/Jobit/job2.txt                           # @memcpu
    echo "${i}-${qt}" >> $wrkdir/Jobit/job2.txt                     # @jobname
    echo "$wrkdir/${i}-${qt}.job" >> $wrkdir/Jobit/job2.txt         # lopullinen jobfile

    if [[ -e $logs_dir/functional.txt ]]; then
      echo "$wrkdir/orca_sh_DFT.inp" > $wrkdir/Jobit/inp2.txt        # Eka input-file ja scriptiin luettava tiedosto jos DFT
    else
      echo "$wrkdir/orca_sh_HF.inp" > $wrkdir/Jobit/inp2.txt            # Eka input-file ja scriptiin luettava tiedosto jo HF
    fi
    echo "$method" >> $wrkdir/Jobit/inp2.txt                         # @method
    echo "def2-${qt}ZVPP" >> $wrkdir/Jobit/inp2.txt                 # @basis
    echo "3800" >> $wrkdir/Jobit/inp2.txt                           # @maxMem
    echo "1" >> $wrkdir/Jobit/inp2.txt                              # @nprocs
    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F2no_def2" ] || [ $i = "${j}F2o_def2" ]; then
      echo "0" >> $wrkdir/Jobit/inp2.txt                            # @charge jos frag2
    else
      echo "1" >> $wrkdir/Jobit/inp2.txt                            # @charge jos complex tai frag1
    fi
    echo "1"  >> $wrkdir/Jobit/inp2.txt                             # @multi
    echo ${i%%_*2}.xyz >> $wrkdir/Jobit/inp2.txt                    # @xyzfile
    echo "$wrkdir/${i}-${qt}.inp" >> $wrkdir/Jobit/inp2.txt         # lopullinen input-file jos normi

  #Semi-Pienille molekyyleille
    echo "$wrkdir/sbatch_sh.job" > $wrkdir/Jobit/job3.txt           # Eka jobfile ja scriptiin luettava tiedosto
    echo "parallel" >> $wrkdir/Jobit/job3.txt                       # @jono
    echo "16" >> $wrkdir/Jobit/job3.txt                             # @core
    echo "2" >> $wrkdir/Jobit/job3.txt                              # @node
    echo "32:00:00" >> $wrkdir/Jobit/job3.txt                       # @time
    echo "8000" >> $wrkdir/Jobit/job3.txt                           # @memcpu
    echo "${i}-${qt}" >> $wrkdir/Jobit/job3.txt                     # @jobname
    echo "$wrkdir/${i}-${qt}.job" >> $wrkdir/Jobit/job3.txt         # lopullinen jobfile

    if [[ -e $logs_dir/functional.txt ]]; then
      echo "$wrkdir/orca_sh_DFT.inp" > $wrkdir/Jobit/inp3.txt        # Eka input-file ja scriptiin luettava tiedosto jos DFT
    else
      echo "$wrkdir/orca_sh_HF.inp" > $wrkdir/Jobit/inp3.txt            # Eka input-file ja scriptiin luettava tiedosto jo HF
    fi
    echo "$method" >> $wrkdir/Jobit/inp3.txt                         # @method
    echo "def2-${qt}ZVPP" >> $wrkdir/Jobit/inp3.txt                 # @basis
    echo "7600" >> $wrkdir/Jobit/inp3.txt                           # @maxMem
    echo "16" >> $wrkdir/Jobit/inp3.txt                              # @nprocs
    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F2no_def2" ] || [ $i = "${j}F2o_def2" ]; then
      echo "0" >> $wrkdir/Jobit/inp3.txt                            # @charge jos frag2
    else
      echo "1" >> $wrkdir/Jobit/inp3.txt                            # @charge jos complex tai frag1
    fi
    echo "1"  >> $wrkdir/Jobit/inp3.txt                             # @multi
    echo ${i%%_*2}.xyz >> $wrkdir/Jobit/inp3.txt                    # @xyzfile
    echo "$wrkdir/${i}-${qt}.inp" >> $wrkdir/Jobit/inp3.txt         # lopullinen input-file jos normi

  #Bigmem molekyyleille
    echo "$wrkdir/sbatch_sh.job" > $wrkdir/Jobit/job4.txt           # Eka jobfile ja scriptiin luettava tiedosto
    echo "parallel" >> $wrkdir/Jobit/job4.txt                       # @jono
    echo "48" >> $wrkdir/Jobit/job4.txt                             # @core
    echo "4" >> $wrkdir/Jobit/job4.txt                              # @node
    echo "72:00:00" >> $wrkdir/Jobit/job4.txt                       # @time
    echo "10400" >> $wrkdir/Jobit/job4.txt                          # @memcpu
    echo "${i}-${qt}" >> $wrkdir/Jobit/job4.txt                     # @jobname
    echo "$wrkdir/${i}-${qt}.job" >> $wrkdir/Jobit/job4.txt         # lopullinen jobfile

    if [[ -e $logs_dir/functional.txt ]]; then
      echo "$wrkdir/orca_sh_DFT.inp" > $wrkdir/Jobit/inp4.txt        # Eka input-file ja scriptiin luettava tiedosto jos DFT
    else
      echo "$wrkdir/orca_sh_HF.inp" > $wrkdir/Jobit/inp4.txt            # Eka input-file ja scriptiin luettava tiedosto jo HF
    fi
    echo "$method" >> $wrkdir/Jobit/inp4.txt                         # @method
    echo "def2-${qt}ZVPP" >> $wrkdir/Jobit/inp4.txt                 # @basis
    echo "9800" >> $wrkdir/Jobit/inp4.txt                           # @maxMem
    echo "48" >> $wrkdir/Jobit/inp4.txt                             # @nprocs
    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F2no_def2" ] || [ $i = "${j}F2o_def2" ]; then
      echo "0" >> $wrkdir/Jobit/inp4.txt                            # @charge jos frag2
    else
      echo "1" >> $wrkdir/Jobit/inp4.txt                            # @charge jos complex tai frag1
    fi
    echo "1"  >> $wrkdir/Jobit/inp4.txt                             # @multi
    echo ${i%%_*2}.xyz >> $wrkdir/Jobit/inp4.txt                    # @xyzfile
    echo "$wrkdir/${i}-${qt}.inp" >> $wrkdir/Jobit/inp4.txt         # lopullinen input-file jos normi

  #SUURILLE molekyyleille
    echo "$wrkdir/sbatch_sh.job" > $wrkdir/Jobit/job5.txt           # Eka jobfile ja scriptiin luettava tiedosto
    echo "hugemem" >> $wrkdir/Jobit/job5.txt                        # @jono
    echo "40" >> $wrkdir/Jobit/job5.txt                             # @core
    echo "1" >> $wrkdir/Jobit/job5.txt                              # @node
    echo "32:00:00" >> $wrkdir/Jobit/job5.txt                       # @time
    echo "37000" >> $wrkdir/Jobit/job5.txt                          # @memcpu
    echo "${i}-${qt}" >> $wrkdir/Jobit/job5.txt                     # @jobname
    echo "$wrkdir/${i}-${qt}.job" >> $wrkdir/Jobit/job5.txt         # lopullinen jobfile

    if [[ -e $logs_dir/functional.txt ]]; then
      echo "$wrkdir/orca_sh_DFT.inp" > $wrkdir/Jobit/inp5.txt        # Eka input-file ja scriptiin luettava tiedosto jos DFT
    else
      echo "$wrkdir/orca_sh_HF.inp" > $wrkdir/Jobit/inp5.txt            # Eka input-file ja scriptiin luettava tiedosto jo HF
    fi
    echo "$method" >> $wrkdir/Jobit/inp5.txt                         # @method
    echo "def2-${qt}ZVPP" >> $wrkdir/Jobit/inp5.txt                 # @basis
    echo "36000" >> $wrkdir/Jobit/inp5.txt                          # @maxMem
    echo "40" >> $wrkdir/Jobit/inp5.txt                             # @nprocs
    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F2no_def2" ] || [ $i = "${j}F2o_def2" ]; then
      echo "0" >> $wrkdir/Jobit/inp5.txt                            # @charge jos frag2
    else
      echo "1" >> $wrkdir/Jobit/inp5.txt                            # @charge jos complex tai frag1
    fi
    echo "1"  >> $wrkdir/Jobit/inp5.txt                             # @multi
    echo ${i%%_*2}.xyz >> $wrkdir/Jobit/inp5.txt                    # @xyzfile
    echo "$wrkdir/${i}-${qt}.inp" >> $wrkdir/Jobit/inp5.txt         # lopullinen input-file jos normi


    pwd >> $logs_dir/Import${qt}.txt
    ls $wrkdir >> $logs_dir/Import${qt}.txt

  done
echo "____________________________________________________________________________" >> $logs_dir/Import${qt}.txt
done

echo "Input-tiedostot kansioisssaan" >> $logs_dir/Import${qt}.txt
