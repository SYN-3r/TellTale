#!/bin/sh

#TellTale Linux Enumeration Script

#Colors
C=$(printf '\033')
Magenta="${C}[1;95m"
LGray="${C}[1;37m"
DGray="${C}[1;90m"
Blue="${C}[1;34m"
Cyan="${C}[1;96m"
Red="${C}[1;31m"
Normal="${C}[0m"


printf """
${LGray}/-------------------------------------------------------------------------\\
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

#basic start up info for log on
#View what users are on the machine
loggedon=$( w | awk -F" " '{ print $1,$4 }')
echo "Users Currently on the machine:\n $loggedon"

#View which user you are
user=$(whoami)
echo "You are currently: $user"

#MENU display start
while true; 
do
        printf """
                 ${Blue}MAIN MENU
        What would you like to do?
        __________________________
        
        ${Magenta}1. Find Users
        2. See what ${user} can do
        3. View Files
        4. See Accesses
        ${Red}Q. Quit${Normal}
        
        """
        read -r selection

        #Find Users
        if [ $selection == "1" ];
        then
                #check to see if root already
                if ([ -f /usr/bin/id ] && [ "$(/usr/bin/id -u)" -eq "0" ]) || [ "`whoami 2>/dev/null`" = "root" ];
                then
                        echo "You are already root"
                else
                        echo "You are not root. Searching for sudo users now..."
        
                        #search for sudo users and print any sudo users found
                        echo "Sudo Users:"
                        for user in $(cut -d: -f1 /etc/passwd); 
                        do [ $(id -u $user) = 0 ] && echo $user; 
                        done | grep -v root
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
                
        #See what user can do
        elif [ $selection == "2" ]; 
                 #check if sudo can be used as the current user without a password
                if [ 'echo "" | sudo -nS id"' && lse_sudo=true 2>/dev/null 1>/dev/null];
                then 
                        echo -en "Password not needed to run sudo with this user\n"
                else
                        echo -en "You must have a password to run sudo with current user\n"
                fi

                #check to see what all the user can run with sudo
                if [ sudo -l 2>/dev/null 1>/dev/null ];
                then
                        echo -en "Commands $whoami can run with sudo\n"
                        sudo -l 2>/dev/null
                else
                        echo -en "Not able to view which sudo commands can be run\n"
                fi


        elif [ $selection == "3" ];
                then
                        declare -a dirs=("/etc/group" "/etc/passwd" "/etc/hosts" "/etc/shadow")
                        for i in ${!dirs[@]};
                        do
                                if [ $test -r ${dirs[$i]} ];
                                then
                                        echo -en "${dirs[$i]}: YES\n"
                                else
                                        echo -en "${dirs[$i]}: NO\n"
                                fi
                        done
                        
        #See Accesses
        elif [ $selection == "4" ];
                #See if root is able to log in using SSH
                if [ grep -E "^[[:space:]]*PermitRootLogin " /etc/ssh/sshd_config | grep -E "(yes|without-password|prohibit-password)" 2>/dev/null 1>/dev/null ];
                then
                        echo "Root can log in using SSH"
                else
                        echo "Root is not able to log in using SSH"
                fi

                #See available shells
                shells=$(cat /etc/shells)
                echo "Available Shells:"
                echo $shells
           
        elif [ $selection == "Q" || $selection == "q" ];
        then
                echo "Quitting";
                break
        else
                echo "Not a valid choice"
        fi
done

#_________________________________________________________________
#                            TESTING
#_________________________________________________________________

