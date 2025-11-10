#!/bin/bash
source ./confing.cfg
#CREATION DU DOSSIER LOG_UPDATE
mkdir ./Log_update

#Mise a jour système

echo $STARTDATEFMT

#UPDATE
UPDATE=$(sudo apt update > update_log.txt 2>update_error.log)
EXIT_CODE=$(echo $?)
echo "[$STARTDATE] Début de la mise à jour..."
sed "s/^/${STARTDATEFMT} /" update_log.txt > date_update_log.txt
sed "s/^/${STARTDATEFMT} /" update_error.log > date_error_log.log
if [ ! $EXIT_CODE -eq "0" ];then
	echo "Error pendant apt update"
fi; 
STOPDATE=$(date)
echo "[$STOPDATE] Fin de la mise à jour..."
sudo rm -r update_log.txt update_error.log
echo  $STOPDATE >> date_update_log.txt 
echo $STOPDATE >> date_error_log.log

mv date_update_log.txt Log_update/
mv date_error_log.log Log_update/

exit
