#!/bin/bash
# ***********************************************
# Name:  recfiletype.sh
# Purpose:  Search and recover deleted files by file type
# Author:  Matthew Sage
# Date Written:  20/11/09
# ***********************************************

clear
echo " You have chosen 'Recfiletype.sh' "
echo " press [ctrl + c] to exit "
echo ""

echo "Please Insert evidence disk now and press enter"
read "disk"

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

clear
fdisk -l #Lists all drives attached to computer
echo "Please enter the drive you want to search: (e.g /dev/sda1)"
read device


filesys=`fdisk -l | grep $device | awk '{ print $6 }' | tr  A-Z a-z` #variable to store file system on device


echo "Please enter file type you want to  search for (e.g. .jpg .png .docx) OR (".all") for all deleted files:"
read filetype
scrot "/root/Evidence/$caseno/02_(`date +%d-%m-%Y_%H:%M:%S`).png"
clear

echo "########################################################" >> /root/Evidence/Report.txt
echo "Deleted" $filetype "files on" $device >> /root/Evidence/Report.txt
echo "########################################################" >> /root/Evidence/Report.txt

if [ $filetype = ".all" ] #Search for all deleted files
	then
	fls -d $device #List all deleted files
	fls -d $device >>/root/Evidence/Report.txt
else
	fls -d $device | grep $filetype #search for file extension type
 	fls -d $device | grep $filetype >>/root/Evidence/Report.txt
fi

echo "Please enter the inode of the file you would like to recover: (e.g 24)"
read fileinode

echo "#######################################################" >>/root/Evidence/Report.txt
echo "The file recovered was Inode" $fileinode >> /root/Evidence/Report.txt

echo "What would you like to call the file(???"$filetype")"
read filename
scrot "/root/Evidence/$caseno/03_(`date +%d-%m-%Y_%H:%M:%S`).png"

icat -r -f $filesys $device $fileinode > $filename #Recover file at specified inode
echo >> /root/Evidence/Report.txt
echo "The sha1 sum is" >>/root/Evidence/Report.txt
sha1sum $filename >> /root/Evidence/Report.txt #sha1sum of outputted file
echo >>/root/Evidence/Report.txt
echo "The md5sum  is" >>/root/Evidence/Report.txt #md5sum of outputted file
md5sum $filename >> /root/Evidence/Report.txt
echo "#######################################################" >>/root/Evidence/Report.txt

mv $filename /root/Evidence/$caseno
mv /root/Evidence/Report.txt /root/Evidence/$caseno


clear
echo "#######################################################"
echo "Your file has been successfully recovered"
echo "The file and a report has been outputted to /root/Evidence"/$caseno
echo "#######################################################"

