#!/bin/bash
#***********************************************
#Name:  unauthorisedserver.sh
#Purpose: Search for the "Identification String" in server logs to see if any unauthorised access has been attempted and output suspect IP addresses
#Author:  Matthew Sage
#Date Written:  04/02/10
#***********************************************

clear
echo " You have chosen 'server.sh' "
echo " press [ctrl + c] to exit "
echo ""

#Case Details
echo `date` > /root/Evidence/Report.txt
echo "Investigator's name:"
read iname
echo "Investigator:" $iname > /root/Evidence/Report.txt
echo "Case Number:"
read caseno
mkdir $caseno
mv $caseno /root/Evidence
echo "Case Number:" $caseno >> /root/Evidence/Report.txt
echo "Case Description:"
read casedes
echo "Case Description:" $casedes >> /root/Evidence/Report.txt
mv /root/Evidence/Report.txt /root/Evidence/$caseno
scrot "/root/Evidence/$caseno/01_(`date +%d-%m-%Y_%H:%M:%S`).png"

clear
echo "Are the log files in a zip archive e.g. '.tar.gz'  (y/n)"
read zip

if [ $zip = "y" ]; then #if logs are in a Zip Archive 
	echo "Please enter the location of the zip file (e.g. /home/cccu/Documents/Grundy/logs.tar.gz)"
	read location
	scrot "/root/Evidence/$caseno/02_(`date +%d-%m-%Y_%H:%M:%S`).png" #Screen Shot
	clear
	echo "The Zip archive include:"
	tar tzvf $location #show files in the Archive and gives investigator option to extract
	echo ""
	echo "would you like to extract files to Evidence folder (y/n)"
	read extract
	if [ $extract = "y" ]; then
		tar xzvf $location -C /root/Evidence/$caseno/ #extract the files
		scrot "/root/Evidence/$caseno/03_(`date +%d-%m-%Y_%H:%M:%S`).png" #screen shot
	else
		echo "The Program will now exit"
	exit
	fi
else 
	echo "Please enter the location of the server files (e.g. /home/cccu/Documents/Grundy/logs.tar.gz)"
	read files
	cp $files /root/Evidence/$caseno #copy files to evidence Directory
fi
echo ""
echo "The Format of server log files are typically 'Date', 'time', 'hostname', 'generating application', message"
echo "e.g." `cat /root/Evidence/$caseno/messages | head -n 1` #show format of the message logs
echo ""

echo "Please enter a date of interest (e.g. Nov 4)"
read month day
echo "" >> /root/Evidence/$caseno/Report.txt
echo "Log Entries for:" $month $day >>  /root/Evidence/$caseno/Report.txt 
tac /root/Evidence/$caseno/messages* | grep "^$month[ ]*$day" >>  /root/Evidence/$caseno/Report.txt #grep for the date in the message logs and output them to screen & file 
tac /root/Evidence/$caseno/messages* | grep "^$month[ ]*$day"  

echo ""
echo "Would you like to search for 'Did not receive Identification string' (y/n)?"
read idsearch
scrot "/root/Evidence/$caseno/04_(`date +%d-%m-%Y_%H:%M:%S`).png"

if [ $idsearch = "y" ]; then #if investigator wants to search for did not receive Identification string
	echo ""  >> /root/Evidence/$caseno/Report.txt
	echo  $caseno": Log entries from suspect /var/log/messages" >> /root/Evidence/$caseno/Report.txt 
	echo ""  >> /root/Evidence/$caseno/Report.txt
	echo "\"Did not receive identification string\":" >> /root/Evidence/$caseno/Report.txt
	tac /root/Evidence/$caseno/messages* | grep "identification string" | awk '{print $1"\t"$2"\t"$3"\t"$NF}' >> /root/Evidence/$caseno/Report.txt #search for entries and outputt to Report file
	echo ""  >> /root/Evidence/$caseno/Report.txt

	echo "Unique IP adresses:" >> /root/Evidence/$caseno/Report.txt
	tac /root/Evidence/$caseno/messages* | grep "identification string" | awk '{print $NF}' | sort -u >> /root/Evidence/$caseno/Report.txt

	echo "All Suspect IP addresses have been outputted to Report.txt"
	scrot "/root/Evidence/$caseno/05_(`date +%d-%m-%Y_%H:%M:%S`).png"
else
	echo "The program will now close"
exit
fi
