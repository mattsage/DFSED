#!/bin/bash
#***********************************************
#Name:  unauthorisedserver.sh
#Purpose: Search for the "Identification String" in server logs to see if any unauthorised access has been attempted and output suspect IP addresses
#Author:  Matthew Sage
#Date Written:  04/02/10
#***********************************************

clear
echo "Are the log files in a zip archive e.g. '.tar.gz'  (y/n)"
read zip

if [ $zip = "y" ]; then #if logs are in a Zip Archive 
	echo "Please enter the location of the zip file (e.g. logs.tar.gz)"
	read location
	clear
	echo "The Zip archive include:"
	tar tzvf $location #show files in the Archive and gives investigator option to extract
	echo ""
	echo "would you like to extract files to Evidence folder (y/n)"
	read extract
	if [ $extract = "y" ]; then
		mkdir Evidence
		tar xzvf $location -C Evidence #extract the files
		echo "The message logs have been extracted to the evidence directory"
	else
		echo "The Program will now exit"
	exit
	fi
else 
	echo "Please enter the location of the server files (e.g. messages*)"
	read files
	cp $files Evidence #copy files to evidence Directory
fi
echo ""
echo "The Format of server log files are typically 'Date', 'time', 'hostname', 'generating application', message"
echo "e.g." `cat Evidence/messages | head -n 1` #show format of the message logs
echo ""

echo "Please enter a date of interest (e.g. Nov 4)"
read month day
echo "" >> Report.txt
echo "Log Entries for:" $month $day >>  Report.txt 
tac Evidence/messages* | grep "^$month[ ]*$day" >> Report.txt #grep for the date in the message logs and output them to screen & file 
tac Evidence/messages* | grep "^$month[ ]*$day"  

echo ""
echo "Would you like to search for 'Did not receive Identification string' (y/n)?"
read idsearch

if [ $idsearch = "y" ]; then #if investigator wants to search for did not receive Identification string
	echo ""  >> Report.txt
	echo  $caseno": Log entries from suspect /var/log/messages" >> Report.txt 
	echo ""  >> Report.txt
	echo "\"Did not receive identification string\":" >> Report.txt
	tac Evidence/messages* | grep "identification string" | awk '{print $1"\t"$2"\t"$3"\t"$NF}' >> Report.txt #search for entries and outputt to Report file
	echo ""  >> Report.txt

	echo "Unique IP adresses:" >> Report.txt
	tac Evidence/messages* | grep "identification string" | awk '{print $NF}' | sort -u >> Report.txt

	echo "All Suspect IP addresses have been outputted to Report.txt"
else
	echo "The program will now close"
exit
fi
