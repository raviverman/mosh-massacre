# Date: 25-09-2019
# Author: Ravi Verman
# Description: Kills disconnected mosh sessions

#!/bin/bash

user=`whoami`


Rst='\033[0m'
Cyan='\033[0;36m'
Grn='\033[0;32m'
Red='\033[0;31m'
Blue='\033[0;34m'
count=0

kill_session() {
   user_default=$1
   count=0
   if [ "$user_default" != "mosh" ]; then 
      echo -e "${Cyan}Killing disconnected mosh sessions under ${Red}$user_default${Rst}"
   else
      echo -e "${Cyan}Killing disconnected mosh sessions under ${Red}all ${Cyan}users${Rst}"
      read -p $'\e[31mReally? [Y/N] : \e[0m' confirm
      if [ "$confirm" == "Y" ] || [ "$confirm" == "y" ];
      then  
         : # keep on going
      else
         echo -e "${Red}Exiting..${Rst}"
         return
      fi
   fi
   listp=`who | grep $user_default | grep -oP "(?<=\(mosh \[).*(?=\])"`
   for pid in $listp 
   do
      echo -e "${Red}Killing : ${Grn}$pid${Rst}"
      `kill -9 $pid`
      if [[ $? -eq 0 ]]; then 
         count=$(( count+1 ))
      fi
   done
   echo -e "${Grn}Total $count session(s) killed${Rst}"
}


# process cmd line args
if [[ $# -eq 0 ]]; then
   kill_session $user
elif [ $1 == "-u" ]; then
   if [[ $# -lt 2 ]]; then
      echo -e "${Red}Error: Enter user name${Rst}"
   else
      kill_session $2
   fi
elif [ "$1" == "-a" ]; then
   kill_session "mosh"
elif [ "$1" == "-h" ]; then
   echo -e "${Grn}mosh-massacre ${Cyan}: Kills disconnected mosh sessions"
   echo -e "${Grn}Usage   ${Cyan}: mosh-massacre [ -a ] [ -u username ]"
   echo -e "${Grn}Default ${Cyan}: kills mosh sessions of current user"
   echo -e "${Grn}   -a   ${Cyan}: kills mosh sessions of all users"
   echo -e "${Grn} -u lol ${Cyan}: kills mosh sessions of user 'lol'${Rst}"
fi
