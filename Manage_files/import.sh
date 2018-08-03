#!/bin/bash

dir=$1              # Base
qt=$2
rcts=$3             # Base/Lasku

coord_dir=$dir/Coord_all

echo "Mikä metodi? RHF/UHF/RKS/UKS ISOLLA"
read method                                                   # Käyttäjä määrittelee metodin

echo "INIT: import.sh"                                        # nii että mitä ollaa tekemäässä
echo "Import-logi löytyy tiedostosta $dir/Logs/Import.txt"
echo __________________________________________________________________________________________
echo 'Input-fileet kansioihin' > $dir/Logs/Import.txt         # Logia
pwd >> $dir/Logs/Import.txt

for j in $(seq -f "%02g" 1 10); do                            # Reaction-kansiot läpi
cd $dir/$rcts/Reaction$j
subdir=$(pwd)
  for i in ${j}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2; do   # Species-kansiot läpi
    cd $subdir/def2-${qt}/${i}-${qt}/                         # T ja Q erikseen
    wrkdir=$(pwd)
    cp $dir/Input/* $wrkdir                                   # Tarvittavat input-fileet Species-kansioihin

    cp $coord_dir/${i%%_*2}.xyz $wrkdir                       # Oikea koordinaatisto mukaan

    echo "$wrkdir/sbatch_sh.job" > $wrkdir/job.txt            # Eka jobfile ja scriptiin luettava tiedosto
    echo "96" >> $wrkdir/job.txt                              # @core
    echo "4" >> $wrkdir/job.txt                               # @node
    echo "24:00:00" >> $wrkdir/job.txt                        # @time
    echo "${i}-${qt}" >> $wrkdir/job.txt                      # @jobname
    echo "$wrkdir/${i}-${qt}.job" >> $wrkdir/job.txt          # lopullinen jobfile

    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F1b_def2" ]; then
      echo "$wrkdir/orca_shB.inp" > $wrkdir/inp.txt              # Eka input-file ja scriptiin luettava tiedosto jos BSSE
    else
      echo "$wrkdir/orca_sh.inp" > $wrkdir/inp.txt              # Eka input-file ja scriptiin luettava tiedosto jos normi
    fi

    echo "$method" >> $wrkdir/inp.txt                         # @method
    echo "def2-${qt}ZVPP" >> $wrkdir/inp.txt                  # @basis
    echo "4400" >> $wrkdir/inp.txt                            # @maxMem
    echo "96" >> $wrkdir/inp.txt                              # @nprocs
    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F2no_def2" ] || [ $i = "${j}F2o_def2" ]; then
      echo "0" >> $wrkdir/inp.txt                             # @charge jos frag2
    else
      echo "1" >> $wrkdir/inp.txt                             # @charge jos complex tai frag1
    fi
    echo "1"  >> $wrkdir/inp.txt                              # @multi

    echo ${i%%_*2}.xyz >> $wrkdir/inp.txt                     # @xyzfile


#    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F1b_def2" ]; then
#      echo "$wrkdir/${i}-${qt}B.inp" >> $wrkdir/inp.txt          # lopullinen input-file jos BSSE
#    else
      echo "$wrkdir/${i}-${qt}.inp" >> $wrkdir/inp.txt          # lopullinen input-file jos normi
#    fi



    echo "$wrkdir/sbatch_sh.job" > $wrkdir/job2.txt
    echo "24" >> $wrkdir/job2.txt
    echo "1" >> $wrkdir/job2.txt
    echo "24:00:00" >> $wrkdir/job2.txt
    echo "${i}-${qt}" >> $wrkdir/job2.txt
    echo "$wrkdir/${i}-${qt}.job" >> $wrkdir/job2.txt

    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F1b_def2" ]; then
      echo "$wrkdir/orca_shB.inp" > $wrkdir/inp2.txt              # Eka input-file ja scriptiin luettava tiedosto jos BSSE
    else
      echo "$wrkdir/orca_sh.inp" > $wrkdir/inp2.txt              # Eka input-file ja scriptiin luettava tiedosto jos normi
    fi
    echo "$method" >> $wrkdir/inp2.txt
    echo "def2-${qt}ZVPP" >> $wrkdir/inp2.txt
    echo "4400" >> $wrkdir/inp2.txt
    echo "24" >> $wrkdir/inp2.txt
    if [ $i = "${j}F2b_def2" ] || [ $i = "${j}F2no_def2" ] || [ $i = "${j}F2o_def2" ]; then
      echo "0" >> $wrkdir/inp2.txt
    else
      echo "1" >> $wrkdir/inp2.txt
    fi
    echo "1"  >> $wrkdir/inp2.txt

    echo ${i%%_*2}.xyz >> $wrkdir/inp2.txt

    echo "$wrkdir/${i}-${qt}.inp" >> $wrkdir/inp2.txt

    pwd >> $dir/Logs/Import.txt
    ls $wrkdir >> $dir/Logs/Import.txt

  done
cd ..
echo "____________________________________________________________________________" >> $dir/Logs/Import.txt
done

echo "Input-tiedostot kansioisssaan" >> $dir/Logs/Import.txt
