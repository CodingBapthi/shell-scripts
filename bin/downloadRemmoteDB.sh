#!/bin/bash

remote_host=$1
remote_db=$2
compress=true

if grep -q $remote_host ~/.ssh/config; then
  if ssh -F ~/.ssh/config $remote_host "which gzip" ; then
      echo "gzip is installed"
  else
      echo "gzip is not installed, dump file will not be compressed"
      compress=false
  fi
  if [[ "$compress" = true ]]; then
    ssh -F ~/.ssh/config $remote_host "mysqldump -h $remote_host -u root -p $remote_db | gzip > $remote_db.sql.gz"
    dump_size=$(ssh -F ~/.ssh/config $remote_host "du -b --apparent-size $remote_db.sql.gz | awk '{print \$1}'")
    current_size=0
    while [ $current_size -lt $dump_size ]
    do
        current_size=$(ssh -F ~/.ssh/config $remote_host "du -b --apparent-size $remote_db.sql.gz | awk '{print \$1}'")
        percent=$(( $current_size * 100 / $dump_size ))
        echo -ne "Dumping: $percent %\r"
    done
    read -p "Enter the name of the local dump file: " local_file
    scp -F ~/.ssh/config $remote_host:$remote_db.sql.gz $local_file.sql.gz
  else
    ssh -F ~/.ssh/config $remote_host "mysqldump -h $remote_host -u root -p $remote_db > $remote_db.sql"
    dump_size=$(ssh -F ~/.ssh/config $remote_host "du -b --apparent-size $remote_db.sql | awk '{print \$1}'")
    current_size=0
    while [ $current_size -lt $dump_size ]
    do
        current_size=$(ssh -F ~/.ssh/config $remote_host "du -b --apparent-size $remote_db.sql | awk '{print \$1}'")
        percent=$(( $current_size * 100 / $dump_size ))
        echo -ne "Dumping: $percent %\r"
    done
    read -p "Enter the name of the local dump file: " local_file
    scp -F ~/.ssh/config $remote_host:$remote_db.sql $local_file.sql
  fi
  ssh -F ~/.ssh/config $remote_host "rm $remote_db.sql*"
  echo "Dump file successfully downloaded and deleted from remote host"
  read -p "Do you want to unpack the file? (y/n) " unpack
  if [[ "$compress" = true && "$unpack" = "y" ]]; then
    gunzip $local_file.sql.gz -c > $local_file.sql
  fi
else
	echo "Remote host not found in ssh config file. Please check the hostname and try again."
fi