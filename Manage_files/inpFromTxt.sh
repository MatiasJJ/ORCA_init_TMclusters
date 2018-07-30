inp=$1
method=$2
basis=$3
maxMem=$4
procs=$5
charge=$6
multi=$7
xyz=$8
inp=$9

echo "Input file from: $1"
echo "Input file to: $9"

sed -i '' s/@method/$method/g $1
sed -i '' s/@basis/$basis/g $1
sed -i '' s/@maxMem/$maxMem/g $1
sed -i '' s/@nprocs/$procs/g $1
sed -i '' s/@charge/$charge/g $1
sed -i '' s/@multi/$multi/g $1
sed -i '' s/@xyzfile/$xyz/g $1

mv ./$1 ./$9
