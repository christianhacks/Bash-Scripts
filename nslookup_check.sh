#!/usr/bin/bash
#Author: Christian Ekeigwe
#Description: 
#Last Revision Date: 

HOSTNAME=$1
NS_CHECK=$(nslookup $HOSTNAME) #Variable checks that runs the nslookup command to resolve the IP address or hostname
U_INPUT="res_add.txt" #Variable holds the temporary unprocessed resolved IP address text file
IP_ADDR=$3 #Variable holds IP address
DELIM_CNT=$4 #Variable holds the value for the total number of delimiters (".") in the IP address string
PING_T=$6 #Variable holds the return value of the "ping" command

if [ -f "$U_INPUT" ]; then
    rm -rf $U_INPUT #Used to cleanup the temporary file
fi

echo "$NS_CHECK" >> "$U_INPUT"

IP_ADDR=$(awk '{if(NR==6) print $0}' $U_INPUT | cut -d ':' -f 2) #extracts the IP address

ping -w5 $IP_ADDR >/dev/null 2>&1

printf "\n"

PING_T=$(echo $?)
if [ $PING_T -eq 0 ]; then
	echo -e "$IP_ADDR: \e[32mThe host is available\e[0m";

elif [ $PING_T -ge 1 ]; then
	echo -e "$IP_ADDR: \e[91mHost is unavailable\e[0m";

fi

rm -rf $U_INPUT
	

