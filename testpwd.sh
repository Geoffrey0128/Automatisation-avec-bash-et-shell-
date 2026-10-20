#!/bin/bash
PASSWORD="azerty"

IFS= read -rsp "Saisie un mot de passe : " mdp 

if [ "$mdp" = "$PASSWORD" ];then
    echo "trouvé"
else 
    echo "mauvais mot de passe"
  
fi
