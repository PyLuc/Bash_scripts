#!/bin/bash
#when available memory is getting low, email will be sent

available_memory=$(free --mega|awk 'NR==2{print $7}')
timestamp=$(date +%d-%m-%Y' '%T)

if [ $available_memory -le 500 ];then echo "memory is lower than 500 Mb at $timestamp"|mail -s 'Low memory warning' lukaskrch92@gmail.com;fi


