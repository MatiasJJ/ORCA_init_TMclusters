inp_in=$1
method=$2
functional=$3
basis=$4
maxMem=$5
procs=$6
charge=$7
multi=$8
xyz=$9
inp_out=${10}

echo "Input file from: $1"
echo "Input file to: ${10}"

cp $1 ${10}

#mac
sed -i '' "s/@method/$method/g" ${10}
sed -i '' "s/@functional/$functional/g" ${10}
sed -i '' "s/@basis/$basis/g" ${10}
sed -i '' "s/@maxMem/$maxMem/g" ${10}
sed -i '' "s/@nprocs/$procs/g" ${10}
sed -i '' "s/@charge/$charge/g" ${10}
sed -i '' "s/@multi/$multi/g" ${10}
sed -i '' "s/@xyzfile/$xyz/g" ${10}

#linux
#sed -i "s/@method/$method/g" ${10}
#sed -i "s/@functional/$functional/g" ${10}
#sed -i "s/@basis/$basis/g" ${10}
#sed -i "s/@maxMem/$maxMem/g" ${10}
#sed -i "s/@nprocs/$procs/g" ${10}
#sed -i "s/@charge/$charge/g" ${10}
#sed -i "s/@multi/$multi/g" ${10}
#sed -i "s/@xyzfile/$xyz/g" ${10}
