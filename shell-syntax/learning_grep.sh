# the grep command: "global regular expression print", is a command for searching 
# and matching text format of the command, usage for searching in one file:
grep "example_string" <file_name> # or 
<file_name> grep "string" 

# to search for a string in the current directory in all files
grep "example_string" *

# to search for a string in the current directory and all of its 
# subdirectories: note: -r is for recursive, -i is for ignoring case sensitivity
# -F is for fix-strings, no regex
grep -riF "example_string" *

# -c is for counting the number of lines that match the example_string
grep -c "example_string" file_name

# print all lines that do NOT contain the matching example_string
grep -v "example_string" file_name

# number the lines that contain the matching example_string
grep -n "example_string" file_name

# search for exact matching word
grep -w "example_string" file_name

# to find out if a package has been installed
dpkg -l | grep -i "package_name"

# print 3 lines after and before the search text, -A flag for after, -B flag for before
grep -A 3 "example_string" file_name
grep -B 3 "example_string" file_name

# grep with regular expressions
^     matches characters at the beginning of a line
$     matches characters at the end of a line
"."   matches any character
[a-z] matches any characters between a and z
[^ ..]  matches anything apart from what is in the brackets

# EXAMPLE GREP JSON FILE:
# Extract the 'price' from the following JSON file named bitcoin_price.txt
{
  "coin": {
    "id": "bitcoin",
    "icon": "https://static.coinstats.app/coins/Bitcoin6l39t.png",
    "name": "Bitcoin",
    "symbol": "BTC",
    "rank": 1,
    "price": 57907.78008618953,
    "priceBtc": 1,
    "volume": 48430621052.9856,
    "marketCap": 1093175428640.1146,
    "availableSupply": 18877868,
    ...
  }
}

cat bitcoin_price.txt | grep -oE "\"price\"\s*:\s*[0-9]*?\.[0-9]*"

-o tells grep to only return matching part 
-E tell grep to be able to use regex symbols such as ?
\" is how a double quote is interpreted to form string
price using \"price\" is the string to match
\s is for matching whitespace characters which include 0
* matches any number (zero or more) of preceding character
\s* matches any number (zero or more) of whitespace characters
: matches :
[0-9]* matches any number from 0 to 9
\. is how the . (dot) is written
? matches any single character 
?\. matches .