job=$1
jono=$2
core=$3
node=$4
time=$5
memcpu=$6
jobname=$7
jobfile=$8

echo "Jobfile: $8"

cp $1 $8

sed -i '' "s/@jono/$jono/g" $8
sed -i '' "s/@core/$core/g" $8
sed -i '' "s/@node/$node/g" $8
sed -i '' "s/@time/$time/g" $8
sed -i '' "s/@memcpu/$memcpu/g" $8
sed -i '' "s/@jobname/$jobname/g" $8
