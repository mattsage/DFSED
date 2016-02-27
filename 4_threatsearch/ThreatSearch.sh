
#!/bin/bash
# ***********************************************
# Name:  Treat.sh
# Purpose:  Search for a threatening document from an image
# Author:  Matthew Sage
# Date Written:  14/01/10
# ***********************************************

clear
echo " You have chosen 'Search for a Threatening Document' "
echo " press [ctrl + c] to exit "
echo ""

#case information
echo `date` > /root/Evidence/Report.txt
echo "Investigator's name:"
read iname
echo "Investigator:" $iname >> /root/Evidence/Report.txt
echo "Case Number:"
read caseno
mkdir $caseno
mv $caseno /root/Evidence
echo "Case Number:" $caseno >> /root/Evidence/Report.txt
echo "Case Description:"
read casedes
echo "Case Description:" $casedes >> /root/Evidence/Report.txt
scrot "/root/Evidence/$caseno/01_(`date +%d-%m-%Y_%H:%M:%S`).png"

echo "#######################################################" >> /root/Evidence/Report.txt
echo "" >> /root/Evidence/Report.txt

clear

echo "Please enter the location of the image (e.g. /home/cccu/Documents/Grundy/practical.floppy.dd)"
read image
echo "File Image:" $image >> /root/Evidence/Report.txt

echo -e "Please enter a keyword to search for: \E[31m(NOTE: Case Sensitive!)\E[37m"
read text #read text to Search for
echo "Keyword searched for:" $text >> /root/Evidence/Report.txt
scrot "/root/Evidence/$caseno/02_(`date +%d-%m-%Y_%H:%M:%S`).png"

cluster=`strings -td $image | grep $text | awk '{print $1}'` #Work out cluster

echo "Cluster:" $cluster >> /root/Evidence/Report.txt

sector=$(echo $cluster/512 | bc) #work out Sector

echo "Sector:" $sector >> /root/Evidence/Report.txt

inode=`ifind $image -d $sector` #calculate Inode

echo "Inode Number:" $inode >> /root/Evidence/Report.txt

#icat -r $image $inode > Threattext.txt

mv /root/Evidence/Report.txt /root/Evidence/$caseno

icat -r $image $inode > /root/Evidence/Threat_Text.txt #cut out file using icat command and inode number

mv /root/Evidence/Threat_Text.txt /root/Evidence/$caseno

echo "#######################################################"
echo "Your file has been successfully recovered"
echo "The file and a report has been outputted to /root/Evidence"/$caseno
echo "#######################################################"

