#!/bin/bash

dir=$(pwd)

printf "" > $dir/RunTime.txt            # Tekee aina uuden tiedoston
echo "Laskut kesti näin kauan.." >> $dir/RunTime.txt
echo "Menikö ne ees läpi?"

for i in $(seq -f "%02g" 1 10);
do
        echo "Reaction$i" >> $dir/RunTime.txt
        echo "" >> $dir/RunTime.txt
        cd $dir/Reaction${i}/def2-T/
        subdir=$(pwd)

        for j in ${i}{C_,F1b_,F1no_,F1o_,F2b_,F2no_,F2o_}def2-T
        do
                cd $j
                wrkdir=$(pwd)
                echo $j >> $dir/RunTime.txt
                grep -i -h 'ORCA terminated normally' $wrkdir/$j.out >> $dir/RunTime.txt
                echo "" >> $dir/RunTime.txt
                grep -i -h 'finished by error' $wrkdir/$j.out >> $dir/RunTime.txt
                echo "" >> $dir/RunTime.txt
                grep -i -h 'Total run time' $wrkdir/$j.out >> $dir/RunTime.txt
                echo "" >> $dir/RunTime.txt
                cd $subdir
        done
        cd $dir
done
