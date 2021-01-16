#!/usr/bin/bash
#Author: Christian Ekeigwe
#Description: This is a script that checks if a host is available based on ping tests to the IP address of the host.
#Last Revision Date: 1/7/2021

IP_ADDR=$1 #Variable holds IP address
U_INPUT="temp.txt" #Variable holds the temporary unprocessed IP address text file
PING_T=$3 #Variable holds the return value of the "ping" command
RANGE=$4

ONE=$5 #Variable holds the first octet
TWO=$6 #Variable holds the second octet
THREE=$7 #Variable holds the third octet
FOUR=$8 #Variable holds the fourth octet

OCT_IP=$9 #Variable holds the 4 octets arranged as an IP address

n=1 #Counter for the while loop

if [ -f "$U_INPUT" ]; then
    rm -rf $U_INPUT #Used to cleanup the temporary file
fi


echo "Which octet of the IP address do you want to apply the range to? (Default: 4th octet)"

select octet in first second third fourth
do

	case $octet in 
	
	#First Octet
	
		first)
			echo Please enter the starting IP Address
			read -r IP_ADDR
			
			
			if [[ -z $IP_ADDR ]]; then
				echo -e "\e[91mERROR: Invalid IP Address\e[0m";
				echo -e "\e[91mValid IP Address format: XXX.XXX.XXX.XXX\e[0m";
				echo -e "\e[1m Press [ENTER] to continue\e[0m"

			else
			
				echo Please enter the range or number of hosts
				read -r RANGE
				
				
				ONE=$(echo "$IP_ADDR" | cut -d '.' -f 1)
				
				
				if [[ $((ONE+RANGE)) -gt 255 ]]; then
					
					echo -e "\e[91mERROR: Illegal IP Address Range\e[0m";
					echo -e "The range should not be more than the octet value + 254"
					echo -e "\e[1m Press [ENTER] to continue\e[0m";
					
				elif [[ $((ONE+RANGE)) -le 255 ]]; then
				
					printf "\n"
					echo -e "\e[1mThis may take some time\e[0m";
					for i in $(seq $((ONE-1)) $((ONE+(RANGE-2))))
					do
						
						ONE=$(echo "$IP_ADDR" | cut -d '.' -f 1)
						TWO=$(echo "$IP_ADDR" | cut -d '.' -f 2)
						THREE=$(echo "$IP_ADDR" | cut -d '.' -f 3)
						FOUR=$(echo "$IP_ADDR" | cut -d '.' -f 4)
						
						OCT_IP="$ONE.$TWO.$THREE.$FOUR"	
						
						i=$((i+1))
						
						OCT_IP="$i.$TWO.$THREE.$FOUR" 
						
						echo "$OCT_IP" >> "$U_INPUT"
						
						#echo $OCT_IP #Leave for Debugging
						
					done
					printf "\n"
					while read line;
					do 
						#ping $line #Leave for Debugging
						
						ping -w5 $line >/dev/null 2>&1
						PING_T=$(echo $?)
						if [ $PING_T -eq 0 ]; then
							echo -e "$line: \e[32mThe host is available\e[0m";
						
						elif [ $PING_T -ge 1 ]; then
							echo -e "$line: \e[91mHost is unavailable\e[0m";

						fi
						
					
					done < $U_INPUT
					
					echo -e "\e[1m Press [ENTER] to continue\e[0m";
					
				fi
				
			fi
		;;
		
		#Second Octet
	
		second)
			echo Please enter the starting IP Address
			read -r IP_ADDR
				
			if [[ -z $IP_ADDR ]]; then
				echo -e "\e[91mERROR: Invalid IP Address\e[0m";
				echo -e "\e[91mValid IP Address format: XXX.XXX.XXX.XXX\e[0m";
				echo -e "\e[1m Press [ENTER] to continue\e[0m";
			else
				echo Please enter the range or number of hosts
				read -r RANGE
				
				TWO=$(echo "$IP_ADDR" | cut -d '.' -f 2)
				
				if [[ $((TWO+RANGE)) -gt 255 ]]; then
					
					echo -e "\e[91mERROR: Illegal IP Address Range\e[0m";
					echo -e "The range should not be more than the octet value + 254"
					echo -e "\e[1m Press [ENTER] to continue\e[0m";
					
				elif [[ $((TWO+RANGE)) -le 255 ]]; then
				
					printf "\n"
					echo -e "\e[1mThis may take some time\e[0m";
					for i in $(seq $((TWO-1)) $((TWO+(RANGE-2))))
					do
						ONE=$(echo "$IP_ADDR" | cut -d '.' -f 1)
						TWO=$(echo "$IP_ADDR" | cut -d '.' -f 2)
						THREE=$(echo "$IP_ADDR" | cut -d '.' -f 3)
						FOUR=$(echo "$IP_ADDR" | cut -d '.' -f 4)
						
						OCT_IP="$ONE.$TWO.$THREE.$FOUR"	
						
						i=$((i+1))
						
						OCT_IP="$ONE.$i.$THREE.$FOUR" 
						
						echo "$OCT_IP" >> "$U_INPUT"
						
						#echo $OCT_IP #Leave for Debugging
					
					done
					printf "\n"
					while read line;
					do 
						#ping $line #Leave for Debugging
						
						ping -w5 $line >/dev/null 2>&1
						PING_T=$(echo $?)
						if [ $PING_T -eq 0 ]; then
							echo -e "$line: \e[32mThe host is available\e[0m";
						
						elif [ $PING_T -ge 1 ]; then
							echo -e "$line: \e[91mHost is unavailable\e[0m";

						fi
						
					done < $U_INPUT
					
					echo -e "\e[1m Press [ENTER] to continue\e[0m";
				fi
				
			fi
		;;	
		
		#Third Octet
	
		third)
			echo Please enter the starting IP Address
			read -r IP_ADDR

			if [[ -z $IP_ADDR ]]; then
				echo -e "\e[91mERROR: Invalid IP Address\e[0m";
				echo -e "\e[91mValid IP Address format: XXX.XXX.XXX.XXX\e[0m";
				echo -e "\e[1m Press [ENTER] to continue\e[0m";
			else
				echo Please enter the range or number of hosts
				read -r RANGE
				
				THREE=$(echo "$IP_ADDR" | cut -d '.' -f 3)
				
				
				if [[ $((THREE+RANGE)) -gt 255 ]]; then
					
					echo -e "\e[91mERROR: Illegal IP Address Range\e[0m";
					echo -e "The range should not be more than the octet value + 254"
					echo -e "\e[1m Press [ENTER] to continue\e[0m";
					
				elif [[ $((THREE+RANGE)) -le 255 ]]; then
				
					printf "\n"
					echo -e "\e[1mThis may take some time\e[0m";
					for i in $(seq $((THREE-1)) $((THREE+(RANGE-2))))
					do
						ONE=$(echo "$IP_ADDR" | cut -d '.' -f 1)
						TWO=$(echo "$IP_ADDR" | cut -d '.' -f 2)
						THREE=$(echo "$IP_ADDR" | cut -d '.' -f 3)
						FOUR=$(echo "$IP_ADDR" | cut -d '.' -f 4)
						
						OCT_IP="$ONE.$TWO.$THREE.$FOUR"	
						
						i=$((i+1))
						
						OCT_IP="$ONE.$TWO.$i.$FOUR" 
						
						echo "$OCT_IP" >> "$U_INPUT"
						
						#echo $OCT_IP #Leave for Debugging	
					
					done
					printf "\n"
					while read line;
					do 
						#ping $line #Leave for Debugging
						
						ping -w5 $line >/dev/null 2>&1
						PING_T=$(echo $?)
						if [ $PING_T -eq 0 ]; then
							echo -e "$line: \e[32mThe host is available\e[0m";
						
						elif [ $PING_T -ge 1 ]; then
							echo -e "$line: \e[91mHost is unavailable\e[0m";

						fi
						
					done < $U_INPUT
					
					echo -e "\e[1m Press [ENTER] to continue\e[0m";
				fi	
			fi
		;;	
		
		
		#Fourth Octet
		
		fourth)
			echo Please enter the starting IP Address
			read -r IP_ADDR


			if [[ -z $IP_ADDR ]]; then
				echo -e "\e[91mERROR: Invalid IP Address\e[0m";
				echo -e "\e[91mValid IP Address format: XXX.XXX.XXX.XXX\e[0m";
				echo -e "\e[1m Press [ENTER] to continue\e[0m";

			else
				echo Please enter the range or number of hosts
				read -r RANGE
				
				FOUR=$(echo "$IP_ADDR" | cut -d '.' -f 4)
				
				
				if [[ $((FOUR+RANGE)) -gt 255 ]]; then
					
					echo -e "\e[91mERROR: Illegal IP Address Range\e[0m";
					echo -e "The range should not be more than the octet value + 254"
					echo -e "\e[1m Press [ENTER] to continue\e[0m";
					
				elif [[ $((FOUR+RANGE)) -le 255 ]]; then
				
					printf "\n"
					echo -e "\e[1mThis may take some time\e[0m";
					for i in $(seq $((FOUR-1)) $((FOUR+(RANGE-2))))
					do
						
						ONE=$(echo "$IP_ADDR" | cut -d '.' -f 1)
						TWO=$(echo "$IP_ADDR" | cut -d '.' -f 2)
						THREE=$(echo "$IP_ADDR" | cut -d '.' -f 3)
						FOUR=$(echo "$IP_ADDR" | cut -d '.' -f 4)
						
						OCT_IP="$ONE.$TWO.$THREE.$FOUR"	
						
						i=$((i+1))
						
						OCT_IP="$ONE.$TWO.$THREE.$i" 
						
						echo "$OCT_IP" >> "$U_INPUT"
						
						#echo $OCT_IP #Debugging			
					done
					printf "\n"
					while read line;
					do 
						#ping $line #Leave for Debugging
						
						ping -w5 $line >/dev/null 2>&1
						PING_T=$(echo $?)
						if [ $PING_T -eq 0 ]; then
							echo -e "$line: \e[32mThe host is available\e[0m";
						
						elif [ $PING_T -ge 1 ]; then
							echo -e "$line: \e[91mHost is unavailable\e[0m";

						fi
						
					done < $U_INPUT
					
					echo -e "\e[1m Press [ENTER] to continue\e[0m";
				fi	
			fi
		;;
		
		#Default selection when wrong choice is made
		
		*)
			echo Please enter the starting IP Address
			read -r IP_ADDR


			if [[ -z $IP_ADDR ]]; then
				echo -e "\e[91mERROR: Invalid IP Address\e[0m";
				echo -e "\e[91mValid IP Address format: XXX.XXX.XXX.XXX\e[0m";
				echo -e "\e[1m Press [ENTER] to continue\e[0m";

			else
				echo Please enter the range or number of hosts
				read -r RANGE
				
				FOUR=$(echo "$IP_ADDR" | cut -d '.' -f 4)
				
					
				if [[ $((FOUR+RANGE)) -gt 255 ]]; then
					
					echo -e "\e[91mERROR: Illegal IP Address Range\e[0m";
					echo -e "The range should not be more than the octet value + 254"
					echo -e "\e[1m Press [ENTER] to continue\e[0m";
					
				elif [[ $((FOUR+RANGE)) -le 255 ]]; then
			
					printf "\n"
					echo -e "\e[1mThis may take some time\e[0m";
					for i in $(seq $((FOUR-1)) $((FOUR+(RANGE-2))))
					do
						
						ONE=$(echo "$IP_ADDR" | cut -d '.' -f 1)
						TWO=$(echo "$IP_ADDR" | cut -d '.' -f 2)
						THREE=$(echo "$IP_ADDR" | cut -d '.' -f 3)
						FOUR=$(echo "$IP_ADDR" | cut -d '.' -f 4)
						
						OCT_IP="$ONE.$TWO.$THREE.$FOUR"	
						
						i=$((i+1))
						
						OCT_IP="$ONE.$TWO.$THREE.$i" 
						
						echo "$OCT_IP" >> "$U_INPUT"
						
						#echo $OCT_IP #Debugging			
					done
					printf "\n"
					while read line;
					do 
						#ping $line #Leave for Debugging
						
						ping -w5 $line >/dev/null 2>&1
						PING_T=$(echo $?)
						if [ $PING_T -eq 0 ]; then
							echo -e "$line: \e[32mThe host is available\e[0m";
						
						elif [ $PING_T -ge 1 ]; then
							echo -e "$line: \e[91mHost is unavailable\e[0m";

						fi
						
					done < $U_INPUT
					
					echo -e "\e[1m Press [ENTER] to continue\e[0m";
				fi	
			fi	
		;;	
	esac
	
	rm -rf $U_INPUT

done
