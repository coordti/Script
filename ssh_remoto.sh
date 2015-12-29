#!/bin/sh
##Gerar Chave##
# ssh-keygen
##Copiar chave no Servidor##
# ssh-copy-id hostname('Ip do Host')


echo "Insira o final do IP do Host: 10.100.101."
read host

#ssh -t  suporte@10.100.101.$host 	scp cti@10.100.101.102:/home/cti/TESTES/install-cliente.sh /home/suporte/cliente.sh
#ssh -tX suporte@10.100.101.$host 	sudo gnome-terminal

####scp cti@10.100.101.102:/home/cti/TESTES/install-cliente.sh /home/suporte/cliente.sh
####ssh -tX suporte@10.100.101.$host 	sudo gnome-terminal

sshpass -p "CTIADMINPC" ssh suporte@10.100.101.$host
echo
echo "#####################"
echo "Obrigado pela visita!"
echo "#####################"
echo
