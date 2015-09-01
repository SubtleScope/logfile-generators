#!/bin/bash

################################################
#              Snort Log Generator             #
#      Author: Nathan R. Wray (m4dh4tt3r)      #
################################################

sensorIP="192.168.23.2"
getTime=$(date --date="-6 month" "+%s")
genTime=("100" "10" "25" "36" "22" "41" "600" "55" "74")
hostName=("salt" "pepper" "oregano" "paprika" "parsley")
protType=("TCP" "UDP" "ICMP")
snortAlerts=("Attempted Administrator Privilege Gain" "Attempted User Privilege Gain" \
             "Inappropriate Content was Detected" "Potential Corporate Privacy Violation" \
             "Executable code was detected" "Successful Administrator Privilege Gain" \
             "Successful User Privilege Gain" "A Network Trojan was detected" \
             "Unsuccessful User Privilege Gain" "Web Application Attack" "Attempted Denial of Service" \
             "Attempted Information Leak" "Potentially Bad Traffic" \
             "Attempt to login by a default username and password" "Detection of a Denial of Service Attack" \
             "Misc Attack" "Detection of a non-standard protocol or event" "Decode of an RPC Query" \
             "Denial of Service" "Large Scale Information Leak" "Information Leak" \
             "A suspicious filename was detected" "An attempted login using a suspicious username was detected" \
             "A system call was detected" "A client was using an unusual port" \
             "Access to a potentially vulnerable web application" "Generic ICMP event" "Misc activity" \
             "Detection of a Network Scan" "Not Suspicious Traffic" "Generic Protocol Command Decode" \
             "A suspicious string was detected" "Unknown Traffic" "A TCP connection was detected")	
			 
etMsg=("GPL ACTIVEX WEB-CLIENT tsuserex.dll COM Object Instantiation Vulnerability" \
       "ET ACTIVEX EasyMail Quicksoft ActiveX Control Remote code excution clsid access attempt" \
       "ET ACTIVEX Black Ice Fax Voice SDK GetItemQueue Method Remote Code Execution Exploit" \
       "ET ATTACK_RESPONSE Metasploit Meterpreter File/Memory Interaction Detected" \
       "ET CNC Palevo Tracker Reported CnC Server TCP group 1" \
       "GPL CHAT Yahoo IM conference message" \
       "ET CURRENT_EVENTS Psyb0t Bot Nick" \
       "ET CURRENT_EVENTS Known Malicious Facebook Javascript" \
       "ET CURRENT_EVENTS Exploit Kit Exploiting IEPeers" \
       "ET CURRENT_EVENTS Runforestrun Malware Campaign Infected Website Landing Page Obfuscated String JavaScript DGA" \
       "ET CURRENT_EVENTS Possible Glazunov Java exploit request /9-10-/4-5-digit" \
       "ET CURRENT_EVENTS - CommentCrew Possible APT c2 communications sleep5" \
       "ET CURRENT_EVENTS Blackhole 16-hex/a.php Jar Download" \
       "ET CURRENT_EVENTS DRIVEBY Styx - TDS - Redirect To Landing Page" \
       "ET CURRENT_EVENTS SUSPICIOUS winhost" \
       "ET CURRENT_EVENTS Possible Upatre SSL Compromised site sabzevarsez.com" \
       "GPL DELETED MDaemon authentication overflow single packet attempt" \
       "ET DELETED SMTP Secret" \
       "ET DELETED Trojan.Downloader.Time2Pay.AQ" \
       "ET DELETED Downloader Checkin Pattern Used by Several Trojans" \
       "ET POLICY Suspicious inbound to MSSQL port" \
       "ET SCAN Potential VNC Scan" \
       "ET POLICY HTTP traffic on port 443" \
       "ET POLICY SUSPICIOUS *.doc.exe in HTTP URL" \
       "ET POLICY SUSPICIOUS *.pdf.exe in HTTP URL" \
       "ET DELETED User-Agent " \
       "ET DELETED Unknown Trojan Checkin 1" \
       "ET DELETED HTTP Request to a Zeus CnC DGA Domain opldkflyvlkywuec.ru" \
       "ET DELETED DNS Query to Zeus CnC DGA Domain opldkflyvlkywuec.ru Pseudo Random Domain" \
       "ET DELETED Win32/Kelihos.F Checkin 6" \
       "GPL DNS SPOOF query response with TTL of 1 min. and no authority" \
       "ET EXPLOIT Computer Associates Mobile Backup Service LGSERVER.EXE Stack Overflow" \
       "GPL EXPLOIT ISAKMP initial contact notification without SPI attempt" \
       "ET GAMES TrackMania Request GetConnectionAndGameParams" \
       "ET INFO JAVA - Java Class Download" \
       "ET INFO SUSPICIOUS SMTP EXE - RAR file with .com filename inside" \
       "ET MALWARE Searchmeup Spyware Install " \
       "ET MALWARE Trafficsector.com Spyware Install" \
       "ET MALWARE Winfixmaster.com Fake Anti-Spyware Install" \
       "ET MALWARE Possible Windows executable sent when remote host claims to send a Text File" \
       "ET MALWARE W32/InstallRex.Adware Initial CnC Beacon" \
       "ET MOBILE_MALWARE Android.Adware.Wapsx.A" \
       "GPL NETBIOS SMB InitiateSystemShutdown unicode little endian andx attempt" \
       "GPL NETBIOS SMB IrotIsRunning unicode attempt" \
       "ET P2P Libtorrent User-Agent" \
       "ET POLICY CCProxy in use remotely - Possibly Hostile/Malware" \
       "ET POLICY URL Contains passphrase Parameter" \
       "GPL POP3 POP3 PASS overflow attempt" \
       "ET SCAN Cisco Torch IOS HTTP Scan" \
       "GPL SCAN nmap fingerprint attempt" \
       "GPL SHELLCODE x86 0x90 unicode NOOP" \
       "GPL SQL dbms_repcat.comment_on_site_priority buffer overflow attempt" \
       "ET TOR Known Tor Exit Node UDP Traffic group 6" \
       "ET TOR Known Tor Exit Node UDP Traffic group 106" \
       "ET TOR Known Tor Relay/Router " \
       "ET TOR Known Tor Relay/Router " \
       "ET TOR Known Tor Relay/Router " \
       "ET TOR Known Tor Relay/Router " \
       "ET TOR Known Tor Relay/Router " \
       "ET TROJAN IRC Potential DDoS command 1" \
       "ET TROJAN User-agent DownloadNetFile Win32.small.hsh downloader" \
       "ET TROJAN Zalupko/Koceg/Mandaph manda.php Checkin" \
       "ET TROJAN Vundo Variant reporting to Controller via HTTP " \
       "ET TROJAN Syrutrk/Gibon/Bredolab Checkin" \
       "ET TROJAN Hiloti loader installed successfully response" \
       "ET TROJAN Spyeye Data Exfiltration 6" \
       "ET TROJAN Backdoor Win32.Idicaf/Atraps" \
       "ET TROJAN Mirage Campaign checkin" \
       "ET TROJAN Dorkbot Loader Payload Request" \
       "ET TROJAN Drive DDoS Tool byte command received key=okokokjjk" \
       "ET TROJAN Possible Mask C2 Traffic" \
       "ET TROJAN Citadel Checkin" \
       "ET TROJAN ABUSE.CH SSL Blacklist Malicious SSL certificate detected " \
       "ET WEB_CLIENT Foxit PDF Reader Title Stack Overflow" \
       "ET WEB_SERVER Possible INSERT INTO SQL Injection In Cookie" \
       "ET WEB_SERVER SQL Errors in HTTP 200 Response " \
       "GPL WEB_SERVER perl command attempt" \
       "ET WEB_SPECIFIC_APPS E-Annu SQL Injection Attempt -- home.php a ASCII" \
       "ET WEB_SPECIFIC_APPS ol bookmarks SQL Injection Attempt -- index.php id DELETE" \
       "ET WEB_SPECIFIC_APPS phpx SQL Injection Attempt -- users.php user_id DELETE" \
       "ET WEB_SPECIFIC_APPS Mambo SQL Injection Attempt -- moscomment.php mcname SELECT" \
       "ET WEB_SPECIFIC_APPS Kartli Alisveris Sistemi SQL Injection Attempt -- news.asp news_id INSERT" \
       "ET WEB_SPECIFIC_APPS XLAtunes SQL Injection Attempt -- view.php album INSERT" \
       "ET WEB_SPECIFIC_APPS Hunkaray Duyuru Scripti SQL Injection Attempt -- oku.asp id ASCII" \
       "ET WEB_SPECIFIC_APPS Easebay Resources Paypal Subscription Manager SQL Injection Attempt -- memberlist.php keyword DELETE" \
       "ET WEB_SPECIFIC_APPS Francisco Burzi PHP-Nuke SQL Injection Attempt -- index.php position DELETE" \
       "ET WEB_SPECIFIC_APPS Rialto SQL Injection Attempt -- listfull.asp ID UPDATE" \
       "ET WEB_SPECIFIC_APPS PHP-Update SQL Injection Attempt -- guestadd.php newmessage SELECT" \
       "ET WEB_SPECIFIC_APPS DMXReady Secure Login Manager SQL Injection Attempt -- login.asp sent INSERT" \
       "ET WEB_SPECIFIC_APPS VerliAdmin SQL Injection Attempt -- verify.php nick_mod ASCII" \
       "ET WEB_SPECIFIC_APPS Novell ZENworks Patch Management " \
       "ET WEB_SPECIFIC_APPS Expinion.net iNews SQL Injection Attempt -- articles.asp ex INSERT" \
       "ET WEB_SPECIFIC_APPS Enthrallweb eClassifieds SQL Injection Attempt -- dircat.asp cid ASCII" \
       "ET WEB_SPECIFIC_APPS ClickTech ClickContact SQL Injection Attempt -- default.asp In UNION SELECT" \
       "ET WEB_SPECIFIC_APPS ActiveNews Manager SQL Injection Attempt -- activenews_view.asp articleID INSERT" \
       "ET WEB_SPECIFIC_APPS ccTiddly include.php cct_base parameter Remote File Inclusion" \
       "ET WEB_SPECIFIC_APPS Hubscript PHPInfo Attempt" \
       "ET WEB_SPECIFIC_APPS SERWeb main_prepend.php functionsdir Parameter Remote File Inclusion" \
       "ET WEB_SPECIFIC_APPS phpBB3 Brute-Force reg attempt " \
       "ET WEB_SPECIFIC_APPS Possible JBoss JMX Console Beanshell Deployer WAR Upload and Deployment Exploit Attempt" \
       "ET WEB_SPECIFIC_APPS Woltlab Burning Board katid Parameter UPDATE SET SQL Injection Attempt" \
       "ET WEB_SPECIFIC_APPS TCExam tce_xml_user_results.php script UPDATE SET SQL Injection Attempt" \
       "ET WEB_SPECIFIC_APPS b2evolution skins_path Parameter Remote File inclusion Attempt" \
       "ET WEB_SPECIFIC_APPS WordPress Gallery Plugin filename_1 Parameter Remote File Access Attempt") 

for ((i=0; i<10000; i++))
do
  genIP=("192.168.$((RANDOM % 10)).$((1 + $((RANDOM % 254))))" "65.47.$((RANDOM % 254)).$((1 + $((RANDOM % 254))))" "39.$((RANDOM % 254)).$((RANDOM % 10)).$((1 + $((RANDOM % 254))))")
  srcIP="${genIP[$RANDOM % ${#genIP[@]}]}"
  
  thisHost="${hostName[$RANDOM % ${#hostName[@]}]}"

  # Get value to increment epoch
  incrementTime="${genTime[$RANDOM % ${#genTime[@]}]}"

  # Add epoch + value of incrementTime
  newTimeEpoch=$((incrementTime + getTime))

  # Take the new epoch value and put it in Apache log format
  newTime=$(date -d @"${newTimeEpoch}" "+%d/%b/%Y:%H:%M:%S")

  echo -e "${newTime} ${sensorIP} Alert:[$((1 + $((RANDOM))))] \"${etMsg[$RANDOM % ${#etMsg[@]}]}\" [IMPACT] from ${thisHost} at ${newTime} [Classification: ${snortAlerts[$RANDOM % ${#snortAlerts[@]}]}] [Priority: $((1 + $((RANDOM % 4))))] ${protType[$RANDOM % ${#protType[@]}]} ${srcIP} -> ${sensorIP}:$((1025 + $((RANDOM % 65535))))" >> /root/log-gen/snort.log

  let getTime="${newTimeEpoch}"
done
