#!bin/bash

base=$(pwd)

mkdir $base/Tulokset
echo "Kaikki tulokset löytyy kansiosta $base/Tulokset"

echo "Q vai T? ISOLLA"
read qt

#bash $base/Manage_files/runTime.sh $base $qt $(cat $base/Logs/rcts.txt)      # lukee kaua kesti
bash $base/Manage_files/results.sh $base $qt $(cat $base/Logs/rcts.txt)       # kaikki Tulokset
