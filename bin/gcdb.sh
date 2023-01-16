#!/bin/bash

  remote_host=$1
  remote_db=$2
  local_folder=$3

  # Check for required parameters
  if [ -z "$remote_host" ] || [ -z "$remote_db" ] || [ -z "$local_folder" ]; then
    echo "Usage: gcdb.sh [remote host] [remote database] [local folder]"
    exit 1
  fi

  # Check for required commands
  if ! command -v ssh >/dev/null 2>&1; then
    echo "Error: ssh command not found"
    exit 1
  fi
  if ! command -v mysqldump >/dev/null 2>&1; then
    echo "Error: mysqldump command not found"
    exit 1
  fi
  if ! command -v mysql >/dev/null 2>&1; then
    echo "Error: mysql command not found"
    exit 1
  fi
