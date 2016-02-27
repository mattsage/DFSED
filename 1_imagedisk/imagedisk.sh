#!/bin/bash
#***********************************************
#Name: imagedisk.sh
#Purpose:  Creates and verifies a bit for bit (dd) copy of a Disk, also outputs a list of all files (deleted and present) to a Report
#Author:  Matthew Sage
#Date Written:  30/12/09
#***********************************************

clear
echo " You have chosen 'imagedisk.sh' "
echo " press [ctrl + c] to exit "
echo ""

echo "Please Insert evidence disk now and press enter" 
read "disk"

#Case Details
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
mv /root/Evidence/Report.txt /root/Evidence/$caseno
scrot "/root/Evidence/$caseno/01_(`date +%d-%m-%Y_%H:%M:%S`).png" #Screenshot 1

clear
fdisk -l 	#Lists all Devices connected to Computer
echo "Please select a drive to image:"
read drive
echo "What would you like to call the outputted file? e.g." $caseno".disk1.dd"
read ofile
scrot "/root/Evidence/$caseno/02_(`date +%d-%m-%Y_%H:%M:%S`).png"
clear

echo "A md5sum is being taken of" $drive "please wait..."
md51=`md5sum $drive | awk '{print $1}'`				#md5 hash sum of the original drive
echo "Original Drive Hash:" $md51 >> /root/Evidence/$caseno/Report.txt
clear
echo "md5sum was successful"

echo "The drive is now being imaged"
echo "Please Wait..."
dd if=$drive of=$ofile bs=512 		#Image drive
mv $ofile /root/Evidence/$caseno 
chmod 444 /root/Evidence/$caseno/$ofile

clear
echo "A md5sum of the image file is now being taken"
echo "Please wait..."
md52=`md5sum /root/Evidence/$caseno/$ofile | awk '{print $1}'` #md5 Hash sum of the image taken
echo "Image Hash:" $md52 >> /root/Evidence/$caseno/Report.txt

if [ $md51 = $md52 ]; then #If statement to check if both Hash values are the same
	echo "Hashes Match: Image Successful - You may now remove the original drive"
	echo "Image hash [OK]"  >> /root/Evidence/$caseno/Report.txt
else
	echo "ERROR:Please image drive again"
	echo "Image hash [FAILED]"  >> /root/Evidence/$caseno/Report.txt
	exit
fi

echo "##################################" >> /root/Evidence/$caseno/Report.txt
echo "All Files on Disk"  >> /root/Evidence/$caseno/Report.txt
echo "__________________________________"  >> /root/Evidence/$caseno/Report.txt
fls -a -r $drive  >> /root/Evidence/$caseno/Report.txt #list all files
echo ""  >> /root/Evidence/$caseno/Report.txt
echo "##################################"  >> /root/Evidence/$caseno/Report.txt
echo "All Deleted files on Disk"  >> /root/Evidence/$caseno/Report.txt
echo "__________________________________"  >> /root/Evidence/$caseno/Report.txt
fls -d -l -r $drive | awk -F: '{print $1 $2 $3 $4 $5}'  >> /root/Evidence/$caseno/Report.txt #list all deleted files on disk
echo "##################################"  >> /root/Evidence/$caseno/Report.txt

echo "Would you like to split the file (y/n)?"
read split

if [ $split = "y" ]; then
	mkdir /root/Evidence/$caseno/imagesplit
	echo "enter size of blocks for the spilt images (e.g. 360k)"
	read block
	dd if=/root/Evidence/$caseno/$ofile | split -b $block - /root/Evidence/$caseno/imagesplit/$ofile.split. #Split command to spilt the file
else
echo ""
fi

echo "Would you like to mount the image for examination (y/n)?"
read mount
if [ $mount = "y" ]; then
	mount -o ro,noexec,loop /root/Evidence/$caseno/$ofile /mnt/analysis #Mount image in a 'read-only' environment
	echo "The image has been mounted at /mnt/analysis"
else
exit
fi
