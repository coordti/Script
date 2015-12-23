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

function java () {	
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
;;
	"i686")
		wget -dc --progress=dot http://javadl.sun.com/webapps/download/AutoDL?BundleId=111739;
		tar -zxvf  AutoDL?BundleId=111739
		sudo ln -s /usr/jre1.8.0_66/lib/i386/libnpjp2.so  /usr/lib/firefox-addons/plugins/
		sudo rm -rf AutoDL?BundleId*
		java -version
		sleep 2
		$SUCESSO
}

function openssh () { 
	sudo apt-get install -y openssh-server
	$SUCESSO
}

function snmp () {
	sudo apt-get install -y snmp snmpd
	sudo cd /etc/snmp/
	sudo mv snmpd.conf snmpd.conf.original
	echo -e "rocommunity public \nsyslocation 'IFCE Ubajara' \nsyscontact @CTI" >> snmpd.conf
	sudo /etc/init.d/snmpd restart
	$SUCESSO
}

function flashplayer() {
	sudo apt-get install -y flashplugin-installer
	$SUCESSO
}

function chrome () {
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
}

function krdc () {
	sudo apt-get install -y krdc
	$SUCESSO
}

function libreoffice () {
	sudo add-apt-repository -y ppa:libreoffice/ppa && sudo apt-get update && sudo apt-get -y dist-upgrade
}

function repositorio () {
	sudo rm -rf /var/lib/apt/lists/*
	sudo apt-get -y update
	$SUCESSO
}

function pacotes () {
	sudo dpkg --configure -a
	sudoapt-get install -f
	sudo apt-get -y dist-upgrade
	$SUCESSO
}

function updupg() {
	sudo apt-get -y upgrade
	sudo apt-get -y autoremove
	$SUCESSO
}

function autoremove () {
	echo "A definir!"
	$SUCESSO
}

function convidado () {
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
}

function novaversao () {
        do-release-upgrade
}

function desliga() {
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
}

####-------------------------------------------MENU-------------------------------------------####
#root = if [id -u != 0]; then && echo "Entre com a senha do Root" fi
#apt-get -y update && clear
while true; do
SUCESSO='echo --------------------- Procedimento realizado com sucesso! ---------------------'
echo    "###########################"
echo -n "      Hostname: " && sudo cat /etc/hostname
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
echo	"Insira sua opção: "
read Menu

  case $Menu in
  
"1") java ;;
"2") openssh ;;
"3") snmp ;;
"4") flashplayer ;;
"5") chrome ;;
"6") krdc ;;
"7") libreoffice ;;
"8") repositorio ;;
"9") pacotes ;;
"10") updupg ;;
"11") autoremove ;;
"12") convidado ;;
"13") novaversao ;;
"14") desliga ;;
*) exit ;;

esac
done
