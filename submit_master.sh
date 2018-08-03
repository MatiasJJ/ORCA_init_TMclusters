#!bin/bash

base=$(pwd)

#mkdir $base/Logs
echo "Kaikki logit löytyy kansiosta $base/Logs"

echo "Q vai T? ISOLLA"
read qt

echo "1. vai 2. kierros? (1/2)"

echo "# 1. kierros lähettää kaikki anyways!!!"
echo "# 2. kierros lähettää vain inp2-tiedostot.."

read round

if [ $round = "1" ]; then
      echo 'kierros 1, eli KAIKKI mitä siellä sattu olemaan .job-fileitä!'
      echo 'Jos olit tehny järkevästi createInput_masterilla kierrokset 1. ja 2.'
      echo 'nii tarpeettomat inp1-fileet pitäs olla omissa kansioisssaan pois tieltä..'
      bash $base/Manage_files/submit_all.sh $base $qt $(cat $base/Logs/rcts.txt)       # submit all
fi

if [ $round = "2" ]; then
      echo 'kierros 2, eli pelkästään *2.job -päätteiset tiedostot, joita ei nyt ole olemassa O_o'
      bash $base/Manage_files/submit_all2.sh $base $qt $(cat $base/Logs/rcts.txt)       # submit all

fi
