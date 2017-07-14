#!/bin/bash

# Convenience functions
install_mods() {
  echo "Installing mods"
  # This is tricky. The mods contain the 'addons' folder, and you can't extract
  # them with 'tar -xvf <file> .', as they don't have a '.' directory.
  MOD_DIR="$TF2/tf/addons"
  if [ ! -d "$MOD_DIR" ]; then
    mkdir -p "$MOD_DIR"
  fi
  cd $MOD_DIR/..
  for mod in ~/mods/*; do
    echo "Installing ${mod} to $MOD_DIR"
    tar -zxf "$mod"
  done
}

install_configs() {
  # Install admin text for sourcemod
  echo "Installing Configs"
  cp $HOME/config/admins_simple.ini $MOD_DIR/sourcemod/configs/admins_simple.ini
  cp $HOME/config/core.cfg $MOD_DIR/sourcemod/configs/core.cfg
  cp $HOME/config/sourcemod.cfg $TF2/tf/cfg/sourcemod/sourcemod.cfg
  cp $HOME/config/server.cfg $TF2/tf/cfg/server.cfg
}

run_server() {
  cd $TF2
  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SERVER/linux32:$SERVER/linux64 ./srcds_run -game tf -autoupdate -steam_dir $SERVER -steamcmd_script $SERVER/tf2_ds.txt $@
}

update_server() {
  $SERVER/steamcmd.sh +runscript tf2_ds.txt 
}

# Variables
SERVER=$HOME/hlserver
TF2=$SERVER/tf2

# Start main script
cp $HOME/tf2_ds.txt $SERVER
cd $SERVER

if [ ! -e $TF2/srcds_run ]; then
  update_server
fi

install_mods
install_configs

run_server $@
