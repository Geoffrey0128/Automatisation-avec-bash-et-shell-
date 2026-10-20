#!/bin/bash

est_entier() {
    [[ "$1" =~ ^[+-]?(0|[1-9][0-9]*)$ ]]
}

if [[ $# -eq 0 ]]; then
    echo "Utilisation : $(basename "$0") <n1> [n2 ...]"
    exit 1
fi

nb=$#
min=""
max=""
somme=0

while [[ $# -gt 0 ]]; do
    n=$1
    if ! est_entier "$n"; then
        echo "Erreur : '$n' n'est pas un entier"
        exit 1
    fi
    if (( n < -100 || n > 100 )); then
        echo "Erreur : $n hors de [-100, 100]"
        exit 1
    fi

    if [[ -z "$min" ]] || (( n < min )); then min=$n; fi
    if [[ -z "$max" ]] || (( n > max )); then max=$n; fi
    somme=$(( somme + n ))

    shift
done

moyenne=$(awk -v s="$somme" -v c="$nb" 'BEGIN { printf "%.2f", s/c }')

echo "Min : $min"
echo "Max : $max"
echo "Moyenne : $moyenne"
