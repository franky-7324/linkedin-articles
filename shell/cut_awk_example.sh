#!/bin/bash

# This script manipulates the /etc/passwd/ files output using cut and awk.

# Functions Declaration

out1() {
    if [[ ${?} -ne 0 ]]
    then
            echo "FAIL: "${@}""
            exit 1
    fi
}

break1() {
    if [[ ${?} -eq 0 ]]
    then
            echo
            echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
            echo "Next Section: "${@}""
            echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
            echo
    fi 
}

# VARIABLES

testdir='/etc/passwd'
testfile='/tmp/testfile.txt'

echo "Starting the Demonstration....."
out1 'Directory not found'


break1 'Last 5 lines from Initial content of /etc/passwd file'
cat ${testdir} | tail -5f > ${testfile}
cat ${testfile}

# -c is used for character
# -b is used for byte which is not much different from char but can come up with issues in csae of multibyte characters.
# -d is for using delimiter. its good practise to qoute your delimiter.
# -f 

break1 'Using cut to print the first character from every line of the file'
cut -c 1 ${testfile}

break1 'Using cut to print 3rd to 5th character from every line of the file'
cut -c 3-5 ${testfile}

break1 'Using cut to print 4th to last character from every line of the file'
cut -c 4- ${testfile}

break1 'Using cut to print first, third and eighth character from every line of the file'
cut -c 1,3,8 ${testfile}

break1 'Using cut to print first, third and from eighth to last character from every line of the file'
cut -c 1,3,8- ${testfile}

break1 'Using cut and -d and -f option to print 1st and 3rd field from every line of the file'
cut -d ':' -f 1,3 ${testfile}

break1 'Using cut and -d and -f option to print 1st and 3rd field from every line of the file and using --output-delimiter option to modify the separator.'
cut -d ':' -f 1,3 --output-delimiter=',' ${testfile}

break1 'Using cut and -d and -f option to print 1st and 3rd field from every line of the file and using --output-delimiter option to modify the separator.'
cut -d ':' -f 1,3 --output-delimiter='hello' ${testfile}

break1 'Using awk and -F option to print 1st and 3rd field from every line of the file and out put separated with space.'
awk -F ':' '{print $1, $3}' ${testfile}

# OFS is a special variable given by awk for Output field Separator.
break1 'Using awk, -v, OFS variable and -F option to print 1st and 3rd field from every line of the file and out put separated with comma.'
awk -F ':' -v OFS=',' '{print $1, $3}' ${testfile}

# another way for separator in awk
break1 'Using awk and -F option to print 1st and 3rd field from every line of the file and out put separated with semi-colon.'
awk -F ':' '{print $1 ";" $3}' ${testfile}

# another way for separator in awk
break1 'Using awk and -F option to print 1st and 3rd field from every line of the file and out put separated with comma and a space'
awk -F ':' '{print $1 ", " $3}' ${testfile}

# adding text as separators
break1 'Using awk and -F option to print 1st and 3rd field from every line of the file and append text to the output.'
awk -F ':' '{print "COL1: " $1 " COL2: " $3 }' ${testfile}

# adding text as separators, u can jumble the order of output as well.
break1 'Using awk and -F option to print 1st and 3rd field from every line of the file and append text to the output and order is changed.'
awk -F ':' '{print "UID: " $3 " USER: " $1 }' ${testfile}

# NF gives us the value of the last field.
break1 'Using awk, NF and -F option to print last field using NF variable.'
awk -F ':' '{print $NF }' ${testfile}

break1 'Using awk, NF and -F option to print second to the last field using NF variable.'
awk -F ':' '{print $(NF - 1) }' ${testfile}

break1 "The END."

echo 'AWK should be used in two situations instead of cut'
echo '1. When the delimiter that comprises more than a single character.'
echo '2. To handle fields separated by white spaces as awk treats white spaces as separator fields automatically.'
echo
echo 'Thanks for tuning In. See you next time.'
echo
