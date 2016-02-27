#! /bin/bash
ifconfig wlan0
iwconfig wlan0 essid [NETWORK_ID] key s:[WIRELESS_KEY]
dhclient wlan0