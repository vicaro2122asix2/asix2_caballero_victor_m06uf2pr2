#!/bin/bash
#vgrt.sh
#Víctor Caballero Roca ASIX2

	echo "Vagrant.configure('"'2'"') do |config|" > Vagrantfile

	echo -n "Quina versió vols?(Debian9/Debian10/Debian11) "
	read versiobox
	echo  "config.vm.box = '"$versiobox"' " >> Vagrantfile


	echo -n "Nom de la maquina virtual: "
	read nommaquina
	echo "config.vm.hostname = '"$nommaquina"' " >> Vagrantfile


	echo -n "Nom del sistema: "
	read nomsistema
	echo  "config.vm.provider '"$nomsistema"' do |v|"  >> Vagrantfile


	echo  "vb.name = "'"maquinavictor"'" " >> Vagrantfile


	echo -n "Quanta memòria vols assignar? "
	read memoria
	echo    "vb.memory = '"$memoria"' " >> Vagrantfile


	echo -n "Numero de processadors: "
	read cpu
	echo    "vb.cpus = '"$cpu"' "  >> Vagrantfile


	echo    "vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']"  >> Vagrantfile     
	echo    "end"  >> Vagrantfile


	echo -n "Port per redireccionar al port número 80? "
	read red80
	echo -n "config.vm.network "'"forwarded_port"'", guest: 80, host: $red80"  >> Vagrantfile


	echo -n "Port per redireccionar al port número 443? "
	read red443
	echo  "config.vm.network "'"forwarded_port"'", guest: 443, host: $red443" >> Vagrantfile


	echo -n "Port per redireccionar al port número 3306? "
	read red3306
	echo  "config.vm.network "'"forwarded_port"'", guest: 3306, host: $red3306"  >> Vagrantfile


	echo -n "Port per redireccionar al port número 22: "
	read red22
	echo  "config.vm.network "'"forwarded_port"'", guest: 22, host: $red22"  >> Vagrantfile
	  
	  
	echo    "config.vm.provision '"shell"', inline: <<-SHELL"  >> Vagrantfile
	echo    "sudo apt-get update -y"  >> Vagrantfile
	echo    "sudo apt-get upgrade -y" >> Vagrantfile
	echo    "sudo apt-get install -y net-tools" >> Vagrantfile
	echo    "sudo apt-get install -y openssh" >> Vagrantfile
	echo    "sudo apt-get install -y apache2 apache2-doc" >> Vagrantfile


	echo -n "Vol instal·lar paquets addicionals? (s/n)"
	read opcio
	if  [[  $opcio  ==  "s" ]]
	then
		echo    "sudo apt-get install -y openssh-sftp-server" >> Vagrantfile
		echo    "sudo apt-get install -y mariadb-server" >> Vagrantfile
		echo    "sudo apt-get install -y mariadb-client" >> Vagrantfile    
	fi

	echo  "SHELL" >> Vagrantfile
	echo "end"  >> Vagrantfile
	echo "Procés finalitzat. S'ha creat el fitxer Vagrantfile"

exit 0
