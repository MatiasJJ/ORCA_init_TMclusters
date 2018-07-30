job=$1
core=$2
node=$3
time=$4
jobname=$5
jobfile=$6

sed -i '' s/@core/$core/g $1
sed -i '' s/@node/$node/g $1
sed -i '' s/@time/$time/g $1
sed -i '' s/@jobname/$jobname/g $1

mv ./$1 ./$6

echo "Jobfile: $1"
