#!/bin/bash
#Víctor Caballero Roca
#generaPasswd.sh


clear

while [[ true ]]
	do
	echo "Quants usuaris?"
	read Nusuaris
	if ((Nusuaris >=1 && Nusuaris <=100))
	then
		while [[ true ]]
		do
		echo "Número d'UID (mínim 5000)"
		read uidNumber
		if ((uidNumber >= 5000))
		then
			for ((comptador=0; comptador<Nusuaris; comptador++ ))
			do
			PASSWORD=$(echo $RANDOM$(date +%N%s) | md5sum | cut -c 2-9)
			echo "usr$uidNumber:$PASSWORD" | chpasswd
			echo "usr$uidNumber:$PASSWORD" >> ctsUsuaris.txt
			echo "__________" >> ctsUsuaris.txt
			((uidNumber++))
			done
			break;
			fi	
	done
	break;
	fi
	
done
exit 0
