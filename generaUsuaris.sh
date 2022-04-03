#!/bin/bash
#Víctor Caballero Roca
#generaUsuaris.sh

clear

if [[ -e nousUsuaris.ldif ]]
then
rm -R nousUsuaris.ldif
fi

while [[ true ]]
	do
    echo "Quants usuaris vols crear? [entre 1-100] "
    read Nusuaris
    if ((Nusuaris >=1 && Nusuaris <= 100))
    then
        while [[ true ]]
        do
        echo "Primer UID (a partir de 5000): "
        read uidNumber
        if ((uidNumber >= 5000))
			then
            for (( contador=0; contador<Nusuaris; contador++ ))
            do
			echo "dn: uid=usr$uidNumber,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" >> nousUsuaris.ldif
			echo "objectClass: top" >> nousUsuaris.ldif
			echo "objectClass: posixAccount" >> nousUsuaris.ldif
			echo "objectClass: shadowAccount" >> nousUsuaris.ldif
			echo "objectClass: person" >> nousUsuaris.ldif
			echo "uid:usr$uidNumber" >> nousUsuaris.ldif
			echo "gidNumber: 100" >> nousUsuaris.ldif
			echo "loginShell: /bin/bash" >> nousUsuaris.ldif
			echo "cn: usr$uidNumber usr$uidNumber" >> nousUsuaris.ldif
			echo "sn: usr$uidNumber" >> nousUsuaris.ldif
			echo "homeDirectory: /home/usr$uidNumber" >> nousUsuaris.ldif
			echo "" >> nousUsuaris.ldif
			echo "" >> nousUsuaris.ldif
			((uidNumber++))
			done
			
			ldapadd -x -W -D "cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" -f nousUsuaris.ldif
			
			break;
			fi
			done
		break;        
	fi
    
done

exit 0
