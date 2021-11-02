#!/bin/bash
#autumnWind
#November 1st
#Compiles, then runs java files in a directory
#Like a lame version of rust's cargo!

#Help message
Usage() {
	echo "Usage: $(basename $0) [Args] [File.java]"
	echo '   Compiles then runs java files in directory'
	echo
	echo '   -h shows help page'
	echo '   -r Include sub-directories'
	echo '   -i Include given file in compilation'
	echo '   -v more verbose output'
        exit 1
}

#Set last input to INPUT

INPUT="${@: -1}"
DIR="$(dirname "$INPUT")"
FILE="$(basename "$INPUT")"

#Check if INPUT is valid
[ -f "$INPUT" ] && [ "${FILE##*.}" == "java" ] || { #invalid file
						   echo "error: $INPUT is not a valid java file";
						   echo;
					           Usage;
	   				          }

optstring=":hrvi"
#Check options
while getopts ${optstring} arg; do
	case "$arg" in
		h) #help
		 Usage
		 ;;
		r) #Recusive
		 echo "Option 'recursive' was called"
		 ;;
		i) #Inclusive
		 echo "Option 'include' was called"
		 ;;
		v) #Verbose
		 echo "Option 'verbose' was called"
		 ;;
    	?) #Unknown Option
      	 echo "Invalid option: -${OPTARG}."
		 echo
		 Usage
      	 ;;
  	esac
done


for file in $DIR/*; do
		fileName=$(basename "$file")
		[ "$fileName" != "$FILE" ] && [ "${fileName##*.}" == "java" ] && javac $file
done
cd $DIR
java $INPUT
