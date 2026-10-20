#!/bin/bash

is_number()
{
    re='^[+-]?[0-9]*$'

    if ! [[ $1 =~ $re ]] ; then
        return 1
    else
        return 0
    fi
}

NOTES=()
SOMME=0

echo "Saisir les notes (entiers entre -100 et 100). Entree vide pour terminer."

while true; do
    read -p "Note : " NOTE
    if [ -z "$NOTE" ]; then
        break
    fi
    if ( is_number "$NOTE" ); then
        if (( NOTE > 100 )); then
            echo "Superieur a 100"
        elif (( NOTE < -100 )); then
            echo "Inf a -100"
        else
            NOTES+=("$NOTE")
        fi
    else
        echo "le nombre n'est pas un entier"
    fi
done

if [ ${#NOTES[@]} -eq 0 ]; then
    echo "Aucune note saisie"
    exit 1
fi

MAX=${NOTES[0]}
MIN=${NOTES[0]}

for NOTE in "${NOTES[@]}"; do
    SOMME=$(( SOMME + NOTE ))
    if (( NOTE > MAX )); then
        MAX=$NOTE
    fi
    if (( NOTE < MIN )); then
        MIN=$NOTE
    fi
done

MOYENNE=$(echo "scale=2; $SOMME / ${#NOTES[@]}" | bc)
echo "La moyenne : $MOYENNE"
echo "le plus grand  : $MAX"
echo "Le plus petit : $MIN"
