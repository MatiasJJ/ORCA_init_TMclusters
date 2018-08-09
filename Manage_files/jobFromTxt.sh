job=$1
core=$2
node=$3
time=$4
memcpu=$5
jobname=$6
jobfile=$7

echo "Jobfile: $7"

cp $1 $7

#mac
sed -i '' "s/@core/$core/g" $7
sed -i '' "s/@node/$node/g" $7
sed -i '' "s/@time/$time/g" $7
sed -i '' "s/@memcpu/$memcpu/g" $7
sed -i '' "s/@jobname/$jobname/g" $7

#linux
sed -i "s/@core/$core/g" $7
sed -i "s/@node/$node/g" $7
sed -i "s/@time/$time/g" $7
sed -i "s/@memcpu/$memcpu/g" $7
sed -i "s/@jobname/$jobname/g" $7
