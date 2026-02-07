#! /bin/bash
# the location of bash, can be found using command "which bash"

#! /usr/bin/env python 
# this is for a python script, can be found by command "which python"

echo "testing"

NAME="example"
echo "My name is $NAME"
echo "My name is ${NAME}"


if ["$NAME" == "example"]
then
	echo "name is $NAME"
elif  ["$NAME" == "something"]
then
	echo "name is not $NAME"
else
	echo "testing"
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

if ["$NUM2" -gt "$NUM1"] # -gt is greater than
then
	echo "$NUM2 is greater than $NUM1"
elif [[ "$NUM2" -lt "$NUM1" ]]
then
	echo "something"
fi


# file checks, use command "man test" to see details
-d file_name		true if file is a directory
-e file_name		true if file exists
-f file_name		true if string is a file
-g file_name		true if group id is set on a file
-r file_name		true if file is readable
-s file_name		true if has non zero size
-u					true if user id is set on a file 
-w					true if file is writable
-x					true if file is an executable

FILE=test.txt

if [ -f "$FILE" ]
then
	echo "$File is a file"
else
	echo "$FILE is not a file"
fi


# rename a bunch of files with "new" prefix

LIST_OF_FILES=$(ls *.txt)
NEW="new"
for _file in $LIST_OF_FILES do 
	echo "Renaming $_file to $NEW-$FILE"
	mv $_file $NEW-$_file
done


ARRAY=(zero one two three four)
echo $ARRAY
echo ${ARRAY}
echo ${ARRAY[@]}
echo ${ARRAY[4]}
echo "Now for loop"

for item in ${ARRAY[@]}; do
	# print the length of each item in the array
	echo -n $item | wc -c;
done


# read a file line by line
INDEX=1
while read -r CURRENT_LINE do 
	echo "$INDEX: $CURRENT_LINE"
	((INDEX++))
done < "./example.txt"


function example_function(){
	echo "dollar 0 is name of current file $0"
	echo "dollar @ lists all the arguments "
	echo "dollar # is number of arguments"
	echo "first variable $1"
	echo "second variable $2"
}

example_function "a", "b"

show_uptime(){
	up=$(uptime -p | cut -c4-)
	since=$(uptime -s)
	cat << EOF
-------------
This machine have been up to ${up}.
It has been running since ${since}.
-------------
EOF
}

show_uptime