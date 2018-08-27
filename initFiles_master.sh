#!bin/bash

base=$(pwd)

echo "Q vai T? ISOLLA"
echo "Q ei tee enää kansioita.."
read qt

if [ "$qt" = 'T' ]; then
  echo 'Nii minkäs niminen se kansio olikaa mihi halut kaikki reaktiot? esim. Laskut_ORCA_HF'
  read rcts
  mkdir $base/$rcts
  mkdir $base/$rcts/Logs
  echo $rcts > $base/rcts.txt
  #echo $rcts_dir > $base/rcts_dir.txt
  rcts_dir="$base/$rcts"
  logs_dir="$base/$rcts/Logs"

  bash $base/Manage_files/mkdirs.sh $base $rcts $rcts_dir $logs_dir          # tekee kansiot

elif [ "$qt" = 'Q' ]; then
    echo "Eli T-laskut ja kansiorakenne pitää olla jo tehty, muuten tää menee pipariks.."
    rcts=$(cat $base/rcts.txt)
    rcts_dir="$base/$rcts"
    logs_dir="$base/$rcts/Logs"
    bash $base/Manage_files/gbw.sh $base $rcts $rcts_dir $logs_dir          # kopsaa orbitaalit
fi
echo "Kaikki logit löytyy kansiosta $logs_dir"

bash $base/Manage_files/import.sh $base $rcts $rcts_dir $logs_dir $qt       # vie tiedostot

bash $base/Manage_files/mol123.sh $base $rcts $rcts_dir $logs_dir $qt           # Valitsee pienet (mol2) ja isot (mol3)
bash $base/Manage_files/inputs.sh $base $rcts $rcts_dir $logs_dir $qt           # tekee varsinaiset input-tiedostot
bash $base/Manage_files/coord_toinp.sh $base $rcts $rcts_dir $logs_dir $qt      # vie koordinaatit inp-tiedostoihin

tree $rcts_dir > $logs_dir/"tree_${rcts}.txt"
