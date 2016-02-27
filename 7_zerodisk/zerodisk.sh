#!/bin/bash
#***********************************************
#Name:  zerodisk.sh
#Purpose:  "Zero" a disk, and remove all contraband
#Author:  Matthew Sage
#Date Written:  01/23/10
#***********************************************

clear
echo " You have chosen 'zerodisk.sh' "
echo " press [ctrl + c] to exit "
echo ""

echo -e "\E[31m******************************************************************************"
echo "WARNING: THIS SCRIPT WILL REMOVE ALL DATA ON A DISK WHICH CANNOT BE RECOVERED!"
echo "******************************************************************************"
echo -e "\E[37m"

echo "Would you like to continue? (y/n)"
read choice

if [ $choice = "y" ] #if user wants to "zero disk
	then
	clear
	fdisk -l
	echo ""
	echo "PLEASE NOTE: This script may take a while to complete"
	echo "Please select device you wish to 'Zero'"
	read path
	echo "How many passes would you like to make? (Recommened  at least 3 passes)"
	read pass
	count=0
		while [ $pass -gt $count  ]; do
		clear
		echo "Please wait.... (Writing 'Zeros')"
		dd if=/dev/zero of=$path bs=512 #write zeros
		echo ""
		echo "Pass" $count "Complete"
		let count=count+1
	done
	echo "Varifing all data has been removed"
	xxd -a $path #hexdump of device to make sure all data has been removed
	echo ""
	echo "*******************************************"
	echo "Sucessful! All data has now been removed"
	echo "*******************************************"

	exit

else #else exit program
	exit
fi

