#								MAC_Spoof.sh
# Created by Matthew Sage
# Last modified: 01/10/09

clear

echo "******************************************"
ifconfig -a | grep HWaddr
echo "******************************************"
echo "What would you like to change?:"
echo "[1] Ethernet MAC"
echo "[2] Wlan MAC"
echo "[3] Both!"
echo ""
read choice

# Choice 1 : Ethernet 
if [ $choice = "1" ]
then
clear
echo "******************************************"
echo -e "\E[31mOriginal MAC"
ifconfig eth0 | grep HWaddr
echo -e "\E[37m"

ifconfig eth0 down
ifconfig eth0 hw ether 00:11:22:33:44:5a
ifconfig eth0 up
echo "Spoofed MAC"
ifconfig eth0 | grep HWaddr
echo "******************************************"

# Choice 2 : Wlan 
elif [ $choice = "2" ]
then
clear
echo "******************************************"
echo -e "\E[31mOriginal MAC"
ifconfig wlan0 | grep HWaddr
echo -e "\E[37m"

ifconfig wlan0 down
ifconfig wlan0 hw ether 00:11:22:33:44:55
ifconfig wlan0 up
echo "Spoofed MAC"
ifconfig wlan0 | grep HWaddr
echo "******************************************"

# Choice 3 : Ethernet & Wlan
elif [ $choice = "3" ]
then
clear
echo "******************************************"
ifconfig eth0 down
ifconfig eth0 hw ether 00:11:22:33:44:5a
ifconfig eth0 up

ifconfig wlan0 down
ifconfig wlan0 hw ether 00:11:22:33:44:55
ifconfig wlan0 up

ifconfig -a | grep HWaddr
echo "******************************************"

# Other Options
else
echo "Invalid option"
exit

fi