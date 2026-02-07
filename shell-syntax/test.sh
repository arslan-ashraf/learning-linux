#!/usr/bin/bash

FIRST_VAR="this is the first variable"

echo $FIRST_VAR

ARRAY=(zero one two three four)

echo $ARRAY

echo ${ARRAY}

echo ${ARRAY[@]}

echo ${ARRAY[4]}

echo "Now for loop"

for item in ${ARRAY[@]}; do
	echo -n $item | wc -c;
done
