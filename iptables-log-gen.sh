#!/bin/bash

################################################
#            IPTables Log Generator            #
#      Author: Nathan R. Wray (m4dh4tt3r)      #
################################################

getTime=$(date --date="-6 month" "+%s")
genTime=("100" "10" "25" "36" "22" "41" "600" "55" "74")
hostName=("salt" "pepper" "oregano" "paprika" "parsley")
protType=("TCP" "UDP" "ICMP")			 
thisHost="${hostName[$RANDOM % ${#hostName[@]}]}"

actionArr=("ACCEPT" "DROP")
interfaceArr=("eth0" "eth1" "eth2" "vlan200" "vlan300" "vlan400" "br0")

for ((i=0; i<10000; i++))
do
  genIP=("192.168.$((RANDOM % 10)).$((1 + $((RANDOM % 254))))" "65.47.$((RANDOM % 254)).$((1 + $((RANDOM % 254))))" "39.$((RANDOM % 254)).$((RANDOM % 10)).$((1 + $((RANDOM % 254))))")
  srcIP="${genIP[$RANDOM % ${#genIP[@]}]}"
  dstIP="${genIP[$RANDOM % ${#genIP[@]}]}"

  srcPort=$((1 + $((RNADOM % 65535))))
  dstPort=$((1 + $((RNADOM % 65535))))
  
  pktRsp=("ACK SYN URGP=0" "SYN URGP=0" "ACK URGP=0" "ACK FIN URGP=0" "ACK PSH URGP=0" "ACK PSH FIN URGP=0")
  optionalArr=("WINDOW=$((15000 + $((RANDOM % 60000)))) RES=0x00 ${pktRsp[$RANDOM % ${#pktRsp[@]}]}" "LEN=$((20 + $((RANDOM % 2000))))")
  
  # Get value to increment epoch
  incrementTime="${genTime[$RANDOM % ${#genTime[@]}]}"

  # Add epoch + value of incrementTime
  newTimeEpoch=$((incrementTime + getTime))

  # Take the new epoch value and put it in Apache log format
  newTime=$(date -d @"${newTimeEpoch}" "+%b %d %Y %H:%M:%S")

  #Second date is 3 letter month day of month time HH:MM:SS
  echo -e "${newTime} ${thisHost} kernel: ${actionArr[$RANDOM % ${#actionArr[@]}]} IN=${interfaceArr[$RANDOM % ${#interfaceArr[@]}]} OUT=${interfaceArr[$RANDOM % ${#interfaceArr[@]}]} SRC=${srcIP} DST=${dstIP} LEN=${RANDOM} TOS=0x00 PREC=0x00 TTL=$((20 + $((RANDOM % 50)))) ID=$((15000 + $((RANDOM % 60000)))) PROTO=${protType[$RANDOM % ${#protType[@]}]} SPT=${srcPort} DPT=${dstPort} ${optionalArr[$RANDOM % ${#optionalArr[@]}]}" >> /root/log-gen/iptables.log


  let getTime="${newTimeEpoch}"
done
