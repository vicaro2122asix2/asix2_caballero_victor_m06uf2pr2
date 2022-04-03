#!/bin/bash
#mltusr.sh
#Víctor Caballero Roca ASIX2


clear
if ! [ $(id -u) = 0 ];
then
	echo "Aquest script s'ha d'executar amb l'ordre sudo"
	exit 1
	else
	wget http://www.collados.org/asix2/m06/uf2/usuaris.ods
	if (( $? != 0 ))
		then
		echo "No s'ha descarregat res"
		exit 2
		else
		libreoffice --headless --convert-to csv usuaris.ods
		if (( $? != 0 ))
			then
			echo "La conversió ha fallat"
			exit 3
			else
			rm usuaris.ods
			cat usuaris.csv | cut -d "," -f 2 > usuaris2.csv
			rm usuaris.csv
			mv usuaris2.csv usuaris.csv
			uid=3001
			while read line
			do
				useradd $line -u $uid -g users
				let uid=uid+1
			done < usuaris.csv
			if (( $? != 0 ))
				then
				echo "Hi ha problemes per crear usuaris"
				exit 4
				else
				exit 0
				fi
			fi
		fi
	fi
