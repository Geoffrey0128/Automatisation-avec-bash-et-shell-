#!/bin/bash
source ./confing.cfg
#VERIFIE ABSENCE D'OPTION
if [ $# -eq 0 ]; then
   echo -e "\e[32m[BESOIN D'OPTION]\e[0m"
   echo " -s  : Mise a jour system"
   echo " -b  : Backup"
   echo " -n  : Diagnostique system"
fi


while getopts "sbn" options;do 
    case $options in
    s) echo -e " $(date) \e[32m[MISE A JOUR SYSTEM]\e[0m "
       . ./update_system.sh;;

    b) echo -e " $(date) \e[32m[BACKUP]\e[0m "
       . ./backup_logs.sh;;

    n) echo -e " $(date) \e[32m[DIAGNOSTIQUE SYSTEM]\e[0m "
       . ./network_diag.sh;;

    *) echo -e "\e[32m[OPTION INVALIDE]\e[0m "
       echo -e "\e[32m[OPTION CORRECT : ]\e[0m"
       echo " -s  : Mise a jour system"
       echo " -b  : Backup"
       echo " -n  : Diagnostique system"
       exit 1;;   
    esac
done 


