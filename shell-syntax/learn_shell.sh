#############################################################
###### START - ECHO, CD, LS, MAN, PRINTENV, SHELLCHECK ######
#############################################################

# clear can also be used by pressing ctrl l buttons


# Show an environment variable's value
echo $name_of_variable
echo $PATH

# What is a PATH?
# A way to name a file on a computer

which echo


# Absolute path: fully determines the location of a file
# Relative path: determines a location relative to where you currently are

# Go back to the previous directory, handy if you want to go back and forth between directories
cd -

# shows the root directory
ls /

# show hidden files
ls -a

# Check file permissions
ls -l
ls -al # for hidden files as well

# drwxr-xr-x - d indicates this is a directory, r is for read, w is for write which includes
# the permission to delete and update, and x is for execute

# There are three groups of three permissions each, the first three letters after d are 
# permissions for the owner of the file, the next three are for the group that owns the file, and 
# the last three are permissions for everyone else

# in the result for ls -l command, the second column shows the number of hard links to the file,
# the third column is the user that owns the file, the fourth column is group owner
# the fifth column is the last date and time the file was touched, meaning created/updated

# list directories and its subdirectories/files recursively
ls -R

# to view the inode number of files:
ls -i

# multiple commands in a single line with ;
ls; ls -l


# man pages
man <command_to_learn_about>

# check the documentation of manual pages
man <command>
example: man grep


# /proc file contains list of processes
# show process info for process 12345
cat /proc/12345/status


# Replace a command with its output
my_path=$(pwd) # or using another way using backticks
my_path=`pwd`
echo $my_path # shows current working directory


# check syntax of a .sh file
shellcheck srcipt_file.sh


# to print all the environment variables
printenv


#############################################################
####### END - ECHO, CD, LS, MAN, PRINTENV, SHELLCHECK #######
#############################################################


#############################################################
################# START - BUILT-IN VARIABLES ################
#############################################################


# variables starting with $, use them with echo to see output
$0 = name of current file 
$# = number of variables passed into file or function depending on scope
$@ = list all arguments to a function
$? = the status code of last shell command 
$$ = some number (id or memory location)?
$1 = first argument to file or function depending on scope
$n = nth argument to file or function depending on scope
$PATH = all paths in the PATH variable


# to see all the paths in PATH variable
echo $PATH
# to see them in a clean line by line format
tr ':' '\n' <<< $PATH # trims : and displays each split value on a new line
# another way using "tr" which trims the first argument and replaces with second
echo $PATH | tr ':' '\n'


#############################################################
################## END - BUILT-IN VARIABLES #################
#############################################################


#############################################################
################ START - USERS & PERMISSIONS ################
#############################################################


# there are three type of users: root user, regular users, and service users

# Root user: has user ID 0, highest privileges, only one root user on the system
# Regular users: can have temporary root privileges through sudo
# Service uesrs: for specific tasks such as running a webserverm database server, etc.


# all users have primary group and users can be further assigned to an arbitrary 
# number of groups

# on Linux, all user information is stored on the etc/passwd which shows user ID,
# group ID, default shell, home directory, etc., but no passwords, readable by all users

# etc/shadow stores the encrypted passwords and expiration dates, its readable
# only by root user or those that have temporary root access

# etc/group contains group info and their members, readable by all users

# etc/sudoes file lists which users are allowed temporary root privileges with sudo

# in some distros, users that are allowed to use sudo belong to the 'sudo group'
# or 'wheel group'


# print username
whoami # or
id -u -n

# print id information
id 
# print user id number
id -u

# file permissions define 'u' for file owner, 'g' for group, and 'o' for other uesrs

# for example: drwxrw-r--  permissions mean: 
# d for directory, first rwx are for owner 'u', the second rw- are for group 'g',
# and the last three r-- are for others 'o'


# chmod command assigns file permissions

# remove read permissions with "-r" from group "g" and other "o"
chmod go-r file.txt

# add read permissions with "+r" from group "g" and other "o"
chmod go+r file.txt

# change permissions to execute a file
chmod +x file_name

# chown command can change owner/group of a file
# only root or user with sudo privileges can use chown

# to change the owner and group of a file/s
chown <new_owner>:<new_group> <file_name> <file_name>

# to change the owner of a file/s
chown <new_owner> <file_name> <file_name>

# to change the group of a file/s
chown :<new_group> <file_name> <file_name>

# use -R flag for a recursive change in a directory
chown -R <new_owner>:<new_group> <directory_name>

# NOTE: in order for a directory to have write permissions, it also needs the
# execute permissions as that's required to enter into directory and traversal


#############################################################
################# END - USERS & PERMISSIONS #################
#############################################################


#############################################################
############ START - VARIABLES, PIPES & FILTERS #############
#############################################################

# SCOPE: plain variables have scope only within the shell in which
# they were created, environment variables however have extened scope
# beyond the shell which created them

# variables, spaces matter, so no spaces around the equal sign, 
# the single and double quotes also matter
my_var=_example
echo $my_var
echo "my variable is $my_var"

# get the output of a shell command into a variable
my_var=$(pwd)
echo $my_var
echo "Current directory path is $(pwd)"
echo "date and time right now is $(date)"

# deletes the variable
unset $my_var


# Export a local variable to the environment
export my_var

# Filters are commands that take input and may transform it, and send output
# Filters can be chained together
# Examples of filters: wc (word count), cat (print file content), 
# more (print file content line by line), head (print only the first n lines),
# sore (sort lines in a file), grep (search for text in a file)

# Pipe (pipeline) "|" means take the output of the program to the left 
# and make it the input to the program on the right 

# tail command gets the last n lines
# this command takes the output of "ls -l /" and pipes to the tail command
# which prints the last 3 lines
ls -l / | tail -n3

#############################################################
############# END - VARIABLES, PIPES & FILTERS ##############
#############################################################


#############################################################
########## START - WRITING & APPENDING INTO FILES ###########
#############################################################


# > writes to example.txt, this overwrites whatever was there before
echo "example test" > example.txt
# 2> writes standard error to error.txt, overwriting whatever was there before
echo nothing 2> error.txt
cat error.txt # nothing: command not found

# 1> writes standard output to std_output_file.txt, overwriting whatever was
# there before
echo "some text" 1> std_output_file.txt

# another example, executes a shell script and sends output to std_output_file.txt
./shell_script.sh 1> std_output_file.txt

# note: 0 is for standard in, 1 is for standard out, 2 is for standard out
# and these are all streams

# >> appends to example.txt
echo "text" >> example.txt
# 2>> appends standard error to error.txt
echo nothing 2>> error.txt
cat error.txt # nothing: command not found

# &> redirects standard out and standard error
./script.sh &> file.log

# 2>&1 redirects standard error to the same file as standard output
# the line below sends standard output and standard errors from script.sh
# into logs.txt, this duplicates file descriptor 1 and makes file descript 2
# point to that duplicate, the open file description table (which holds
# metadata about all open files such as byte offset, i-node pointer, which
# process's which file descriptor is pointing to where, etc.) has one entry
# to which both file descriptors point to, the dup() and dup2() system calls
# do the same thing
./script.sh > logs.txt 2>&1
# order here matters, so the command below will send standard error to
# the standard output file and then send standard output to logs.txt
./script.sh 2>&1 > logs.txt

#############################################################
########### END - WRITING & APPENDING INTO FILES ############
#############################################################


#####################################################################################
########### START - READING, WRITING FILES, SEARCHING FOR & INSIDE FILES ############
#####################################################################################

# cp command = copy and paste
# mv command = cut and paste

# copy files
cp <file_to_copy> <destination>
# copy directories, -r is to recursively copy everything inside directory_to_copy
cp -r <directory_to_copy> <destination>

# move three source files to target_directory
mv source_file_1 source_file_2 source_file_3 target_directory
mv *.txt target_directory
mv source_directory target_directory

# rename using mv
mv source_file_1 target_file_name # overwrites any target_file if it exists
# rename directory using mv
mv source_directory path_to_non_existing_directory


# prevents overwriting any file in target_directory with the same name
mv -n source_file_1 target_directory

# i is for interactive, it asks if you want to overwrite
mv -i source_file_1 target_directory

# remove file
rm file_name

# by default removal is not recursive, so you cannot delete a directory using rm
# to force the deletion of a directory and all files and directories inside 
# recursively use the -r flag
rm -r directory_with_contents_to_delete

# to ensure that directory to be deleted is empty
rmdir empty_directory_to_delete

############# READING FILE CONTENTS ############
# print the first 10 lines in a file
head <file_name>
head -n3 <file_name> # print first 3 lines
# print the last 10 lines in a file
tail <file_name>
tail -n3 <file_name>
# when a file is large, print it page by page, enter q to quit
more <file_name> 

# word count command, the less than < is used to get input from a file
wc file.txt # shows three number, lines, words, characters including newlines
wc -l file.txt # view only line count
wc -w file.txt # view only word count
wc -w < file.txt # another way to view word count
# character count
wc -c file.txt


# sort the lines of a file
sort file.txt # ascending order
sort -r file.txt # sort in descending order


# removes lines if they repeat one after the other but not if there is
# some other line in between repeats
uniq file.txt


# print only characters in the range of each line
# print each line starting from third character to eigth character
cut -c 3-9 file.txt # -c is for character
# -d is for delimeter and the ' ' says by space, -f3 says get the third word 
# of each line
cut -d ' ' -f3 file.txt 


# concatinate multiple files column wise, each line is added to be the same line
# in the next file
paste file_1.txt file_2.txt file_3.txt # concatinates by tab
paste -d ", " file_1.txt file_2.txt file_3.txt # concatinate by ', '

# find files/directories
find "file_or_directory_name" # searches the entire filesystem
find . -name "file_name" # . means look in current directory
find . -iname "file_name" # -i means ignore upper/lower case


# check when a file was last modified
date -r <file_name>

# truncate target characters with replacement characters
tr [OPTIONS] [target characters] [replacement characters]

# perform replacement
echo "Linux and shell scripting are awesome\!" | tr "aeiou" "_"
# => L_n_x _nd sh_ll scr_pt_ng _r_ _w_s_m_!

# perform complement of replacement
echo "Linux and shell scripting are awesome\!" | tr -c "aeiou" "_"
# => _i_u__a_____e______i__i___a_e_a_e_o_e_

# Capitalize output of pet.txt
cat pets.txt | tr "[a-z]" "[A-Z]"
GOLDFISH
FISH
CHICKEN
PARROT
FISH
GOLDFISH
GOLDFISH

# Return only uniq lines and capitalize them
sort pets.txt | uniq | tr "[a-z]" "[A-Z]"
CHICKEN
FISH
GOLDFISH
PARROT

# the grep command: "global regular expression print", is a command for searching 
# and matching text format of the command: grep "string" file_name or file_name 
# grep "string" to search for a string in the current directory and all of its 
# subdirectories: note: -r is for recursive, -i is for ignoring case sensitivity
grep -r "example" *

# -c is for counting the number of lines that match the string
grep -c "example" file_name

# print all lines that do NOT contain the matching string
grep -v "example" file_name

# number the lines that contain the matching string
grep -n "example" file_name

# search for exact matching word
grep -w "example" file_name

# to find out if a package has been installed
dpkg -l | grep -i "package_name"

# print 3 lines after and before the search text, -A flag for after, -B flag for before
grep -A 3 "example" file_name
grep -B 3 "example" file_name

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


#####################################################################################
############ END - READING, WRITING FILES, SEARCHING FOR & INSIDE FILES #############
#####################################################################################




################################################################################
################## START - JOBS, OS, NETORKING, DOWNLOADING ####################
################################################################################


# hostname of machine
hostname
hostname -s # drops domain suffix
hostname -i # ip address

# print os name
uname
uname -v # detailed info
uname -s -r # os name with version number


# show disk usage with "disk free"
df -h
df -h ~


# show running processes and CPU and RAM consumption with "table of processes"
top
top -n 3

# a better program for showing running processes
htop 


# print -a all running processes for -e every user in -l long format
ps 
ps -eal


# watches the command grep <string> <file> every five seconds
watch -n 0.5 grep <string> <file>


# sets process priority, lower niceness, higher priority
# priorities range from -20 highest priority to 19 lowest priority
nice # sets priority of a new process
renice # sets priority of an already running process


# return process id of process with specific <process_name>
# -f flag returns all process ids with <process_name> somewhere
pgrep <process_name>
pgrep -f <process_name>


# sets lowest priority 19 for all chrome processes
renice -n 19 $(pgrep -f chrome)


# benchmarking tool, evaluates CPU, memory, file I/O, databases and more
sysbench

# tests CPU performance by calculating prime numbers
sysbench cpu run --threads=<number_of_threads> --cpu-max-prime=<limit>



# list all signals numbers 1-64 which include SIGTERM, SIGKILL, SIGCHLD, etc.
kill -l

# end the chrome process politely it can perform cleanup with SIGTERM signal
kill -s SIGTERM $(pgrep chrome)


# interface configuration
ifconfig
ifconfig eth0 # ethernet adapter info


# send icmp packets to url and print response, abort with control c
ping <website>
ping -c 5 <website> # a set number of ping results


# how to run a background job
ping -n 100 <website> &

# check all running background jobs
jobs

# bring a background job to the foreground
# note: only foreground jobs can receive keyboard input including ctrl c to quit
fg %<job_id>

# to pause a job, run job in the foreground such as:
ping -n 10 <website>
# then, ctrl z to stop the job (this sends a SIGSTOP signal to process but
# the process may choose to ignore it), the jobs command will show list of jobs, 
# to resume the job in the foreground (this sends a SIGCONT signal to process):
fg %<job_id>
# to resume the job in the background:
bg %<job_id>

# to terminate a job with the SIGTERM signal, if this doesn't work, use SIGKILL
kill -s SIGTERM $<job_id>

# to terminate a job with the SIGKILL signal
kill -s SIGKILL $<job_id>


# transfer data to and from URLs
curl <website> # returns the entire html of webpage
# write the resulting html into file.txt
curl <website> -o file.txt


# "web get" to download a file from a URL
wget <file_to_download>


################################################################################
################### END - JOBS, OS, NETORKING, DOWNLOADING #####################
################################################################################



################################################################################
################# START - ARCHIVING, ENCODING AND COMPRESSION ##################
################################################################################


# archive and dearchive (extract) files or directories using "tape archiver"
tar -cf <file_name>.tar <file_name>
tar -cf <directory_name>.tar <directory_name>

# to also compress using gzip
# NOTE: TAR FIRST BUNDLES INTO 'TARBALL' AND THEN COMPRESSES THE TARBALL
tar -czf <file_name>.tar.gz <file_name>
tar -czf <directory_name>.tar.gz <directory_name>

# list archived contents
tar -tf <file_name>.tar 
tar -tf <directory_name>.tar 

# extract files and folders
tar -xf <file_name>.tar <file_name>
tar -xf <directory_name>.tar <directory_name>

# decompress and extract files and folders
tar -xzf <file_name>.tar.gz <file_name>
tar -xzf <directory_name>.tar.gz <directory_name>


# compress files and directories
# NOTE: ZIP FIRST COMPRESSES AND THEN BUNDLES, TAR DOES IT IN REVERSE
zip -r <file_name>.zip <file_name>
zip -r <directory_name>.zip <directory_name>

# uncompress files and directories
unzip <file_name>.zip 
unzip <directory_name>.zip

# to encode text in base64
echo "text_to_encode" | base64

# take base64 encoded text and convert it to utf-8, -d is for decoding
"base64_encoded_text" base64 -d

# example
echo "test" | base64 | base64 -d


################################################################################
################## END - ARCHIVING, ENCODING AND COMPRESSION ###################
################################################################################



################################################################################
###################### START - SHELL FILE BEST PRACTICES #######################
################################################################################


# the shell script file will continue to execute commands one by one even 
# if some of them fail, in the command line, you get immediate explicit errors
# but this is not the case when executing a shell script file

# the "set" command immediately fails and stops running the commands in 
# a shell script file when errors occur but the type of error which stops 
# the file from running is dependant on the flag given to the "set" command

# immediately exit if any command has a non zero exit code (use echo $? to see
# exit code of last run command)
set -e

# throws an error if any variable is referenced which does not exist
set -u

# prevents errors in a pipeline (with "|") from being executed
set -o pipefail
# consider the following:
grep "some string" nonexisting_file | sort
# this returns an error code of 0 (which is success) because the command
# `grep "some string" nonexisting_file` writes the error (with error code 2) 
# in stderr file and an empty string into stdout which gets piped into "sort"
# which has an error code of 0 (success), the command "set -o pipefail"
# will immediately fail before the execution even gets to the pipe

# -e, -u, -o pipefail together
set -euo pipefail

# for debugging, print every command in the terminal
set -x

################################################################################
####################### END - SHELL FILE BEST PRACTICES ########################
################################################################################



################################################################################
######################## START - SOURCING A SHELL FILE #########################
################################################################################

# the notion of sourcing is to make all the variables, aliases,
# and functions avaiable to the current shell process, meaning if
# an alias is defined inside the file, sourcing will bring that
# alias outside the file and into the current shell process

# note: the shell process runs aliases first, then user defined 
# functions, then built-in functions, and finally path executable files

# syntax
source ./<file_name.sh>

################################################################################
######################### END - SOURCING A SHELL FILE ##########################
################################################################################


# create an alias in the .bashrc file
vim ~/.bashrc
# now set the alias in this file such as: 
alias my_ls="ls -al"
# now my_ls can directly be used in the terminal