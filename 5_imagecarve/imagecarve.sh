#!/bin/bash
#***********************************************
#Name:  imagecarve.sh
#Purpose:  Carves a .jpg image from slack space
#Author:  Matthew Sage
#Date Written:  15/01/10
#***********************************************
clear
echo " You have chosen 'Carve a file from raw data (slack space)' "
echo " press [ctrl + c] to exit "
echo ""

#case details
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

echo "Please enter the location of the raw data (e.g. /home/cccu/Documents/Grundy/image_carve.raw)"
read image
echo "Raw File:" $image >> /root/Evidence/Report.txt
xxd $image #hexdump of image

echo ""
echo "Please enter a file type to search for (e.g. .JPG)"
read filetype
echo ""
scrot "/root/Evidence/$caseno/02_(`date +%d-%m-%Y_%H:%M:%S`).png"
xxd $image | grep ffd8 #grep for ffd8 (jpg header) in the image

stoffset=`xxd $image | grep ffd8 | awk -F: '{print $1}' | tr a-f A-F` #locate offset of the .jpg image

decoffset=$(echo "ibase=16;"$stoffset | bc) #workout decimal offset
echo ""
echo "Please enter number of bytes the file is in"
read bytes

location=`echo $decoffset "+" $bytes | bc` #calculate location of image
echo "File offset start:" $location
scrot "/root/Evidence/$caseno/03_(`date +%d-%m-%Y_%H:%M:%S`).png"


echo "***************************************************"

xxd -s $location $image | grep ffd9 #find end offset using ffd9 (.jpg footer)
endoffset=`xxd -s $location $image | grep ffd9 | awk -F: '{print $1}' | tr a-f A-F`

decoffset2=$(echo "ibase=16;"$endoffset | bc)
echo ""
echo "Please enter number of bytes the file is in"
read bytes2
scrot "/root/Evidence/$caseno/04_(`date +%d-%m-%Y_%H:%M:%S`).png"


endlocation=`echo $decoffset2 "+" $bytes2 | bc`
echo "File Offset end:" $endlocation

filesize=`echo $endlocation "-" $location | bc` #Workout filesize 
echo $filesize

echo "***************************************************"
echo "Please enter a file name (e.g. carv.jpg)"
read name
scrot "/root/Evidence/$caseno/05_(`date +%d-%m-%Y_%H:%M:%S`).png"


dd if=$image of=$name skip=$location bs=1 count=$filesize #carve image file using the location and file size and output to a file

#fill in Report with file details such as file name, offsets and hash sums
echo "File recovered:" $name >>/root/Evidence/Report.txt
echo "Start offset:" $location >>/root/Evidence/Report.txt
echo "End offset:" $endlocation >>/root/Evidence/Report.txt
echo "File size (bytes):" $filesize >>/root/Evidence/Report.txt
echo "" >>/root/Evidence/Report.txt
echo "The sha1 sum is" >>/root/Evidence/Report.txt
sha1sum $name >> /root/Evidence/Report.txt #sha1sum of outputted file
echo "The md5sum  is" >>/root/Evidence/Report.txt #md5sum of outputted file
md5sum $name >> /root/Evidence/Report.txt

mv $name /root/Evidence/$caseno
mv /root/Evidence/Report.txt /root/Evidence/$caseno

firefox /root/Evidence/$caseno/$name
scrot "/root/Evidence/$caseno/06_(`date +%d-%m-%Y_%H:%M:%S`).png"

clear
echo "#######################################################"
echo "Your file has been successfully recovered"
echo "The file and a report has been outputted to /root/Evidence"/$caseno
echo "#######################################################"
