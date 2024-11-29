#!/bin/bash

# Function to write alert to a file
write_alert() {
    local subject=$1
    local body=$2
    local user=$USER
    local alert_notification="/home/aryan/linux_assessment/que2/disk_space_alert.txt"

    echo -e "Subject: $subject\n$body" >> "$alert_notification"
}

# a. Printing free and used memory (RAM)
echo "Memory Usage:"
free -h

# b. Printing disk space usage and writing alert if usage is greater than 50%
echo "Disk Space Usage:"
df -h

# Checking for any partitions with usage over 50%
alert=$(df -h | awk 'NR>1 && $5+0 > 50 { print $5 " " $6 }')

if [ ! -z "$alert" ]; then
    write_alert "Disk Space Alert" "The following partitions have usage over 50%:\n$alert"
fi

# c. Printing 10 largest files in the file system
echo "10 Largest Files in the File System:"
find / -type f -exec du -h {} + 2>/dev/null | sort -rh | head
