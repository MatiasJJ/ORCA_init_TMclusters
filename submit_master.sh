#!bin/bash

base=$(pwd)

rcts=$(cat $base/rcts.txt)
rcts_dir="$base/$rcts"
logs_dir="$base/$rcts/Logs"
echo "Kaikki logit löytyy kansiosta $rcts_dir/Logs"

echo "Q vai T? ISOLLA"
read qt

# echo "1. vai 2. kierros? (1/2)"
# echo "# 1. kierros lähettää kaikki!!!"
# echo "# 2. kierros lähettää vain spesifioidut.."

#read round

#if [ $round = "1" ]; then
#      echo 'kierros 1, eli KAIKKI!'

bash $base/Manage_files/submit_all.sh $base $rcts $rcts_dir $logs_dir $qt        # submit all

#elif [ $round = "2" ]; then
#      echo 'kierros 2, eli pelkästään *2.job -päätteiset tiedostot, joita ei nyt ole olemassa O_o'
#      bash $base/Manage_files/submit_all2.sh $base $qt $(cat $base/Logs/rcts.txt)       # submit all
#fi
