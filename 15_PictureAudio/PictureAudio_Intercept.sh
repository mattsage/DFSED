#								#PictureAudio_Intercept.sh
# Created by Matthew Sage
# Last modified: 05/10/09

#Intercepts Pictures and Audio and Save to a Selected Folder

driftnet -a -d [folder_location] -s -p -i [interface]

#-a = send pictures to a directory
#-d = where directory is
#-s = Audio
#-p = Do not  change interface into permiscuous mode
#-i = Select interface (e.g. eth0 or wlan0)