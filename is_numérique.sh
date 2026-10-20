function is_number()
{
    re='^[+-]?[0-9]+([.][0-9]+)?$'
    if ! [[ $1 =~ $re ]] ; then
    return 1
    else
    return 0
    fi
}


if is_number "$1"; then 
 echo "$1 est un nombre réel." 
else 
 echo "Erreur : $1 n'est pas un nombre réel." 
fi
