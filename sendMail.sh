#!/bin/bash

csv_file="property_file.csv"

while IFS=, read -r mail_time email tasks
do
	if [ "$mail_time" == "time" ];then
	   continue
	fi

	scheduled_time=$(date -d "$mail_time -30 minutes" +"%H:%M")

	#Preparing subject
	subject = Task at $scheduled_time

	#Sending email
	echo "$tasks" | mail -s "$subject" "email"
	#displaying success message
	echo "Email sent to $mail for task:$task at time: $scheduled_time"

done < "$csv_file"
