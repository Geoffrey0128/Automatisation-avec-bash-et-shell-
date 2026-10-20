#!/bin/bash

./user_manager.sh --list > test
FICHIER=test
if [ $# -lt 2 ]; then
    echo "Utilisation : $0 <nom>"
    exit 1
fi
if grep -qw "$1" "$FICHIER"; then
    echo "$1 est un utilisateur"
else
    echo "$1 n'est pas un utilisateur"
fi
rm test
