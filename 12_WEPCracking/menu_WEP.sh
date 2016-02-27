#!/bin/bash

clear
echo " You have chosen 'WEP Cracking' "
echo " press [ctrl + c] to exit "
echo ""

echo "[0] Clientless"
echo "[1] Client Conected"
echo ""
echo "Please select wireless status:"
read scriptchoice

if [ $scriptchoice = "0" ] #Option 0: Clientless
        then
        ./WEP_Clientless.sh

elif [ $scriptchoice = "1" ] #Option 0: Client Connected
        then
        ./WEP_Crack.sh

else #Invalid Choice
        echo -e  "INVALID CHOICE: Please try again"
        exit
fi
