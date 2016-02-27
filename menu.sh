#!/bin/bash
#***********************************************
#Name: menu.sh
#Purpose:  Allows a choice of script
#Author:  Matthew Sage
#Date Written:  30/12/09
#***********************************************
clear
echo -e "\E[33m"
echo "------------------------------------------------------------------------------"
echo "|                                                                            |"
echo "|  *******          ********       ********        ********        *******   |"
echo "| /**////**        /**/////       **//////        /**/////        /**////**  |"
echo "| /**    /**       /**           /**              /**             /**    /** |"
echo "| /**    /**       /*******      /*********       /*******        /**    /** |"
echo "| /**    /**       /**////       ////////**       /**////         /**    /** |"
echo "| /**    **    **  /**       **         /**   **  /**         **  /**    **  |"
echo "| /*******    /**  /**      /**   ********   /**  /********  /**  /*******   |"
echo "| ///////     //   //       //   ////////    //   ////////   //   ///////    |"
echo "|                                                                            |"
echo "------------------------------------------------------------------------------"
echo -e "\E[37m"

echo -e "Welcome to D.F.S.E.D a collection of customised scripts which will automate Forensic tasks - Created By Matthew Sage (2009-1010)"
echo -e "\E[31mIMPORTANT: DO NOT INSERT ANY EVIDENCE DISK'S UNTIL INSTRUCTED TO DO SO"
echo -e "\E[37m"

echo "[0]  skel.sh          	       - Create a Skeleton file for custom scripts" 
echo "[1]  imagedisk.sh     	       - Create a 'dd'(Raw) image of a selected device, gives a file listing and allows the option to split image file"
echo "[2]  mountimage.sh    	       - Mount/Unmount an image created by option 2 using the loopback device (Read Only)"
echo "[3]  recfiletype.sh   	       - Search and recover deleted files from a device by file type"
echo "[4]  threatsearch.sh  	       - Search and recover a threatening document using a keyword" 
echo "[5]  filecarve.sh     	       - Carve an file from raw data (slack space)"
echo "[6]  unauthorisedserver.sh     - Search server logs for any suspicious activity and log IP addresses"
echo "[7]  zerodisk.sh      	       - 'Zero' a disk to remove all contraband"
echo "[8]  extractSAM.sh             - Extract and copy SAM, SYSTEM and SECURITY files from a dead Windows machine"
echo "[9]  MAC_Spoof.sh              - Spoof computers MAC address"
echo "[10] Con_2_Wireless.sh         - Connect to a wireless network with a key"
echo "[11] Bypass_Hotspots_Access_Controls.sh - Connect to hotspots with out key knowledge"
echo "[12] WEP_Crack                 - Crack a WEP network key (client connected & Clientless)"
echo "[13] WPA_Crack                 - Crack a WPA Network key (client connected only)"
echo "[14] ARP_Poisoning.sh          - Attack an ethernet (wired or wireless) and modify or stop traffic"
echo "[15] PictureAudio_Intercept.sh - Intercept pictures and audio"
echo "[16] URL_intercept             - Intercept Website URL's"
echo "[17] DOS.sh                    - Knock off and prevent users from accessing a wireless network"
echo "[18] raw2vmdk.sh              - Convert 'dd' to a virtual machine image (.vmdk)"
echo ""


echo "Please type script number that you would like to run (e.g. 1)"
read scriptchoice

if [ $scriptchoice = "0" ] #Option 0: Skeleton Script
	then
	cd 0_skel
	./skel.sh

elif [ $scriptchoice = "1" ] #Option 1: ImageDisk.sh
	then
	cd 1_imagedisk
	./imagedisk.sh

elif  [ $scriptchoice = "2" ] #Option 2: Mountimage.sh
	then
	cd 2_mountimage
	./mountimage.sh

elif  [ $scriptchoice = "3" ]	#Option 3: Recfiletype.sh
	then
	cd 3_recfiletype
	./recfiletype.sh

elif [ $scriptchoice = "4" ] #Option 4: ThreatSearch.sh
	then
	cd 4_threatsearch
	./ThreatSearch.sh

elif [ $scriptchoice = "5" ] #Option 5: imagecarve.sh
	then
	cd 5_imagecarve
	./filecarve.sh

elif [ $scriptchoice = "6" ] #Option 6: unauthorisedserver.sh
	then
	cd 6_serveraccess
	./unauthorisedserver.sh

elif [ $scriptchoice = "7" ] #Option 7: zerodisk.sh
	then
	cd 7_zerodisk
	./zerodisk.sh

elif [ $scriptchoice = "8" ] #Option 8: extract_SAM.sh
        then
        cd 8_extractSAM
        ./extractSAM.sh

elif [ $scriptchoice = "9" ] #Option 9: MACSpoof.sh
        then
        cd 9_MACSpoof
        ./MAC_Spoof.sh

elif [ $scriptchoice = "10" ] #Option 10: Con_2_Wireless.sh
        then
        cd 10_Con2Wireless
        ./Con_2_Wireless.sh

elif [ $scriptchoice = "11" ] #Option 11: Bypass_Hotspots_Access_Controls.sh
        then
        cd 11_BypassHotpotSecurity
        ./Bypass_Hotspots_Access_Controls.sh

elif [ $scriptchoice = "12" ] #Option 12: menu_WEP.sh
        then
        cd 12_WEPCracking
        ./menu_WEP.sh

elif [ $scriptchoice = "13" ] #Option 13: WPA_Crack.sh
        then
        cd 13_WPACracking
        ./WPA_Crack.sh

elif [ $scriptchoice = "14" ] #Option 14: ARP_Poisoning.sh
        then
        cd 14_ARPPoisoning
        ./ARP_Poisoning.sh

elif [ $scriptchoice = "15" ] #Option 15: PictureAudio_Intercept.sh
        then
        cd 15_PictureAudio
        ./PictureAudio_Intercept.sh

elif [ $scriptchoice = "16" ] #Option 16: URL_intercept.sh
        then
        cd 16_URL_intercept
        ./URL_intercept.sh

elif [ $scriptchoice = "17" ] #Option 17: DOS.sh
        then
        cd 17_DOS
        ./DOS.sh 

elif [ $scriptchoice = "18" ] #Option 18: raw2vmdk.sh
        then
        cd 18_raw2vmdk
        ./raw2vmdk.sh 

else #Invalid Choice
	echo -e  "INVALID CHOICE: Please try again"
	exit
fi
