#!/bin/bash
source ./confing.cfg


#TEST DE PING 
echo -e "\e[32m[TEST DE PING]\e[0m" 
ping -c 4  $PING

#SCANNE DE PORTS OUVERT 
echo -e "\e[32m[SCANNE PORTS OUVERTS]\e[0m" 
netstat -an | grep "LISTENING"    

#INTERFACE
echo -e "\e[32m[INTERFACE RESEAUX]\e[0m" 
ip a

exit
