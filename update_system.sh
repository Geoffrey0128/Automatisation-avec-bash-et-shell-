#!/bin/bash

#Mise a jour système
mkdir ./Log_MAJ 

#UPDATE
UPDATE=$(sudo apt update &> update.log)
EXIT_CODE=$(echo $?)
echo -e "\e[32m[UPDATE]\e[0m" 
grep "Tous les paquets" update.log
if [ ! $EXIT_CODE -eq "0" ];then
	echo "Error pendant apt update"
fi; 

#UPGRADE
UPGRADE=$(sudo apt upgrade -y &> upgrade.log)
EXIT_CODE=$(echo $?)
echo -e "\e[32m[UPGRADE]\e[0m"
grep -E "mis à jour|nouvellement installés|enlever|non mis à jour" upgrade.log
if [ ! $EXIT_CODE -eq "0" ];then 
        echo "Error pendant apt upgrade" 
fi; 

#AUTOREMOVE
AUTOREMOVE=$(sudo apt autoremove -y &> autoremove.log)
EXIT_CODE=$(echo $?)
echo -e "\e[32m[AUTOREMOVE]\e[0m" 
grep -E "mis à jour|nouvellement installés|enlever|non mis à jour" autoremove.log
if [ ! $EXIT_CODE -eq "0" ];then 
        echo "Error pendant apt autoremove" 
fi; 

mv update.log Log_MAJ/
mv upgrade.log Log_MAJ/
mv autoremove.log Log_MAJ/

#resultat
echo -e "\e[32m[SYSTEME]\e[0m" 
echo "$(date) Systeme Mise À Jour Terminée..."

exit
