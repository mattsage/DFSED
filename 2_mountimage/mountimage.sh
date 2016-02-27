#!/bin/bash
#***********************************************
#Name:  mountimage.sh
#Purpose:  Mount/Unmount an image using the loopback device (Read Only)
#Author:  Matthew Sage
#Date Written:  23/01/10
#***********************************************

clear
echo " You have chosen 'mountimage.sh' "
echo " press [ctrl + c] to exit "
echo ""

echo "Would you like to Mount [1] or Unmount [2] a device? (1 or 2)"
read option

if [ $option = "1" ] #Mount Image
	then
	clear
	echo "You have chosen to mount an image"
	echo ""
	echo "Please enter path to image (e.g. /home/cccu/Documents/Evidence/001/Image.dd)"
	read path
	echo "Date Mounted" `date` > /root/Evidence/MountDetails.txt
	echo $path "was mounted (readonly) to: /mnt/analysis" >> /root/Evidence/MountDetails.txt
	mount -t vfat -o ro,noexec,loop $path /mnt/analysis #Mount image read-only to /mnt/analysis
	cd /mnt/analysis
	echo "" >>/root/Evidence/MountDetails.txt
	echo "File Listing:" >> /root/Evidence/MountDetails.txt
	find . -type f -exec file {} \; >> /root/Evidence/MountDetails.txt #Searches for all files on disk and outputs to report
	echo "" >> /root/Evidence/MountDetails.txt
	echo "******************************************" >> /root/Evidence/MountDetails.txt
	echo "md5 values of all files" >> /root/Evidence/MountDetails.txt
	echo "" >> /root/Evidence/MountDetails.txt
	find . -type f -exec md5sum {} \; >> /root/Evidence/MountDetails.txt #md5 hash values for files
	gedit /root/Evidence/MountDetails.txt
	echo "******************************************"
	echo "image has been mounted to /mnt/analysis"
	echo "A report on the mount details and file list has been produced in the evidence folder"
	echo "******************************************"
	exit

elif  [ $option = "2" ] #ummount image
	then
	echo "You have chosen to unmount an image"
	echo ""
	umount /mnt/analysis

	echo "******************************************"
	echo "image has been unmounted"
	echo "******************************************"
	exit

else
	exit
fi
