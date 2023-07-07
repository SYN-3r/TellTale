#!/bin/sh

#TellTale Linux Enumeration Script

#Colors
C=$(printf '\033')
Magenta="${C}[1;95m"
LGray="${C}[1;37m"
DGray="${C}[1;90m"
Blue="${C}[1;34m&${C}[0m"
Cyan="${C}[1;96m"
Red="${C}[1;31m"


printf """
${LGray}/-------------------------------------------------------------------------\
|                         ${Magenta}♥  TellTale by SYN-3r  ♥${LGray}                        |
|                       ${Magenta}A Linux Enumeration Script${LGray}                        |
|-------------------------------------------------------------------------|
|${Red}:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${LGray}|
|${Red}:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${LGray}|
|${Red}:::::::::::::::::::::           :::::::::           :::::::::::::::::::::${LGray}|
|${Red}::::::::::::::::::                :::::                ::::::::::::::::::${LGray}|
|${Red}::::::::::::::::       ${Magenta}*********    ${Red}:${Magenta}    *********${Red}       ::::::::::::::::${LGray}|
|${Red}::::::::::::::      ${Magenta}*****     *****   *****     *****${Red}      ::::::::::::::${LGray}|
|${Red}:::::::::::::     ${Magenta}****           *******           ****${Red}     :::::::::::::${LGray}|
|${Red}::::::::::::     ${Magenta}****              ***              ****${Red}     ::::::::::::${LGray}|
|${Red}::::::::::::     ${Magenta}****               *               ****${Red}     ::::::::::::${LGray}|
|${Red}:::::::::::::     ${Magenta}****                             ****${Red}     :::::::::::::${LGray}|
|${Red}::::::::::::::     ${Magenta}****                           ****${Red}     ::::::::::::::${LGray}|
|${Red}::::::::::::::::     ${Magenta}****                       ****${Red}     ::::::::::::::::${LGray}|
|${Red}::::::::::::::::::     ${Magenta}****                   ****${Red}     ::::::::::::::::::${LGray}|
|${Red}::::::::::::::::::::     ${Magenta}****               ****${Red}     ::::::::::::::::::::${LGray}|
|${Red}:::::::::::::::::::::::     ${Magenta}****         ****${Red}     :::::::::::::::::::::::${LGray}|
|${Red}::::::::::::::::::::::::::     ${Magenta}****   ****${Red}     ::::::::::::::::::::::::::${LGray}|
|${Red}:::::::::::::::::::::::::::::     ${Magenta}*****${Red}     :::::::::::::::::::::::::::::${LGray}|
|${Red}::::::::::::::::::::::::::::::::    ${Magenta}*${Red}    ::::::::::::::::::::::::::::::::${LGray}|
|${Red}::::::::::::::::::::::::::::::::::     ::::::::::::::::::::::::::::::::::${LGray}|
|${Red}:::::::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::${LGray}|
|${Red}:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${LGray}|
\-------------------------------------------------------------------------/

"""
#Main Code
#_________________________________________________________________
#                             USERS
#_________________________________________________________________

#View what users are on the machine
loggedon=$w
echo "Users Currently on the machine:\n $loggedon"

#View which user you are
$user=whoami
echo "You are currently: $user"

#Present Menu
until [ "$selection" = "0" ]; do
        echo "What would you like to do?\n 1. Find Sudo Users\n 2.See Accesses"
        read 
        if $selection == 1;
                #Find sudo users
                #check to see if root already
                if ([ -f /usr/bin/id ] && [ "$(/usr/bin/id -u)" -eq "0" ]) || [ "`whoami 2>/dev/null`" = "root" ];
                then
                        echo "You are already root"
                else
                        echo "You are not root. Searching for sudo users now..."
        
                #search for sudo iusers
                Sudo1=$(awk -F: '($3 == "0") {print}' /etc/passwd 2>/dev/null
                Sudo2=$(grep -v -E "^#" /etc/passwd 2>/dev/null | awk -F: '$3 == 0 {print $1}' 2>/dev/null)

                #print any sudo users found
                echo "Sudo Users:"
                for user in $(cut -d: -f1 /etc/passwd); 
                do [ $(id -u $user) = 0 ] && echo $user; 
                done | grep -v root

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
        else
                echo "Not a valid selection"
        fi
done

#See if root is able to log in using SSH
if [ grep -E "^[[:space:]]*PermitRootLogin " /etc/ssh/sshd_config | grep -E "(yes|without-password|prohibit-password)" 2>/dev/null 1>/dev/null ];
then
        echo "Root can log in using SSH"
else
        echo "Root is not able to log in using SSH"
fi

#See available shells
echo "Available Shells:"
cat /etc/shells

#_________________________________________________________________
#                             FILES
#_________________________________________________________________

