#!/bin/sh

#TellTale Linux Enumeration Script

#####################################################
#                     COLORS
#####################################################

Color=$(printf '\033')
Magenta="${Color}[1;95m"
LGray="${Color}[1;37m"
DGray="${Color}[1;90m"
Blue="${Color}[1;34m"
Cyan="${Color}[1;96m"
Red="${Color}[1;31m"
Normal="${Color}[0m"
Green="${Color}[1;32m"
UMagenta="${Color}[1;95m${Color}[5m"
UDMagenta="${Color}[1;95m${Color}[4m"

#####################################################
#                   DISPLAY ART
#####################################################

printf """
${LGray}/-------------------------------------------------------------------------\\
|                         ${UMagenta}♥${Normal}${Magenta}  TellTale by SYN-3r  ${UMagenta}♥${Normal}${LGray}                        |
|                       ${Magenta}A Linux Enumeration Script${LGray}                        |
|-------------------------------------------------------------------------|
|${Blue}:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${LGray}|
|${Blue}:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${LGray}|
|${Blue}:::::::::::::::::::::           :::::::::           :::::::::::::::::::::${LGray}|
|${Blue}::::::::::::::::::                :::::                ::::::::::::::::::${LGray}|
|${Blue}::::::::::::::::       ${UMagenta}*********    ${Normal}${Blue}:${UMagenta}    *********${Normal}${Blue}       ::::::::::::::::${LGray}|
|${Blue}::::::::::::::      ${UMagenta}*****     *****   *****     *****${Normal}${Blue}      ::::::::::::::${LGray}|
|${Blue}:::::::::::::     ${UMagenta}****           *******           ****${Normal}${Blue}     :::::::::::::${LGray}|
|${Blue}::::::::::::     ${UMagenta}****              ***              ****${Normal}${Blue}     ::::::::::::${LGray}|
|${Blue}::::::::::::     ${UMagenta}****               *               ****${Normal}${Blue}     ::::::::::::${LGray}|
|${Blue}:::::::::::::     ${UMagenta}****                             ****${Normal}${Blue}     :::::::::::::${LGray}|
|${Blue}::::::::::::::     ${UMagenta}****                           ****${Normal}${Blue}     ::::::::::::::${LGray}|
|${Blue}::::::::::::::::     ${UMagenta}****                       ****${Normal}${Blue}     ::::::::::::::::${LGray}|
|${Blue}::::::::::::::::::     ${UMagenta}****                   ****${Normal}${Blue}     ::::::::::::::::::${LGray}|
|${Blue}::::::::::::::::::::     ${UMagenta}****               ****${Normal}${Blue}     ::::::::::::::::::::${LGray}|
|${Blue}:::::::::::::::::::::::     ${UMagenta}****         ****${Normal}${Blue}     :::::::::::::::::::::::${LGray}|
|${Blue}::::::::::::::::::::::::::     ${UMagenta}****   ****${Normal}${Blue}     ::::::::::::::::::::::::::${LGray}|
|${Blue}:::::::::::::::::::::::::::::     ${UMagenta}*****${Normal}${Blue}     :::::::::::::::::::::::::::::${LGray}|
|${Blue}::::::::::::::::::::::::::::::::    ${UMagenta}*${Normal}${Blue}    ::::::::::::::::::::::::::::::::${LGray}|
|${Blue}::::::::::::::::::::::::::::::::::     ::::::::::::::::::::::::::::::::::${LGray}|
|${Blue}:::::::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::${LGray}|
|${Blue}:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${LGray}|
\-------------------------------------------------------------------------/${Normal}

"""

#####################################################
#             MAIN START UP / MENU
#####################################################

#View which user you are
user=$(whoami)
printf """
\n 
${Magenta} You are currently: ${Red} $user ${Normal} \n\n\n
"""

#MENU display start
while true; 
do
printf """
          ${Blue}MAIN MENU
  What would you like to do?
  __________________________
        
  ${Magenta}1. Get System and Security Information
  2. Find Users
  3. See what ${user} can do
  4. Find Files
  5. View cron
  ${Red}Q. Quit${Normal}
        
"""
          read -r selection
          
#####################################################
#                    SELECTION 1
#         GET SYSTEM AN SECURITY INFORMATION
#####################################################

          if [ $selection == "1" ];
          then
                    printf """
  ${Blue}SYSTEM AND SECURITY INFORMATION \n\n\n${Normal}"""
  
                    #View what users are on the machine
                    loggedon=$(w)
                    #View OS info
                    OSinfo=$(uname -a 2>/dev/null)
                    #View proc version
                    OSinfo2=$(cat /proc/version 2>/dev/null)
                    #View date
                    d=$(date 2>/dev/null)
                    #View CPU info
                    cpuinfo=$(lscpu 2>/dev/null)
                    
                    printf """
  ${Magenta}Users Currently on the machine:\n\n ${Normal} $loggedon \n
  ${Magenta}Date: ${Normal} $d \n
  ${Magenta}Current Path: ${Normal} $PATH \n
  ${Magenta}OS information:${Normal} \n $OSinfo \n\n $OSinfo2 \n
  ${Magenta}CPU Information:${Normal} \n $cpuinfo \n
  ${Magenta}Security in place:${Normal} \n """
          
                    #attempt to find SELinux
                    if [ sestatus 2>/dev/null ];
                    then
                              printf """
  SELinux: ${Green}YES${Normal} """
                    else
                              printf """
  SELinux: ${Red}NO${Normal} """
                    fi
                    
                    #attempt to find Execshield
                    if [ grep "exec-shield" /etc/sysctl.conf ];
                    then
                              printf """
  Execshield: ${Green}YES${Normal} """
                    else
                              printf """
  Execshield: ${Red}NO${Normal} """
                    fi
                    
                    #attempt to find ALR
                    if [ cat /proc/sys/kernel/randomize_va_space ];
                    then
                              printf """
  ASLR: ${Green}YES${Normal} """
                    else
                              printf """
  ASLR: ${Red}NO${Normal} """
                    fi

                    #attempt to find Grsecurity
                    if [ uname -r | grep "\-grsec" >/dev/null 2>&1 ] || [ grep "grsecurity" /etc/sysctl.conf >/dev/null 2>&1 ];
                    then
                              printf """
  Grsecurity: ${Green}YES${Normal} """
                    else
                              printf """
  Grsecurity: ${Red}NO${Normal} """
                    fi
                    
                    #attempt to find PaX
                    if [ which paxctl-ng paxctl >/dev/null 2>&1 ];
                    then
                              printf """
  PaX: ${Green}YES${Normal} """
                    else
                              printf """
  PaX: ${Red}NO${Normal} """
                    fi

                    #attempt to find AppArmor
                    if [ `which aa-status 2>/dev/null` ];
                    then
                              status=$apparmor_status
                              printf """
  AppArmor: ${Green}YES${Normal} \n\t\t Status: $status """
                              
                    else
                              printf """
  AppArmor: ${Red}NO${Normal} """
                    fi

                    

#####################################################
#                    SELECTION 2
#                    FIND USERS
#####################################################

          if [ $selection == "2" ];
          then
                    printf """
  ${Blue}FIND USERS \n\n\n ${Normal}"""
  
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

#####################################################
#                    SELECTION 3
#            SEE WHAT CURRENT USER CAN DO
#####################################################

          elif [ $selection == "3" ]; 
          then
                    printf """
  ${Blue}SEE WHAT CURRENT USER CAN DO \n\n\n${Normal}"""
  
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
                    
#####################################################
#                    SELECTION 4
#                     FIND FILES
#####################################################

          elif [ $selection == "4" ];
          then
                    printf """
  ${Blue}FIND FILES \n\n\n ${Normal}"""
                    while true;
                    do
                              printf """
  ${Blue}What files would you like to find? \n
  ${Magenta}1. /etc files
  2. All text files
  3. All pdfs
  4. All images${Normal}
                              """
                              read -r files
                              
                              if [ $files == "1" ];
                              then
  
                                        declare -a dirs=("/etc/group" "/etc/passwd" "/etc/hosts" "/etc/shadow" "/etc/shells")
                                        declare -a gooddirs=()
                                        c=1
                                        count="$c."
                                        echo -en "Are the contents of the following /etc files currently accessible? \n"
                                        for i in ${!dirs[@]};
                                        do
                                                  if [ $test -r ${dirs[$i]} ];
                                                  then
                                                            printf """
  ${dirs[$i]}: ${Green}YES${Normal}  """
                                                            gooddirs+=("${dirs[$i]}")
                                                  else
                                                            printf """
  ${dirs[$i]}: ${Red}NO${Normal}  """
                                                  fi
                                        done
                                        echo -en "\n"
                                        while true;
                                        do
                                                  c=1
                                                  count="$c."
                                                  printf """
  ${Blue}Would you like to view contents? ${Normal}\n """
                                                  read -r options
                                                  if [ $options == "Y" ] || [ $options == "y" ];
                                                  then
                                                  while true;
                                                  do
                                                            printf """
  ${Blue}Which would you like to display? """
                                                            for p in ${!gooddirs[@]};
                                                            do
                                                                      printf """
  ${Magenta}$count ${gooddirs[$p]} """
                                                                      c=$((c + 1))
                                                                      count="$c."
                                                            done
                                                            printf """
  ${Magenta}A. All
  ${Red}Q. Quit${Normal} \n """
                                                            read -r this
                                                            if [ $this == "1" ];
                                                            then
                                                                    cat ${gooddirs[0]} 2>/dev/null
                                                                    break
                                                            elif [ $this == "2" ];
                                                            then
                                                                    cat ${gooddirs[1]} 2>/dev/null
                                                                    break
                                                            elif [ $this == "3" ];
                                                            then
                                                                    cat ${gooddirs[2]} 2>/dev/null
                                                                    break
                                                            elif [ $this == "4" ];
                                                            then
                                                                    cat ${gooddirs[3]} 2>/dev/null
                                                                    break
                                                            elif [ $this == "5" ];
                                                            then
                                                                    cat ${gooddirs[4]} 2>/dev/null
                                                                    break
                                                            elif [ $this == "6" ];
                                                            then
                                                                    cat ${gooddirs[5]} 2>/dev/null
                                                                    break
                                                            elif [ $this == "A" ] | [ $this == "a" ];
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
                                                                    printf """
  ${Red}Please enter a valid option \n ${Normal} """
                                                                    break
                                                            fi
                                                    done
                                          elif [ $options == "N" ] || [ $options == "n" ];
                                          then
                                                  printf """ 
  ${Blue}Will not display contents \n ${Normal} """
                                                  break
                                          else
                                                  printf """
 ${Red}Pleas eneter a valid option ${Normal} \n """
                                          fi
                                  done
                              elif [ $files == "2" ];
                              then
                              #find all text files
                              find -i -name <file> -type *.txt
                              break
          
                              elif [ $files == "3" ];
                              then
                              #find all pdf files
                              find -i -name <file> -type *.pdf
                              break

                              elif [ $files == "4" ];
                              then
                              #find all image files
                              find -i -name <file> -type *.png
                              find -i -name <file> -type *.img
                              break

                              elif [ $files == "Q" ] | [ $files == "q" ];
                              then
                                        prinf """
  ${Red}Quitting... ${Normal} \n """
                              break

                              else
                              printf """
  ${Red}Please enter a valid option \n ${Normal} """
                              break
                              fi
                    done

          
                         
#####################################################
#                    SELECTION 5
#                    SEE ACCESSES
#####################################################                  
        #See Accesses
        elif [ $selection == "5" ];
        then
                  printf """
  ${Blue}SEE ACCESSES \n\n\n ${Normal}"""
  
                  #do this

        
#####################################################
#                    SELECTION Q
#                        QUIT
#####################################################
  
        elif [ $selection == "Q" ] || [ $selection == "q" ];
        then
                  printf """
  ${Red}QUITTING... \n\n\n ${Normal}"""
                  sleep 3s
                  break

#####################################################
#               CATCH ALL FOR SELECTION
##################################################### 
        else
                printf """
  ${Red}Please enter a valid choice \n\n\n ${Normal}"""
                sleep 3s
        
        fi
done

#####################################################
#                     TESTING
#####################################################

