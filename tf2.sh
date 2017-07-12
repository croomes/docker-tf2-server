#!/bin/sh

run_server() {
  cd $TF2
  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SERVER/linux32:$SERVER/linux64 ./srcds_run -game tf -autoupdate -steam_dir $SERVER -steamcmd_script $SERVER/tf2_ds.txt $@
}

update_server() {
  $SERVER/steamcmd.sh +runscript tf2_ds.txt 
}

SERVER=$HOME/hlserver
TF2=$SERVER/tf2

cp $HOME/tf2_ds.txt $SERVER
cd $SERVER

if [ ! -e $TF2/srcds_run ]; then
  update_server
fi

run_server $@
