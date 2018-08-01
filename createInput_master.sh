#!bin/bash

base=$(pwd)

#mkdir $base/Logs
echo "Kaikki logit löytyy kansiosta $base/Logs"

echo "Q vai T? ISOLLA"
read qt

echo "1. vai 2. kierros? (1/2)"

echo "# 2. kierros tarkottaa säädettyjä input-tiedostoja.."

read round

if [ $round = "1" ]; then
      echo "kierros 1"
      bash $base/Manage_files/inputs.sh $base $qt $(cat $base/Logs/rcts.txt)           # tekee varsinaiset input-tiedostot
fi

if [ $round = "2" ]; then
      echo "kierros 2"
      bash $base/Manage_files/inputs2.sh $base $qt $(cat $base/Logs/rcts.txt)          # tekee varsinaiset input-tiedostot
      bash $base/Manage_files/submit_all.sh $base $qt $(cat $base/Logs/rcts.txt)       # submit all
fi
