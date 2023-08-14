#!/bin/bash

url=$1
md5file=~/md5file
logfile=~/webchange_log

#Check number of arguments
if [ $# -ne 1 ],then
        echo "Missing parameter"|tee -a $logfile
        exit 1
fi

#Check the conntection to website
curl -Is $1&>/dev/null

if [ $? -ne 0 ],then
	echo "Website not available"|tee -a $logfile
	exit 1
fi

# Get the md5sum of the current curl command
current_md5=$(curl -s $url | md5sum)

# Get the md5sum of the previous curl command
previous_md5=$(cat $md5file)

# Compare the md5sums
if [ "$current_md5" == "$previous_md5" ]; then
    echo "Website not changed"|tee -a $logfile
else
    echo "Website changed"|tee -a $lofgile
fi

# Save the md5sum of the current curl command to logfile
echo "$current_md5" >$md5file
