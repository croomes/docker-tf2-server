#!/bin/bash
set -euo pipefail

# Default variables if not set in the environment
export SERVER_CFG_URL="${SERVER_CFG_URL:-https://raw.githubusercontent.com/anoldguy/docker-tf2-server/master/server.cfg}"

export ADMIN_USERS_URL="${ADMIN_USERS_URL:-https://raw.githubusercontent.com/anoldguy/docker-tf2-server/master/admins_simple.ini}"

export CORE_CFG_URL="${CORE_CFG_URL:-https://raw.githubusercontent.com/anoldguy/docker-tf2-server/master/core.cfg}"

SERVER_OPTS="${@:-+exec server.cfg}"

VOLUME_NAME="${VOLUME_NAME:-tf2-data}"

# Server defaults. Don't use these, override them!
RCON_PASSWORD="${RCON_PASSWORD:-foobar}"
CONTACT="${CONTACT:-you@gmail.com}"
SERVER_NAME=${SERVER_NAME:-Beren\'s Haus of Pain}
SERVER_URL="${SERVER_URL:-http://tf2.collabry.com}"

# Check for dependencies
check_dependencies() {
  for prog in docker curl
  do
    which "$prog" > /dev/null 2>&1 || (echo "$prog must be installed to run this script...";exit 128)
  done
}

check_docker_volume() {
  docker volume list "${1}"
}

create_docker_volume() {
  docker volume create "${1}"
}

create_config_files() {
  if [ ! -d config ]; then 
    mkdir config;
    pushd config
    curl -O "${SERVER_CFG_URL}"
    curl -O "${CORE_CFG_URL}"
    curl -O "${ADMIN_USERS_URL}"
    popd
  fi
}

set_server_opts() {
  echo " +rcon_password $RCON_PASSWORD +sv_contact $CONTACT +hostname '$SERVER_NAME' ${SERVER_OPTS}"
}

run_docker_server() {
  volume="${1}"
  docker run \
    -v config:/home/tf2/config \
    -v ${volume}:/home/tf2/hlserver/tf2 \
    -p 27015:27015/udp -p 27015:27015/tcp \
    mrndrsn/tf2-server \
    "$(set_server_opts)"
}

check_docker_volume "${VOLUME_NAME}" || create_docker_volume "${VOLUME_NAME}"

run_docker_server "${VOLUME_NAME}"
