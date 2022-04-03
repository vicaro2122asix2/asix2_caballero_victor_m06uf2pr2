#!/bin/bash
#dhcpd.sh
#Víctor Caballero Roca

TIMESTAMP=$(date +"%Y%m%d%H%M")
DHCPDIR=/etc/dhcp

function ROOT(){
    if [ "$EUID" -ne 0 ]
        then echo "Aquest script ha de ser executat com a root"
        exit
    fi
}


function COPY(){
    cp $DHCPDIR/dhcpd.conf $DHCPDIR/dhcpd.conf.$TIMESTAMP > /dev/null 2>&1 && echo "Copia de seguretat de dhcpd.conf [OK]" || echo "Copia de seguretat de dhcpd.conf [ERROR]"
    echo -n "Prem enter per continuar... "
    read pause
    
}
function USERINPUT(){
    clear
    echo -n "Nom del domini: "
    read NOMDOMINI
    echo -n "IP del DNS: "
    read DNSSERVER
    echo -n "Introdueix la porta d'enllaç: "
    read GATEWAY
    echo -n "Direcció broadcast: "
    read BROADCAST
    echo -n "Leasing per defecte: "
    read DEFLEASING
    echo -n "Leasing màxim: "
    read MAXLEASING
    echo -n "IP de la subxarxa: "
    read SUBNETIP
    echo -n "Màscara de la subxarxa: "
    read SUBNETMASK
    echo -n "Primera IP del rang: "
    read FIRSTIP
    echo -n "Última IP del rang: "
    read LASTIP
}


function CHECK(){
    clear
    echo "Informació errònia, revisa la configuració."
    echo "El nom del domini introduit es: $NOMDOMINI"
    echo "La direcció IP del servidor DNS es: $DNSSERVER"
    echo "La Gateway per defecte introduida es: $GATEWAY"
    echo "La direcció bradcast introduida es: $BROADCAST"
    echo "El valor del temps de leasing per defecte introduit es: $DEFLEASING"
    echo "El valor del temps de leasing màxim introduit es: $MAXLEASING"
    echo "La IP de subxarxa introduida es: $SUBNETIP"
    echo "La màscara de subxarxa introduida es: $SUBNETMASK"
    echo "La primera direccio IP del marge es: $FIRSTIP"
    echo "La darrera direccio IP del marge es: $LASTIP"
    echo -n "Vols continuar? [Y/n]: "
    read OPTION

    if [[ $OPTION == "N" || $OPTION == "n" ]]; then
        exit;
    else
        clear
    fi
}

function CREATE_FILE(){
    echo -n "
ddns-update-style none;

subnet $SUBNETIP netmask $SUBNETMASK{
    range $FIRSTIP $LASTIP;
    option domain-name-servers $DNSSERVER;
    option domain-name \"$NOMDOMINI\";
    option subnet-mask $SUBNETMASK;
    option routers $GATEWAY;
    option broadcast-address $BROADCAST;
    default-lease-time $DEFLEASING;
    max-lease-time $MAXLEASING;
}
" > $DHCPDIR/dhcpd.conf && echo "S'ha generat el fitxer satisfactòriament" || echo "S'ha generat el fitxer amb errors"  
}


function RESTART_DHCP(){
    systemctl restart isc-dhcp-server.service
    if [[ "$?" == 0 ]];then
    echo "S'ha reiniciat el servei DHCP satisfactòriament"
    else
    echo "Error en reiniciar el DHCP"
    fi
}
    
    ROOT
    COPY
    USERINPUT
    CHECK
    CREATE_FILE
    RESTART_DHCP
