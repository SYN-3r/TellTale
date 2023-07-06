#!/bin/sh

#TellTale Linux Enumeration Script

#Colors
Magenta="${C}[1;95m"
LGray="${C}[1;37m"
DGray="${C}[1;90m"
Blue="${C}[1;34m&${C}[0m"


printf """
${Magenta}/-------------------------------------------------------------------------\
|                           ${Blue}TellTale by SYN-3r${Magenta}                            |
|-------------------------------------------------------------------------|
|                       ${Blue}A Linux Enumeration Script${Magenta}                        |
|                                                                         |
|                                                                         |
|                                                                         |
|         ${LGray}ᘛ⁐̤ᕐᐷ   ${DGray}ᘛ⁐̤ᕐᐷ    ${LGray}ᘛ⁐̤ᕐᐷ   ${DGray}ᘛ⁐̤ᕐᐷ    ${LGray}ᘛ⁐̤ᕐᐷ    ${LGray}ᘛ⁐̤ᕐᐷ   ${DGray}ᘛ⁐̤ᕐᐷ    ${LGray}ᘛ⁐̤ᕐᐷ${Magenta}         |
\-------------------------------------------------------------------------/

"""

#View which user you are
$user=whoami
echo "You are currently: $user"

#View what users are on the machine
loggedon=$w
echo "Users Currently on the machine:\n $loggedon"

#Find sudo users
Sudo1=$(awk -F: '($3 == "0") {print}' /etc/passwd 2>/dev/null
Sudo2=$(grep -v -E "^#" /etc/passwd 2>/dev/null | awk -F: '$3 == 0 {print $1}' 2>/dev/null)

#print any sudo users found
echo "Looking for Sudo Users..."
if [ "$Sudo1" ] || [ ""$Sudo2" ];
then
        echo "Sudo Users:"
        echo "$sudo1"; echo "$sudo2"
else
        echo "No sudo users were found"
fi

#find other non-sudo users
echo "Looking for other users..."
$users=$(ls -ld /home/* 2>/dev/null)

#print all other users found
echo "Other Users:"
if [ $users ];
then
        echo "$users\n"
else
        echo "No other users found, might need sudo privs to view"
fi




