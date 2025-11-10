#!/bin/bash

#VERIFIE ABSENCE D'OPTION
if [ $# -eq 0 ]; then
   echo -e "\e[32m[BESOIN D'OPTION]\e[0m"
   echo " -a  : Creation de l'utilisateur"
   echo " -d  : Suppresssion de l'utilisateur"
   echo " -l  : Affichage de la liste d'utilisateur"
fi


while getopts "a:d:l" options;do 
    case $options in
        a) echo -e "$(date) \e[32m[Création de l'utilisateur]\e[0m $OPTARG"
           sudo useradd $OPTARG;;

        d) echo -e "$(date) \e[32m[Suppression de l'utilisateur]\e[0m  $OPTARG"
           sudo userdel $OPTARG;;

        l) echo -e "\e[32m[Affichage de la liste d'utilisateur ]\e[0m "
           awk -F: '$3 >= 1000 {print $1}' /etc/passwd;;

        *) echo -e "\e[32m[OPTION INVALIDE]\e[0m "
           echo -e "\e[32m[OPTION VALIDE : ]\e[0m"
           echo " -s  : Mise a jour system"
           echo " -b  : Backup"
           echo " -n  : Diagnostique system"
           exit 1;; 
    esac
done 
