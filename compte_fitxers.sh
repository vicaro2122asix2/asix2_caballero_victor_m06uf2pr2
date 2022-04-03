#!/bin/bash
#compte_fitxers.sh
#Víctor Caballero Roca

clear
    
function compte{
local fitxer
local ncompt
local proba
	
ncompt=0
	
	for fitxer in $1/*
	do
		if [[ -s $fitxer ]] &&  [[ -x $fitxer ]]  
		then                                      
			(( ncompt++ ))	
		fi
		done
	
	echo "Nº d'arxius al directori: "$ncompt
	
	return 0
}	

echo -n "Directori: "

read nom
compte $nom

exit 0
