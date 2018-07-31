#!bin/bash

base=$(pwd)

mkdir $base/Logs
echo "Kaikki logit löytyy kansiosta $base/Logs"

echo "Q vai T? ISOLLA"
read qt

if [ "$qt" = 'T' ]; then
  bash $base/Manage_files/mkdirs.sh $base         # tekee kansiot
fi


bash $base/Manage_files/import.sh $base $qt $(cat $base/Logs/rcts.txt)       # vie tiedostot



if [ "$qt" = 'Q' ]; then
  echo "Oletan, että T-laskut ja kansiorakenne on jo tehty, muuten tää menee vituiks.."
fi
