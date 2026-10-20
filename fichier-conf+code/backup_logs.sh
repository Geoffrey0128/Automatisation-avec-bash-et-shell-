 #!/bin/bash

source ./config.cfg


#ESPACE DE DISQUE UTILISER
echo -e "\e[32m[TAILLE_DISQ_UTILISER]\e[0m" 


TAILLE_DISQ_UTILISER=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')

if [ "$TAILLE_DISQ_UTILISER" -gt "$LIMITE_DISQ" ]; then
    echo "Alerte : utilisation du disque à $TAILLE_DISQ_UTILISER%"
    echo "liberer plus d'espace"
    exit 1;

else
    echo "Espace disque OK ($TAILLE_DISQ_UTILISER%)"
    #CREATION DU DOSSIER BACKUP/LOGS
    sudo mkdir -p $BACKUP_DIR

    #ARCHIVAGE 
    echo -e "\e[32m[ARCHIVAGE]\e[0m" 
    sudo tar -czvf $NAME_ARCHIVE  $DOSSIER_A_ARCHIVER


    #DEPLACEMENT DES FICHIER ARCHIVER DANS LA DOSSIER BACKUP/LOGS
    for file in $(find . -type f -name "*.tar.gz"); do
      sudo mv $NAME_ARCHIVE $BACKUP_DIR
    done

    #SUPRESSION DES BACKUO QUI DATE DE PLUS DE 7 JOUR
    find $BACKUP_DIR -type f -name "*.tar.gz" -mtime +7 -exec rm -v {} \;


    #AFFICHAGE TAUX DE COMPRESSION ARCHIVE
    echo -e "\e[32m[TAUX DE COMPRESSION]\e[0m" 
    gzip -l $BACKUP_DIR/$NAME_ARCHIVE | awk 'NR==2 {print $3}'

fi


exit



