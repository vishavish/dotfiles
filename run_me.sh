#!/usr/bin/bash
 
set -e 

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

if ! command_exists sudo; then
  echo "You need sudo to run me!"
  exit 1
fi

bash ./01-init.sh
bash ./02-dev.sh
bash ./03-rice.sh

sudo nala autoremove
