job=$1
core=$2
node=$3
time=$4
jobname=$5
jobfile=$6

echo "Jobfile: $6"

cp $1 $6

sed -i "s/@core/$core/g" $6
sed -i "s/@node/$node/g" $6
sed -i "s/@time/$time/g" $6
sed -i "s/@jobname/$jobname/g" $6
