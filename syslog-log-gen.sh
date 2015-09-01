#!/bin/bash

################################################
#             Syslog Log Generator             #
#      Author: Nathan R. Wray (m4dh4tt3r)      #
################################################

getTime=$(date --date="-6 month" "+%s")
genTime=("100" "10" "25" "36" "22" "41" "600" "55" "74")
srcPort=$((1024 + $((RNADOM % 65535))))
userName=("jtbowers" "smcappo" "plmarro" "ttarcol")
hostName=("salt" "pepper" "oregano" "paprika" "parsley")
syslogHost=$(awk '{ print $4 }' syslog | head -n 1)
thisHost="${hostName[$RANDOM % ${#hostName[@]}]}"

for ((i=0; i<10000; i++))
do
  genIP=("192.168.$((RANDOM % 10)).$((1 + $((RANDOM % 254))))" "65.47.$((RANDOM % 254)).$((1 + $((RANDOM % 254))))" "39.$((RANDOM % 254)).$((RANDOM % 10)).$((1 + $((RANDOM % 254))))")
  srcIP="${genIP[$RANDOM % ${#genIP[@]}]}"

  grep -q "${thisHost}" syslog
  case $? in
    0)
      :
    ;;
    1)
      sed -i "s/${syslogHost}/${thisHost}/g" syslog > /dev/null
    ;;
    *)
      echo "Could not determine the hosts in syslog. Exiting..."
    ;;
  esac

  # Get value to increment epoch
  incrementTime="${genTime[$RANDOM % ${#genTime[@]}]}"

  # Add epoch + value of incrementTime
  newTimeEpoch=$((incrementTime + getTime))

  # Take the new epoch value and put it in Apache log format
  newTime=$(date -d @"${newTimeEpoch}" "+%d/%b/%Y:%H:%M:%S")

  randPid="$((2000 + $((RANDOM % 65536))))"
  user="${userName[$RANDOM % ${#userName[@]}]}"
  syslogMsgs=("${newTime} ${thisHost} sshd[${randPid}]: Accepted password for ${user} from  ${srcIP} port ${srcPort} ssh2" \
              "${newTime} ${thisHost} sshd[${randPid}]: Accepted publickey for ${user} from  ${srcIP} port ${srcPort} ssh2\n${newTime} ${thisHost} ${serv}[${randPid}]: subsystem request for sftp" \
              "${newTime} ${thisHost} sshd[${randPid}]: Failed non for illegal user ${user} from ${srcIP} port ${srcPort} ssh2\n${newTime} ${thisHost} sshd[${randPid}]: Failed keyboard-interactive for illegal user ${userName[$RANDOM % ${#userName[@]}]} from ${srcIP} port ${srcPort} ssh2" \
              "${newTime} ${thisHost} sshd[${randPid}]: pam_unix(sshd:session): session opened for user ${user} by (uid=0)" \
              "${newTime} ${thisHost} sshd[${randPid}]: Disconnecting: Too many authentication failures for ${user}" \
              "${newTime} ${thisHost} CROND[${randPid}]: (cronjob) CMD (/usr/local/bin/sysCheck.sh)" \
              "${newTime} ${thisHost} CROND[${randPid}]: (cronjob) CMD (/etc/cron.hourly/watchdog)" \
              "${newTime} ${thisHost} CROND[${randPid}]: (cronjob) CMD (/etc/cron.hourly/cleanLog.sh)" \
              "${newTime} ${thisHost} avahi-autoipd(eth0)[${randPid}]: Found user 'avahi-autoipd' (UID 105) and group 'avahi-autoipd' (GID 117)." \
              "${newTime} ${thisHost} avahi-autoipd(eth0)[${randPid}]: Successfully called chroot()." \
              "${newTime} ${thisHost} avahi-autoipd(eth0)[${randPid}]: Successfully dropped root privileges." \
              "${newTime} ${thisHost} ntpd[${randPid}]: Deleting interface #3 eth0, ${srcIP}#123, interface stats: received=278, sent=322, dropped=0, active_time=8505 secs" \
              "${newTime} ${thisHost} ntpd[${randPid}]: 91.189.89.199 interface ${srcIP} -> (none)" \
              "${newTime} ${thisHost} ntpd[${randPid}]: 74.91.27.139 interface ${srcIP} -> (none)" \
              "${newTime} ${thisHost} ntpd[${randPid}]: 72.20.40.62 interface ${srcIP} -> (none)" \
              "${newTime} ${thisHost} /etc/mysql/debian-start${randPid}]: Looking for 'mysqlcheck' as: /usr/bin/mysqlcheck" \
              "${newTime} ${thisHost} /etc/mysql/debian-start[${randPid}]: Looking for 'mysql' as: /usr/bin/mysql" \
              "${newTime} ${thisHost} /etc/mysql/debian-start[${randPid}]: This installation of MySQL is already upgraded to 5.5.43, use --force if you still need to run mysql_upgrade" \
              "${newTime} ${thisHost} /etc/mysql/debian-start[${randPid}]: Checking for insecure root accounts." \
              "${newTime} ${thisHost} anacron[${randPid}]: Normal exit (0 jobs run)")

  echo -e "${syslogMsgs[$RANDOM % ${#syslogMsgs[@]}]}" >> /root/log-gen/syslog

  let getTime="${newTimeEpoch}"
done
