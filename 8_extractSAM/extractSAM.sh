#!/bin/bash
#***********************************************
#Name: extract_SAM.sh
#Purpose: Extract and copy SAM, SYSTEM and SECURITY files from a dead Windows machine
#Author:  Matthew Sage
#Date Written:  24/05/10
#***********************************************

clear
fdisk -l
echo ""
echo "Please Select Device:"
read device

mount $device /mnt/analysis

cp /mnt/analysis/Windows/System32/config/SAM /root/Evidence
cp /mnt/analysis/Windows/System32/config/SECURITY /root/Evidence
cp /mnt/analysis/Windows/System32/config/SYSTEM /root/Evidence

umount /mnt/analysis

echo "*******************************************************************************"
echo "SAM, SYSTEM and SECURITY files have been successfully copied to Evidence Folder"
echo "*******************************************************************************"
