#!/usr/bin/bash
#Author: Christian Ekeigwe
#Description: This is a script that checks if a host is available based on ping tests to the IP address of the host.
#Last Revision Date: 1/1/2021

IP_ADDR=$1 #Variable holds IP address
U_INPUT="ip_addr_input.txt" #Variable holds the temporary unprocessed IP address text file
DELIM_CNT=$3 #Variable holds the value for the total number of delimiters (".") in the IP address string
PING_T=$4 #Variable holds the return value of the "ping" command

if [ -f "$U_INPUT" ]; then
    rm -rf $U_INPUT #Used to cleanup the temporary file
fi

echo Please enter an IP Address
read -r IP_ADDR

if [[ -z $IP_ADDR ]]; then
	echo ERROR: Invalid IP Address
	echo Valid IP Address format: XXX.XXX.XXX.XXX

else
	echo "$IP_ADDR" >> "$U_INPUT"


	DELIM_CNT=$(tr -cd '.' < $U_INPUT | awk '{print length}' )
	printf "\n"

	if [ $DELIM_CNT -eq 3 ]; then

		ping -w5 $IP_ADDR >/dev/null 2>&1
		PING_T=$(echo $?)
		if [ $PING_T -eq 0 ]; then
			echo The host is available
		
		elif [ $PING_T -ge 1 ]; then
			echo Host is unavailable
			exit

		fi

	elif [ $DELIM_CNT -gt 3 ]; then
		echo ERROR: Invalid IP Address
		echo Valid IP Address format: XXX.XXX.XXX.XXX
		rm -rf $U_INPUT
		
	elif [ $DELIM_CNT -lt 3 ]; then
		echo ERROR: Invalid IP Address
		echo Valid IP Address format: XXX.XXX.XXX.XXX
		rm -rf $U_INPUT
		
	fi

	rm -rf $U_INPUT
	
fi


