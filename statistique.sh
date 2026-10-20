#!/bin/bash 

function is_number() 
{
     re='^[+-]?[0-9]*$' 

    if ! [[ $1 =~ $re ]] ; then 
        return 1
    else
        return 0
    fi
}

if [ $# -ne 3 ]; then 
    echo "Utilisation : $0 <nombre1> <nombre2> <nombre3>" 
    exit 1 
fi

if ( is_number "$1" && is_number "$2" && is_number "$3" ); then
	if (( $1 > 100 || $2 > 100 || $3 > 100 )); then
	    echo "Superieur a 100"
	    exit 1
	fi
	if (( $1 < -100 || $2 < -100 || $3 < -100 )); then
	    echo "Inf a -100"
	    exit 1
	fi
else 
	echo "le nombre n'est pas un entier"
	exit 1
fi

# PLUS GRAND 
if [ $1 -ge $2 ] && [ $1 -ge $3 ]; then 
    MAX=$1 
elif [ $2 -ge $1 ] && [ $2 -ge $3 ]; then 
    MAX=$2 
else 
    MAX=$3 
fi 

# PLUS PETIT 
if [ $1 -le $2 ] && [ $1 -le $3 ]; then 
    MIN=$1 
elif [ $2 -le $1 ] && [ $2 -le $3 ]; then 
    MIN=$2 
else 
    MIN=$3 
fi 


SOMME=$(( $1 + $2 + $3 )) 
MOYENNE=$(echo "scale=2; $SOMME / 3" | bc) 
echo "La moyenne : $MOYENNE" 
echo "le plus grand  : $MAX" 
echo "Le plus petit : $MIN" 
