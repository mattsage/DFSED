#!/bin/bash
#***********************************************
#Name: skel.sh
#Purpose:  Creates a skeleton script
#Author:  Matthew Sage
#Date Written:  30/12/09
#***********************************************

clear
echo " You have chosen 'Create Skeleton Script' "
echo " press [ctrl + c] to exit "
echo ""

echo "Please enter file name"
read file_name

echo "Please enter script purpose"
read purpose

echo "Please enter author's name"
read name

echo "Please enter location to save file (e.g. /root/Forensic)"
read location

cd $location

echo "#!/bin/bash" > $file_name
echo "#***********************************************" >> $file_name
echo "#Name: " $file_name >>$file_name
echo "#Purpose: " $purpose >> $file_name
echo "#Author: " $name >> $file_name
echo "#Date Written: " `date +%D` >> $file_name
echo "#***********************************************" >> $file_name

chmod 777 $file_name

echo "****************************************************************************"
echo "Script sucessfully created and saved at" $location
echo "****************************************************************************"

