#!/bin/bash

################################################
#              OSSEC Log Generator             #
#      Author: Nathan R. Wray (m4dh4tt3r)      #
################################################

sensorIP="192.168.23.2"
getTime=$(date --date="-6 month" "+%s")
genTime=("100" "10" "25" "36" "22" "41" "600" "55" "74")
hostName=("salt" "pepper" "oregano" "paprika" "parsley")
userArr=("jtbowers" "smcappo" "plmarro" "ttarcol")
userName="${userArr[$RANDOM % ${#userArr[@]}]}"	 
logArr=("/var/log/auth.log")
thisHost="${hostName[$RANDOM % ${#hostName[@]}]}"

for ((i=0; i<10000; i++))
do 
  # Get value to increment epoch
  incrementTime="${genTime[$RANDOM % ${#genTime[@]}]}"

  # Add epoch + value of incrementTime
  newTimeEpoch=$((incrementTime + getTime))

  # Take the new epoch value and put it in Apache log format
  newTime=$(date -d @"${newTimeEpoch}" "+%d/%b/%Y:%H:%M:%S")

  alertArr=("Login session opened." "Login session closed.")
  msgArr=("su[$((3000 + $((RANDOM % 40000))))]: pam_unix(su:session): session opened for user ${userName} by (uid=0)" \
          "su[$((3000 + $((RANDOM % 40000))))]: pam_unix(su:session): session opened for user ${userName}")

  #Second date is 3 letter month day of month time HH:MM:SS
  echo -e "${newTime} ${sensorIP} Alert Level: $((1 + $((RANDOM % 10)))); Rule: $((3000 + $((RANDOM % 40000)))) - ${alertArr[$RANDOM % ${#alertArr[@]}]}; Location: ${thisHost}->${logArr[$RANDOM % ${#logArr[@]}]}; ${sensorIP}; Jul 25 14:27:15 ${thisHost} ${msgArr[$RANDOM % ${#msgArr[@]}]}" >> /root/log-gen/ossec-hids.log


  let getTime="${newTimeEpoch}"
done
