#!/bin/sh
#----------------------------------------------------
#  Arquivo:       install-cliente.sh
#  Descricao:     Instalador de programas Linux
#  Autor:         Emerson Rodrigo
#----------------------------------------------------
##Adcionar e Remover Impressora
## CRIAR PASTA COMPARTILHADA PARA SCANS
##ADD a OPCAO "--install-suggests" AO APT-GET .QConsidera pacotes sugeridos como uma dependência
##Inserir instalação LibreOffice 4.4 pt-BR
##TESTAR "--pending" "; -B, --auto-deconfigure"; "--force-configure-any"; "--force-depends" NO "DPKG"
## USAR "which" para ver se o programa esta instalado

#root = if [id -u != 0]; then && echo "Entre com a senha do Root" fi
apt-get -y update && clear
while true; do
SUCESSO='echo --------------------- Procedimento realizado com sucesso! ---------------------'
echo    "###########################"
echo     "      Hostname: " && sudo cat /etc/hostname
echo    "###########################"
echo	" 1) Instalar Java"
echo	" 2) Instalar Openssh-server"
echo    " 3) Instalar SNMP"
echo    " 4) Instalar Flash Player"
echo    " 5) Instalar Google Chrome"
echo    " 6) Instalar KRDC"
echo    " 7) LibreOffice Pt-BR"
echo    " 8) Corrigir Repositório"
echo    " 9) Pacotes Quebrados"
echo    "10) Upgrade & Autoremove"
echo    "11) ## A defirnir (GRUB)##"
echo	"12) Remover Convidado"
echo    "13) Nova versão Ubuntu"
echo    "14) Reiniciar / Desligar"
echo    "15) Sair / TESTE"
echo
echo "Insira sua opção: "
read Menu

  case $Menu in

"1" ) #JAVA v8.0_66
	sudo cd /usr/
	sudo rm -rf jre*
	sudo rm -rf /usr/lib/firefox-addons/plugins/libnpjp2*
	sudo rm -rf AutoDL?BundleId*

	case $(uname -m) in
	"x86_64")
		wget -dc --progress=dot http://javadl.sun.com/webapps/download/AutoDL?BundleId=111741;
		tar -zxvf  AutoDL?BundleId=111741
		sudo ln -s /usr/jre1.8.0_66/lib/amd64/libnpjp2.so  /usr/lib/firefox-addons/plugins/
		sudo rm -rf AutoDL?BundleId*
		java -version
		sleep 2
		$SUCESSO
##		firefox %U https://www.java.com/pt_BR/download/installed.jsp?detect=jre
;;
	"i686")
		wget -dc --progress=dot http://javadl.sun.com/webapps/download/AutoDL?BundleId=111739;
		tar -zxvf  AutoDL?BundleId=111739
		sudo ln -s /usr/jre1.8.0_66/lib/i386/libnpjp2.so  /usr/lib/firefox-addons/plugins/
		sudo rm -rf AutoDL?BundleId*
		java -version
		sleep 2
		$SUCESSO
##		firefox %U https://www.java.com/pt_BR/download/installed.jsp?detect=jre
;;
esac
;;

"2" )	#OpenSSH-server
	sudo apt-get install -y openssh-server
	$SUCESSO
;;

"3" )	#SNMP
	sudo apt-get install -y snmp snmpd
	sudo cd /etc/snmp/
	sudo mv snmpd.conf snmpd.conf.original
	echo -e "rocommunity public \nsyslocation 'IFCE Ubajara' \nsyscontact @CTI" >> snmpd.conf
	sudo /etc/init.d/snmpd restart
	$SUCESSO
;;

"4" )	#Flash Player
	sudo apt-get install -y flashplugin-installer
	$SUCESSO
;;

"5" )	#Chrome
   case $(uname -m) in
	"x86_64")
		sudo apt-get install -y libxss1
		wget -dc --progress=dot https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
		sudo dpkg -i google-chrome-stable_current_amd64.deb
		sudo apt-get -fy install
		rm -rf google-chrome*
		$SUCESSO
;;
	"i686")
		sudo apt-get install -y libxss1
		wget -dc --progress=dot https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
		sudo dpkg -i google-chrome-stable_current_i386.deb
		sudo apt-get -fy install
		rm -rf google-chrome*
		$SUCESSO
;;
esac
;;

"6")	#KRDC
	sudo apt-get install -y krdc
	$SUCESSO
;;

"7")	#LibreOffice
	sudo add-apt-repository -y ppa:libreoffice/ppa && sudo apt-get update && sudo apt-get -y dist-upgrade
;;

"8" )	#Corrigir repositório
	sudo rm -rf /var/lib/apt/lists/*
	sudo apt-get -y update
	$SUCESSO
;;

"9" )	#Pacotes quebrados
	sudo dpkg --configure -a
	sudoapt-get install -f
	sudo apt-get -y dist-upgrade
	$SUCESSO
;;

"10" )	#Update & Upgrade
	sudo apt-get -y upgrade
	sudo apt-get -y autoremove
	$SUCESSO
;;

"11" )	#Autoremove
	echo "A definir!"
	$SUCESSO
;;

"12" )	#Remover convidado
	case $(lsb_release -sr) in
	"12.*")
		sudo echo -e "allow-guest=false" >> /etc/lighdm/lightdm.conf
		$SUCESSO
;;
	"14.*")
		sudo echo -e "allow-guest=false" >> /etc/lighdm/lightdm.conf
		sudo echo -e "allow-guest=false" >> /etc/lighdm/users.conf
		sudo echo -e "allow-guest=false" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
		$SUCESSO
;;
esac
;;

"13" )	#Nova versão do Ubuntu
        do-release-upgrade
;;

"14" )	#Reiniciar/Desligar
	echo -e "Você deseja Desligar[d] ou Reiniciar[r]?"
	read opcao
	case $opcao in
	"d")
		echo -e "O computador está sendo desligado!"
		sudo poweroff
;;
	"r")
		echo -e "O computador será reiniciado!"
		sudo reboot
;;
esac
;;

*)	#Sair
	break
	exit
;;
esac
done
