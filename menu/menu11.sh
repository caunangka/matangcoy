#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
echo "Checking VPS"
#########################

# Color Validation
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
yl='\e[32;1m'
bl='\e[36;1m'
gl='\e[32;1m'
rd='\e[31;1m'
mg='\e[0;95m'
blu='\e[34m'
op='\e[35m'
or='\033[1;33m'
bd='\e[1m'
color1='\e[031;1m'
color2='\e[34;1m'
color3='\e[0m'
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
LIGHT='\033[0;37m'
# VPS Information
#Domain
domain=$(cat /etc/xray/domain)
#Status certificate
modifyTime=$(stat $HOME/.acme.sh/${domain}_ecc/${domain}.key | sed -n '7,6p' | awk '{print $2" "$3" "$4" "$5}')
modifyTime1=$(date +%s -d "${modifyTime}")
currentTime=$(date +%s)
stampDiff=$(expr ${currentTime} - ${modifyTime1})
days=$(expr ${stampDiff} / 86400)
remainingDays=$(expr 90 - ${days})
tlsStatus=${remainingDays}
if [[ ${remainingDays} -le 0 ]]; then
	tlsStatus="expired"
fi
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
#Download/Upload today
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')"
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )
clear 
echo -e " "
echo -e " "
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[0;100;33m        • DOA IBU Premium Script •           \e[0m"
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m Operating System     \e[0m:  "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`	
echo -e "\e[33m Total Amount Of RAM  \e[0m:  $tram MB"
echo -e "\e[33m Time Zone            \e[0m:  $WKT"
echo -e "\e[33m System Uptime        \e[0m:  $uptime "
echo -e "\e[33m Isp Name             \e[0m:  $ISP"
echo -e "\e[33m Domain               \e[0m:  $domain"	
echo -e "\e[33m Ip Vps               \e[0m:  $IPVPS"
echo -e "${CYAN}════════════════════════════════════════════════════════════\033[0m${NC}"
echo -e "\E[44;1;39m              ⇱ SCRIPT MENU ⇲                           \E[0m"
echo -e "${CYAN}════════════════════════════════════════════════════════════\033[0m${NC}"
echo -e " [\e[36m•1\e[0m] SSH & OpenVPN Menu  "
echo -e " [\e[36m•2\e[0m] Vmess Menu          "
echo -e " [\e[36m•3\e[0m] Vless Menu          "
echo -e " [\e[36m•4\e[0m] Trojan-WS Menu      "
echo -e " [\e[36m•5\e[0m] SSH UDP Menu        "
echo -e " [\e[36m•6\e[0m] Trojan-GO Menu      "
echo -e "${CYAN}════════════════════════════════════════════════════════════\033[0m${NC}"
echo -e "${CYAN}════════════════════════════════════════════════════════════\033[0m${NC}"
echo -e "$PURPLE (7) $NC GANTI DOMAIN         $PURPLE (15) $NC CEK BANDWITH "
echo -e "$PURPLE (8) $NC RENEW CERTIFICATE    $PURPLE (16) $NC Clear RAM Cache "
echo -e "$PURPLE (9) $NC CHANGE PORT          $PURPLE (17) $NC REBOOT VPS "
echo -e "$PURPLE (10) $NC CHANGE BANNER       $PURPLE (18) $NC SPEEDTEST VPS "
echo -e "$PURPLE (11) $NC BACKUP DATA VPS     $PURPLE (19) $NC Install UDP-Custom "
echo -e "$PURPLE (12) $NC RESTORE DATA VPS    $PURPLE (20) $NC SET AUTO REBOT "
echo -e "$PURPLE (13) $NC WEBMIN MENU         $PURPLE (21) $NC RESTARTS "
echo -e "$PURPLE (14) $NC RUNNING SYSTEM      $PURPLE (22) $NC INFO SCRIPT "
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[0;100;33m        • AutoScript by DOA IBU •            \e[0m"
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e   " Press x or [ Ctrl+C ] • To-Exit-Script"
echo -e   ""
echo -e   ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; menu-vmess ;;
3) clear ; menu-vless ;;
4) clear ; menu-trojan ;;
5) clear ; udp ;;
6) clear ; menu-trgo ;;
7) clear ; add-host ;;
8) clear ; certv2ray ;;
9) clear ; port-change ;;
10) clear ; nano /etc/issue.net ;;
11) clear ; backup ;;
12) clear ; restore ;;
13) clear ; menu-webmin ;;
14) clear ; running ;;
15) clear ; bw ;;
16) clear ; clearcache ;;
17) clear ; reboot ;;
18) clear ; speedtest ;;
19) clear ; menus ;;
20) clear ; auto-reboot ;;
21) clear ; restart ;;
22) clear ; about ;;
x) exit ;;
esac
