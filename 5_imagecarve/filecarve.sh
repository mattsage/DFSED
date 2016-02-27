#!/bin/bash
#***********************************************
#Name:  imagecarve.sh
#Purpose:  Carves a file from slack space
#Author:  Matthew Sage
#Date Written:  30/04/10
#***********************************************
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


echo "Please enter the location of the raw data (e.g. image_carve.raw)"
read image
echo "Raw File:" $image > Report.txt
scrot "/root/Evidence/$caseno/02_(`date +%d-%m-%Y_%H:%M:%S`).png"
xxd $image #hexdump of image

echo ""
echo "Please enter a file type to search for:"
echo -e "\E[31mNOTE: Enter in lowercase without the fullstop (e.g jpg)\E[37m"

read filetype
echo ""
scrot "/root/Evidence/$caseno/02_(`date +%d-%m-%Y_%H:%M:%S`).png"

header=`grep $filetype <file_signatures.csv | cut -d \, -f 2` #search file_signatures.csv for header
footer=`grep $filetype <file_signatures.csv | cut -d \, -f 3` #search file_signatures.csv for footer

xxd $image | grep $header #grep for  header in the image

stoffset=`xxd $image | grep $header | awk -F: '{print $1}' | tr a-f A-F` #locate offset of the file header

decoffset=$(echo "ibase=16;"$stoffset | bc) #workout decimal offset
echo ""
echo "Please enter number of bytes the file is in"
read bytes

location=`echo $decoffset "+" $bytes | bc` #calculate location of image
echo "File offset start:" $location


echo "***************************************************"

xxd -s $location $image | grep $footer #find end offset using file footer
endoffset=`xxd -s $location $image | grep $footer | awk -F: '{print $1}' | tr a-f A-F`

decoffset2=$(echo "ibase=16;"$endoffset | bc)
echo ""
echo "Please enter number of bytes the file is in"
read bytes2

endlocation=`echo $decoffset2 "+" $bytes2 | bc`
echo "File Offset end:" $endlocation

filesize=`echo $endlocation "-" $location | bc` #Workout filesize 
echo $filesize

echo "***************************************************"
echo "Please enter a file name (e.g. carv."$filetype")"
read name
scrot "/root/Evidence/$caseno/03_(`date +%d-%m-%Y_%H:%M:%S`).png"


dd if=$image of=$name skip=$location bs=1 count=$filesize #carve image file using the location and file size and output to a file

#fill in Report with file details such as file name, offsets and hash sums
echo "File recovered:" $name >> Report.txt
echo "Start offset:" $location >> Report.txt
echo "End offset:" $endlocation >> Report.txt
echo "File size (bytes):" $filesize >> Report.txt
echo "" >> Report.txt
echo "The sha1 sum is" >> Report.txt
sha1sum $name >> Report.txt #sha1sum of outputted file
echo "The md5sum  is" >> Report.txt #md5sum of outputted file
md5sum $name >> Report.txt

clear
echo "#######################################################"
echo "Your file has been successfully recovered"
echo "A Report has been created on all actions"
echo "#######################################################"
