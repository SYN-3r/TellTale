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
\-------------------------------------------------------------------------/${Normal}

"""
#Main Code
#_________________________________________________________________
#                             USERS
#_________________________________________________________________

#basic start up info for log on
#View what users are on the machine
loggedon=$(w)
printf """
${Magenta} Users Currently on the machine:\n\n ${Normal} $loggedon \n
"""
#View which user you are
user=$(whoami)
printf """
\n 
${Magenta} You are currently: ${Red} $user ${Normal} \n
"""

#MENU display start
while true; 
do
printf """
          ${Blue}MAIN MENU
  What would you like to do?
  __________________________
        
  ${Magenta}1. Find Users
  2. See what ${user} can do
  3. See what root can do
  4. View contents of /etc files
  5. View cron abilities
  6. See Accesses
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

        #view contents of /etc files
        elif [ $selection == "4" ];
                then
                        declare -a dirs=("/etc/group" "/etc/passwd" "/etc/hosts" "/etc/shadow" "/etc/shells")
                        declare -a gooddirs=()
                        for i in ${!dirs[@]};
                        do
                                if [ $test -r ${dirs[$i]} ];
                                then
                                        echo -en "${dirs[$i]}: YES\n"
                                        gooddirs+=("${dirs[$i]}")
                                else
                                        echo -en "${dirs[$i]}: NO\n"
                                fi
                        done
                        while true;
                        do
                                echo -en "Would you like to view contents?\n"
                                read -r options
                                if [ $options == "Y" ] || [ $options == "y" ];
                                then
                                while true;
                                do
                                        printf """
${Blue}Which would you like to display?
${Magenta}1. /etc/group
2. /etc/passwd
3. /etc/hosts
4. /etc/shadow
5. /etc/shells
6. All
${Red}Q. Quit${Normal}
                                        """
                                        read -r this
                                        if [ $this == "1" ];
                                        then
                                                cat /etc/group
                                                break
                                        elif [ $this == "2" ];
                                        then
                                                cat /etc/passwd
                                                break
                                        elif [ $this == "3" ];
                                        then
                                                cat /etc/hosts
                                                break
                                        elif [ $this == "4" ];
                                        then
                                                cat /etc/shadow
                                                break
                                        elif [ $this == "5" ];
                                        then
                                                cat /etc/shells
                                                break
                                        elif [ $this == "6" ];
                                        then
                                                echo -en "Displaying all contents now...\n\n\n"
                                                for a in ${!gooddirs[@]};
                                                do
                                                        cat ${gooddirs[$a]}
                                                        echo -en "\n"
                                                done
                                                break
                                        elif [ $this == "Q" ] || [ $this == "q" ];
                                        then
                                                break
                                        else
                                                echo "Please enter a valid option"
                                        fi
                                done
                                elif [ $options == "N" ] || [ $options == "n" ];
                                then
                                        echo "Will not display contents"
                                        break
                                else
                                        echo "Please enter a valid option"
                                fi
                        done
                         
                        
        #See Accesses
        elif [ $selection == "6" ];
        then       
                
        #Quit   
        elif [ $selection == "Q" ] || [ $selection == "q" ];
        then
                echo "Quitting";
                break
        else
                echo "Please enter a valid choice"
        fi
done

#_________________________________________________________________
#                            TESTING
#_________________________________________________________________



