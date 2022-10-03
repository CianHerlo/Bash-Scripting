#!/bin/bash
#
#
# Cian Herlihy | R00205604
# Task 1
#
#
# Write a bash script that searches for patterns in files located in a folder. The script should be 
# called with two input parameter arguments. Make sure that the arguments are provided before 
# proceeding. The first parameter should be a path to a folder and the second parameter should 
# be a string pattern.      
#  
# The script should search the provided folder and print out the following details for only files 
# identified (that is no sub-folder should be considered): 
# • Name of the file.  
# • Date and time of file creation. 
# • Size of the file in bytes.   
# • How many times the input string pattern (second parameter) appeared in the file (case 
# insensitive).  
# Use an array structure to store the file names for those that contain the input string pattern 
# (second parameter) at least twice.  
# 
# An until loop should be used to iterate through the above array and print out to the terminal all 
# the file names as well as write them into a file named report.txt. Use comments to properly 
# document your script. 
# 
#




###################################################################
#			Declaring Constants
###################################################################

# Constants such as arguments from script and report file name
DIR=$1
STRING=$2
REPORT="report.txt"



###################################################################
#	Checking if Arguments with script equal 2 or Exit
###################################################################

# Check number of arguments equal to 1 or Exit
if [ $# -ne 2 ]
then
	echo "File and String not input as argument with script"
	echo ""
	exit
fi



###################################################################
#	     Printing out file Details in Folder Given
###################################################################

# Print out Name, Date, Time, Size
ls -l $DIR | awk '{print "Name:"$9"\tDate:"$7" "$6"\tTime:"$8"\tSize:"$5}'

# Change into directory given to make it easier to handle and put report.txt in folder
cd $DIR



###################################################################
#  Iterate through Files and check for matching words in Files
###################################################################

# Iterate through all files and check for string given
for file in *
do
	# -w for whole words only. -c for word count
	echo "$file Matches $STRING: "
	grep -w -c $STRING $file
	echo "'$file' contains the word '$STRING': "$(grep -w -c $STRING $file)" times."
	
	
	# If the grep word count is > 2 then it will add name of file to array
	if [ $(grep -w -c -r "$STRING" $file) -ge 2 ]
	then
		filesArray+=($file)
	fi
done



###################################################################
#		Until Loop to iterate and print files 
# 	exceeding 2 successfull word matches. Then overwrites 
# 		    report.txt with file names
###################################################################

# Loop counter for until loop
counter=0
until [ $counter -eq ${#filesArray[@]} ] # Counter needs to equal array size to end
do
	echo ""
	echo "Files that contain $STRING more than 2 times"
	echo "--------------------------------------------"
	echo ${filesArray[counter]}
	echo ""
	
	# I want it to overwrite ever time so you do not append 
	# existing results from past searches
	echo ${filesArray[counter]} > $REPORT
	
	# Increment loop counter
	((counter++))
done


###################################################################
#			End of Script
###################################################################

