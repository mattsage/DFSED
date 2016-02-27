echo "Please enter the location of the image (e.g. /home/sage/Documents/Practical.floppy.dd)"
read image

echo "How many keywords would you like to search for?"
read numwords
let pass=0
	while [ $pass -lt $numwords ]
        	do
	        echo -e "Please enter the keyword to search for: \E[31m(NOTE: Case Sensitive!)\E[37m"
	        read text
	        echo $text >> keywords.txt
	        pass=$[$pass + 1]
		done
	grep -abif keywords.txt $image	
	echo "Please enter an offset"
	read offset2
	xxd -s $offset2 $image | less
