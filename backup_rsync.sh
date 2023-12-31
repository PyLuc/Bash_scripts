#!/bin/bash

#backup the directory to remote server
#log the process to backup_log file

remote_server=$1
backup_directory=$2

#if remote username different from $USER then use $3 parameter
#default $3 parameter
remote_username=${3:-$USER}

backup_log=~/backup_log
backup_date=$(date +%d-%m-%Y)



#print help message
print_help () {
	echo -e "enter hostname or ip adress of remote server and path to backup directory\n"
	echo "Sample"
	echo -e "$0 <hostname || ip adress> <path to backup file>\n"
	echo "Example"
	echo "$0 www.example.com /home"
	echo "if remote username different from $USER then use $3 parameter"
}

#check correct number of arguments
if [ $# -ne 3 ];then
	echo "Bad number of argument"|tee -a $backup_log
	print_help
	exit 1
fi 

#check if hostname or IP adress is valid
if !  nslookup $remote_server&>/dev/null;then
	echo  "INVALID IP OR HOSTNAME"|tee -a $backup_log
	exit 1
fi 

#check if backup directory exists
if [ ! -d $backup_directory ]; then
	echo "backup directory not exists"|tee -a $backup_log
	exit 1
fi

#check connection to remote server
if ! ping -c1 $remote_server &>/dev/null; then
	echo "Remote server unreachable"|tee -a $backup_log
	exit 1
fi

echo "$backup_date Backup started">>$backup_log

#send directory to remote server using rsync
rsync -avz --timeout=10 -e "ssh -i ~/.ssh  -o ConnectTimeout=5"  $backup_directory $remote_username@$remote_server:~ &>>$backup_log

if [ $? -ne 0 ]; then 
		echo "$backup_date Backup failed">>$backup_log
	else  
		echo "$backup_date Backup succesfull">>$backup_log
fi
