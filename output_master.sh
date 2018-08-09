#!bin/bash

base=$(pwd)

rcts=$(cat $base/rcts.txt)
rcts_dir="$base/$rcts"
logs_dir="$base/$rcts/Logs"

mkdir $rcts_dir/Tulokset
echo "Kaikki tulokset löytyy kansiosta $rcts_dir/Tulokset"

echo "Q vai T? ISOLLA"
read qt

bash $base/Output/results.sh $base $rcts $rcts_dir $logs_dir $qt       # kaikki Tulokset
