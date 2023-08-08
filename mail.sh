#!/bin/bash
#when disk usage of root file system is getting high, email will be sent


#set correct your credentials to smtp server in /etc/postfix/sasl_passwd file
#set correct /etc/postfix/main.cf file

#fill in your email
your_email=<email>

#check disk usage of root file system
disk_usage=$(df -h / | awk '/\// {print $5}' | tr -d '%')
timestamp=$(date +%d-%m-%Y' '%T)

#send email if disk usage is higher than 90%
if [ $disk_usage -gt 90 ];then
  echo "disk usage is higher than 90% at $timestamp"|mail -s 'Disk usage warning' $your_email
fi
