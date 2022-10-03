#!/bin/bash
#
#
# Cian Herlihy | R00205604
# Task 2
#
# Write an interactive bash script that implements a set of menus for creating and writing contents 
# into  a  file,  outputting  to  the  terminal  the  content  of  a  file,  change  file  permission  and  to 
# terminate  the  script.  The  write,  output  and  permission  change  operations  should  be 
# implemented using functions.  
# 
# When the user selects the write option, the script should demand for a file name, create it if it 
# does not exist, and continuously demand for inputs and write them to the file until the user 
# enters the word “stop” then the script should finish writing and return back to the menu options.                 
# 
# When the output option is selected, the script should demand for the name of the file to be 
# printed and output its content. The script should ensure that the file exist and not empty before 
# outputting all of its content to the screen. Then return back to the menu options. 
# 
# When the permission option is selected, the script should demand for a name of the file, check 
# if the file exist and assign execution permission to the file if not already assigned. In case 
# execution permission is already assigned, simply report it. The terminate option should end the 
# script with a goodbye message. Properly comment your code. 
#
#




###################################################################
#		Write to a File until User types 'stop'
###################################################################

writeFile() {
		# Write Menu
	echo "============================="
	echo "What is the name of the file?"
	read fileName
	echo "What would you like to write(add) to the file?"
	echo "type 'stop' to quit"
	
	while :
	do
		read content
		
		if [[ $content != 'stop' ]]
		then
			echo $content >> $fileName
		else
			echo "Content Successfully Added!"
			break;
		fi
	done
	echo ""
}



###################################################################
#		Read File That is Given from User
###################################################################

readFile() {
		# Read File
	echo "============================="
	echo "What is the name of the file?"
	echo "Please include path to file."
	read readFileName
	echo ""
	
	# Check if File Exists
	if [ -e $readFileName ]
	then
		if [ -s $readFileName ] # Check if file has content
		then
			echo ""
			cat $readFileName
			echo ""
		else
			echo "$readFileName is Empty"
		fi
	else
		echo "$readFileName does not Exist"
	fi
	echo ""
}



###################################################################
#	Add Execute Permissions for User to File Given
###################################################################

filePermisson() {
		# File Permissions
	echo "============================="
	echo "Change Permissions of what file?"
	echo "Please include path to file."
	read filePerm
	echo ""
	
	# Check if file exists
	if [ -e $filePerm ]
	then
		if [ -x $filePerm ]
		then
			echo "File already has Execute Permissions."
		else
			chmod u+x $filePerm
			echo "Execute Permissions now enabled."
		fi
	else
		echo "File does not exist."
	fi
	echo ""
}



###################################################################
#			Loop for Main Menu
###################################################################

while true # Continous Loop for Main Menu
do

	# Start Menu
echo "--------------------"
echo "1. Write to file"
echo "2. Read a file"
echo "3. Permission Change"
echo "4. Quit"
echo "--------------------"
read option
echo ""



###################################################################
#	Switch Case to handle Users Options from Menu
###################################################################

case $option in
	1) writeFile ;; #Write to file
	2) readFile ;; # read a file
	3) filePermisson ;; # Permissions Change
	4) X=0; echo "Goodbye!";  echo ""; exit;;
	*) echo "Invalid choice"; echo "";;
esac

done


###################################################################
#			End of Script
###################################################################

