#!/bin/bash
#
#
# Cian Herlihy | R00205604
# Task 3
#
# Write a bash script that automates the creation and deletion of user accounts. The script should 
# accept as input argument, a file containing a list of user names to be created on the system. 
# Enforce that the user provides this input file when running the script.  
# 
# The  script  should  check  if  the  usernames  already  exist  on  the  system  before  creating  the 
# accounts. If a user account exit, the script should notify the user and skip that user name to the 
# next one. Make sure to create a home directory as well. When the input list has been exhausted 
# and all the user account created, output the content of “/etc/passwd” file and “/home” directory 
# to the terminal for verification.  
# 
# In a next step, the script should ask if user wants to delete the newly created accounts? If yes, 
# the script should delete the accounts including their home directories and output again the 
# content of “/etc/passwd” file and “/home” directory for verification. If no, the script should 
# terminate with appropriate message.  
# 
# Use functions to implement the account creation and deletion operations. The functions should 
# in each case accept one parameter. This script should only be tested/executed with root user 
# privileges. Ensure its enforcement.  Properly comment your code. 
#
#




###################################################################
#	Check for Root user and arguments passed
###################################################################


# Check for root user or Exit if not Root
if [ $EUID -ne 0 ]
then
	echo "Root User not Identified. Please run as root user"
	echo ""
	exit
fi



# Check number of arguments equal to 1 or Exit
if [ $# -ne 1 ]
then
	echo "File not input as argument with script"
	echo ""
	exit
fi


###################################################################
#			Start Menu
###################################################################

	# Start Prompt
echo "--------------------"
echo "Press any key to load file"
echo "--------------------"
read makeUserStartProgram
echo ""
# This Menu is strictly to allow User control script start


###################################################################
#		Add Users from File on Load up to Arrays
###################################################################

# Read Files and add to Arrays (File in argument and /etc/passwd file)
usernameFile=$(cat $1)
passwdFile=$(cat "/etc/passwd")

for name in $usernameFile
do
	# Creates and appends names to array of usernames in file
	usernameArray+=($name)
done


# Use AWK to read passwd file and make 2 arrays
# 1 for users names and another for their home directories
IFS=$'\n'
passwdUserArray=( $(awk -F':' '{print $1}' /etc/passwd) )
passwdHomeArray=( $(awk -F':' '{print $6}' /etc/passwd) )


###################################################################
#	Iterate through arrays to check if User accounts Exist
###################################################################

# Iterates through usernames text file
for ((i=0; i<${#usernameArray[@]}; i++))
do
	# Default variable value is not found
	existCheck=0
	
	# Iterates through users array created by /etc/passwd
	for ((x=0; x<${#passwdUserArray[@]}; x++))
	do
		# Compares name for name in each array
		if [ ${passwdUserArray[$x]} == ${usernameArray[$i]} ]
		then
			# Variable to set if found
			existCheck=1
			
			#Checks if name was found
			if [ $existCheck -eq 1 ]
			then
				# User was found and was not created
				echo "${usernameArray[$i]} already Exists"
				echo "${usernameArray[$i]} Home Directory: ${passwdHomeArray[$x]}"
				echo ""
				continue
			fi
		else
			# 'else' Not needed but improves readability in my opinion
			continue
		fi
	done
	
	# Adds user if it was not found in the array of users in /etc/passwd
	if [ $existCheck -eq 0 ]
	then
		# User was not found and was created
		useradd -m ${usernameArray[$i]}
		echo "${usernameArray[$i]} has been Added!"
		echo ""
		existCheck=0
		continue
	fi
done


# Self Explanatory.. (Lists /home Directory)
echo "Home Directory"
ls /home
echo ""


###################################################################
#	Delete Newly Created Users and Show new Home Directory
###################################################################

delUsers() {
	# Iterates through usernames text file
	for ((i=0; i<${#usernameArray[@]}; i++))
	do
		userdel -rf ${usernameArray[$i]}
	done
	
	echo "New Home Directory"
	ls /home
	echo ""
}


###################################################################
#			Loop for Delete Menu
###################################################################

while true # Continous Loop for Main Menu
do

	# Delete Menu
echo "--------------------"
echo "Would you like to delete the new users?"
echo "1. Yes"
echo "2. No"
echo "--------------------"
read delOpt
echo ""


###################################################################
#		Switch Case Menu to handle Users Choice
###################################################################

# Control Option for Delete Menu
case $delOpt in
	1) delUsers; exit ;; # Delete Users
	2) echo "Goodbye!"; echo ""; exit ;; # Exits Script
	*) echo "Invalid choice"; echo "";;
esac

done


###################################################################
#			End of Script
###################################################################

