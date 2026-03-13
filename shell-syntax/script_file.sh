#!/bin/bash
# the location of bash, can be found using command "which bash"

#!/usr/bin/env python 
# this is for a python script, can be found by command "which python"


# single quotes '' interpret literally, double quotes "" are executed
echo "testing"

NAME='example'
echo "My name is $NAME"
echo "My name is ${NAME}"


# there are two types of brackets ((  )) and [[  ]] for conditionals and
# pattern matching
# the round brackets ((  )) are for arithmetic evaluation the straight 
# brackets [[  ]] are for conditional expressions, file and string matching, it 
# uses lexical comparison, so [[ "40" < "7" ]] is true as 4 comes before 7 
# lexicographically

# note: conditions can also be checked with [ ] and test, but those are
# binary programs (command: which [), better practice is to use [[ ]]
if [[ "${NAME}" == 'example' ]]
then
	echo "name is $NAME"
elif  [[ "${NAME}" == 'something' ]]
then
	echo 'elif block'
else
	echo 'testing'
fi


# boolean checks, use command "man test" to see details
-eq		checks equality
-ne		checks not equal
-gt 	greater than
-ge 	greater than or equal to
-lt		less than
-le		less than of equal to

NUM1=3
NUM2=4

if [[ "$NUM2" -gt "$NUM1" ]] # -gt is greater than
then
	echo "$NUM2 is greater than $NUM1"
elif [[ "$NUM2" -lt "$NUM1" ]]
then
	echo "something"
fi

# arithmetic operations, with double brackets ((  )), $ symbol in front of 
# variable names is not needed, and there can be spaces around = symbol
(( result = NUM1 + NUM2 ))
echo "${result}" # or echo $(( NUM1 + NUM2 ))
# bash can behave strangely with arithmetic, so it is best practice to always
# wrap all arithemtic operations inside ((  ))

# declare a variable of integer type
declare -i interger_variable
interger_variable=5

# bash doesn't really support floating point operations, to perform floats
echo "5.4 / 1.7" | bc 
# "5.4 / 1.7" is just an ordinary string, bc is basic calculator


# we can check whether a file has various properties with file checks
# use command "man test" to see more
[ -n file_name ]		true if file_name length is 0
[ -d file_name ]		true if file is a directory
[ -e file_name ]		true if file exists
[ -f file_name ]		true if string is a file
[ -g file_name ]		true if group id is set on a file
[ -r file_name ]		true if file is readable
[ -s file_name ]		true if has non zero size
[ -u file_name ]		true if user id is set on a file 
[ -w file_name ]		true if file is writable
[ -x file_name ]		true if file is executable

FILE=test.txt

if [[ -f "$FILE" ]] # see list above
then
	echo "$FILE is a file"
else
	echo "$FILE is not a file"
fi

# the loop iteration is defined as {start..end..step_size}
# print integers 1 through 10 all inclusive
for integer in {1..10};
do
	echo "${integer}"
done

# print odd integers 1 through 10 all inclusive, step size is 2
for integer in {1..10..2};
do
	echo "${integer}"
done

# print letters a to z all inclusive, we can also do {z..a}, {A..z}, {A..Z}
for letter in {a..z};
do
	echo "${letter}"
done

# another, more intuitive way
for (( i = 0; i < 5; i++ ));
do
	echo "${i}"
done


# rename a bunch of files with "new" prefix

LIST_OF_FILES=$(ls *.txt)
NEW="new"
for _file in $LIST_OF_FILES; do 
	echo "Renaming $_file to $NEW-$_file"
	mv $_file $NEW-$_file
done


ARRAY=(zero one two three four)
echo $ARRAY
echo "${ARRAY}"
echo "${ARRAY[@]}"		# outputs the whole array
echo "${#ARRAY[@]}"		# outputs length of array
echo "${ARRAY[4]}"
echo "Now for loop"

for item in ${ARRAY[@]}; 
do
	# print the length of each item in the array
	echo -n $item | wc -c;
done

######### IFS - Internal Field Separator #############

# the IFS environment variable defines the characters that are used to
# separate strings into words, by default it is set to a string containing
# one white space, one tab, and one newline character like this: IFS=" \t\n"
# so any time a white space, tab or newline appears in a string, those will be 
# separate words

# read a file line by line, "IFS=" preserves any leading/trailing blank space
# -r prevents backslashes as escape characters, so any backslashes in the text
# show up as they are
INDEX=1
while IFS= read -r CURRENT_LINE; 
do 
	echo "$INDEX: $CURRENT_LINE"
	((INDEX++))
done < "example.txt" # input to the while loop


# note in bash, all variables defined anywhere are global by defualt
# function keyword to the left of function name can be ommitted
# example_function(){ ... }  # also works
function example_function(){
	echo "dollar 0 is name of current file $0"
	echo "dollar @ lists all the arguments $@"
	echo "dollar # is number of arguments $#"
	echo "first variable $1"
	echo "second variable $2"
	local my_variable=4 # to ensure my_variable has local scope
}

example_function "a", "b"

function use_default_value(){
	local name=${1:-"world"}
	echo "hi $1"
}

use_default_value 			# prints hi world
use_default_value linux 	# prints hi linux

# functions are just programs in bash and return status codes by default 0
# so they only return integers, to pass data from one function to another
# one function can write to standard out stream, the receiving function 
# can use that as its standard input stream

function first(){
	echo "first function's output"
	return 0
}

function second(){
	local message=$(first)
	echo "${message}"
	return 0
}

second

show_uptime(){
	up=$(uptime -p | cut -c4-)
	since=$(uptime -s)
	cat << EOF
-------------
This machine have been up for ${up}.
It has been running since ${since}.
-------------
EOF
}

show_uptime