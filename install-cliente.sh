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
while true; do
SUCESSO='echo --------------------- Procedimento realizado com sucesso! ---------------------'
echo
echo	" 1) Instalar Java"
echo	" 2) Instalar Openssh-server"
echo    " 3) Instalar SNMP"
echo    " 4) Instalar Flash Player"
echo    " 5) Instalar Google Chrome"
echo    " 6) Instalar KRDC"
echo    " 7) LibreOffice Pt-BR"
echo    " 8) Corrigir Repositório"
echo    " 9) Pacotes Quebrados"
echo    "10) Update & Upgrade"
echo    "11) Autoremove"
echo	"12) Remover Convidado"
echo    "13) Nova versão Ubuntu"
echo    "14) Reiniciar / Desligar"
echo    "15) Sair / TESTE"
echo
echo "Insira sua opção: "
read Menu

  case $Menu in

"1" ) ##JAVA v8.0_66
	cd /usr/
	rm -rf jre*
	rm -rf /usr/lib/firefox-addons/plugins/libnpjp2*
	rm -rf AutoDL?BundleId*

	case $(uname -m) in
	"x86_64")
		wget -dc --progress=dot http://javadl.sun.com/webapps/download/AutoDL?BundleId=111741;
		tar zxvf  AutoDL?BundleId=111741
		ln -s /usr/jre1.8.0_66/lib/amd64/libnpjp2.so  /usr/lib/firefox-addons/plugins/
		rm -rf AutoDL?BundleId*
		$SUCESSO
##		firefox %U https://www.java.com/pt_BR/download/installed.jsp?detect=jre
;;
	"i686")
		wget -dc --progress=dot http://javadl.sun.com/webapps/download/AutoDL?BundleId=111739;
		tar zxvf  AutoDL?BundleId=111739
		ln -s /usr/jre1.8.0_66/lib/i386/libnpjp2.so  /usr/lib/firefox-addons/plugins/
		rm -rf AutoDL?BundleId*
		$SUCESSO
##		firefox %U https://www.java.com/pt_BR/download/installed.jsp?detect=jre
;;
esac
;;

"2" )	#OpenSSH-server
	apt-get -y update
	apt-get install -y openssh-server
	$SUCESSO
;;

"3" )	#SNMP
	apt-get -y update
	apt-get install -y snmp snmpd
	cd /etc/snmp/
	mv snmpd.conf snmpd.conf.original
	echo -e "rocommunity public \nsyslocation 'IFCE Ubajara' \nsyscontact @CTI" >> snmpd.conf
	/etc/init.d/snmpd restart
	$SUCESSO
;;

"4" )	#Flash Player
	apt-get update
	apt-get install -y flashplugin-installer
	$SUCESSO
;;

"5" )	#Chrome
   case $(uname -m) in
	"x86_64")
		apt-get install -y libxss1
		wget -dc --progress=dot https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
		dpkg -i google-chrome-stable_current_amd64.deb
		apt-get -fy install
		rm -rf google-chrome*
		$SUCESSO
;;
	"i686")
		apt-get install -y libxss1
		wget -dc --progress=dot https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
		dpkg -i google-chrome-stable_current_i386.deb
		apt-get -fy install
		rm -rf google-chrome*
		$SUCESSO
;;
esac
;;

"6")	#KRDC
	apt-get update
	apt-get install -y krdc
	$SUCESSO
;;

"7")	#LibreOffice
	sudo add-apt-repository -y ppa:libreoffice/ppa && sudo apt-get update && sudo apt-get dist-upgrade -y
#   case $(which libreoffice) in
#	"/usr/bin/libreoffice") ##ENCONTRAR OS LUGARES DE INSTALAÇÃO DO LIBREOFFICE
#		apt-get -y --no-install-recommends --no-install-suggests remove libreoffice*
####		apt-get -y --no-install-recommends --no-install-suggests purge libreoffice*
####		apt-get -y autoremove
#		apt-get -y purge libreoffice*
#		rm -rf /*libreoffice* *LibreOffice*
#		rmdir --ignore-fail-on-non-empty /*libreoffice* *LibreOffice*

#    case $(uname -m) in
# 	"x86_64")
# 		wget -dc --progress=bar http://download.documentfoundation.org/libreoffice/stable/4.4.6/deb/x86_64/LibreOffice_4.4.6_Linux_x86-64_deb_langpack_pt-BR.tar.gz
# 		wget -dc --progress=bar http://download.documentfoundation.org/libreoffice/stable/4.4.6/deb/x86_64/LibreOffice_4.4.6_Linux_x86-64_deb_helppack_pt-BR.tar.gz
# 		wget -dc --progress=bar http://download.documentfoundation.org/libreoffice/stable/4.4.6/deb/x86_64/LibreOffice_4.4.6_Linux_x86-64_deb.tar.gz
# 		for x in ls LibreOffice*; do tar -xzvf $x;done
# ##		tar -zxvf LibreOffice*
# 		cd LibreOffice_4.4.6.3_Linux_x86-64_deb/DEBS/
# 		dpkg -i *.deb
# 		cd ../../LibreOffice_4.4.6.3_Linux_x86-64_deb_langpack_pt-BR/DEBS/
# 		dpkg -i --force-all *.deb
# 		cd ../../LibreOffice_4.4.6.3_Linux_x86-64_deb_helppack_pt-BR/DEBS/
# 		dpkg -i --force-all *.deb
# 		apt-get -fy install
# 		cd ../../
# 		rm -rf LibreOffice*
# 		$SUCESSO
# ;;
# 	"i686")
#               wget -dc --progress=bar http://download.documentfoundation.org/libreoffice/stable/4.4.6/deb/x86/LibreOffice_4.4.6_Linux_x86_deb_langpack_pt-BR.tar.gz
#               wget -dc --progress=bar http://download.documentfoundation.org/libreoffice/stable/4.4.6/deb/x86/LibreOffice_4.4.6_Linux_x86_deb_helppack_pt-BR.tar.gz
#               wget -dc --progress=bar http://download.documentfoundation.org/libreoffice/stable/4.4.6/deb/x86/LibreOffice_4.4.6_Linux_x86_deb.tar.gz
# 		for x in ls LibreOffice*; do tar -xzvf $x;done
# ##		tar -zxvf LibreOffice*
#               cd LibreOffice_4.4.6.3_Linux_x86_deb/DEBS/
#               dpkg -i *.deb
#               cd ../../LibreOffice_4.4.6.3_Linux_x86_deb_langpack_pt-BR/DEBS/
#               dpkg -i --force-all *.deb
#               cd ../../LibreOffice_4.4.6.3_Linux_x86_deb_helppack_pt-BR/DEBS/
#               dpkg -i --force-all *.deb
#               apt-get -fy install
#               cd ../../
#               rm -rf LibreOffice*
#               $SUCESSO
# ;;
# esac
# ;;

#"Instalar Impressoras" )
#		zenity --width=400 --height=380 --list --column "Impressoras" --column "Modelo" --title="Instalador de Impressoras" \
#		"DIRETORIA_TINTA" \ "HP Officejet Pro 8600" \
#		"DIREN_LASER" \ "Xerox Phaser 4600" \
#		"DAP_TINTA" \ "HP Officejet Pro 8600" \
#		"DAP_LASER" \ "Xerox Phaser 4600" \
#		"PROFESSORES_LASER" \ "Xerox Phaser 4600" \
#		"## RECEPCAO_LASER" \ "Xerox Phaser 4600" \
#		"## BIBLIOTECA_LASER" \ "Xerox Phaser 4600" \
#		"## CTI_LASER" \ "Xerox Phaser 4600" \
#		"## CCA_TINTA" \ "HP Officejet Pro 8600" \
#		case "${impressora}" in
#		"DIRETORIA_TINTA" )
#			echo 10.100.101.102:/var/www/DIRETORIA_TINTA.ppd  /etc/cups/ppd/DIRETORIA_TINTA.ppd
#			rm -rf /etc/cups/printers.conf
#			touch /etc/cups/printers.conf
#			echo 10.100.101.102/HP_printers.conf >> /etc/cups/printers.conf
#		"DIREN_LASER" )
#		"DAP_TINTA" )
#		"DAP_LASER" )
#		"PROFESSORES_LASER" )
#		"## RECEPCAO_LASER" )
#		"## BIBLIOTECA_LASER" )
#		"## CTI_LASER" )
#		"## CCA_TINTA" )
#;;
#esac
#;;

"8" )	#Corrigir repositório
	rm -rf /var/lib/apt/lists/*
	apt-get -y update
	$SUCESSO
;;

"9" )	#Pacotes quebrados
	dpkg --configure -a
	apt-get install -f
	apt-get -y dist-upgrade
	$SUCESSO
;;

"10" )	#Update & Upgrade
	apt-get -y update
	apt-get -y upgrade
	$SUCESSO
;;

"11" )	#Autoremove
	apt-get -y autoremove
	$SUCESSO
;;

"12" )	#Remover convidado
	case $(lsb_release -sr) in
	"12.*")
		echo -e "allow-guest=false" >> /etc/lighdm/lightdm.conf
		$SUCESSO
;;
	"14.*")
		echo -e "allow-guest=false" >> /etc/lighdm/lightdm.conf
		echo -e "allow-guest=false" >> /etc/lighdm/users.conf
		echo -e "allow-guest=false" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
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
		poweroff
;;
	"r")
		echo -e "O computador será reiniciado!"
		reboot
;;
esac
;;

*)	#Sair
	break
	exit
;;
esac
done
