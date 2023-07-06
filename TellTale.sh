#!/bin/sh

#TellTale Linux Enumeration Script

#Find sudo users
Sudo1=$(awk -F: '($3 == "0") {print}' /etc/passwd 2>/dev/null
Sudo2=$(grep -v -E "^#" /etc/passwd 2>/dev/null | awk -F: '$3 == 0 {print $1}' 2>/dev/null)

#print a list of all of the sudo users found
if [ "$Sudo1" ] || [ ""$Sudo2" ];
then
