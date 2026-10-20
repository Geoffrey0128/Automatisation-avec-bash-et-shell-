#!/bin/bash
# Tableau des couleurs ANSI avec une ligne blanche déplaçable
# Flèche haut / bas : déplacer la ligne blanche    q : quitter

FG_CODES=("" 1 4 5 7 30 31 32 33 34 35 36 37)
BG_CODES=("" 40 41 42 43 44 45 46 47)

SEL=0                       # indice de la ligne sélectionnée (0 = première)
NB=${#FG_CODES[@]}          # nombre de lignes du tableau

BLANC=$'\e[30;47m'          # texte noir sur fond blanc (la ligne sélectionnée)
RESET=$'\e[0m'              # retour au style par défaut

# ---- Quitter proprement : réafficher le curseur et remettre les couleurs ----
quitter() {
    tput cnorm              # rend le curseur visible
    printf '%s\n' "$RESET"
    exit 0
}
trap quitter INT TERM       # Ctrl+C passe aussi par quitter()

# ---- Dessine tout le tableau ----
afficher() {
    printf '\e[H'           # replace le curseur en haut à gauche (pas d'effacement → pas de clignotement)

    # En-tête
    printf "%-8s" 'FG \ BG'
    for bg in "${BG_CODES[@]}"; do
        printf " %4s  " "$bg"
    done
    echo

    # Lignes du tableau
    for i in "${!FG_CODES[@]}"; do          # ${!tab[@]} = les indices du tableau
        fg=${FG_CODES[$i]}

        # Style de base de la ligne : blanc si c'est la ligne sélectionnée
        if (( i == SEL )); then
            fond=$BLANC
        else
            fond=$RESET
        fi

        printf "%s%-8s" "$fond" "$fg"       # le code FG, sur fond blanc si sélectionné

        for bg in "${BG_CODES[@]}"; do
            codes="$fg"
            if [ -n "$bg" ]; then
                codes="${codes:+$codes;}$bg"
            fi
            # Après chaque case : reset puis retour au style de la ligne
            printf "\e[%sm Bash ${RESET}%s " "$codes" "$fond"
        done
        printf "%s\n" "$RESET"
    done

    echo
    echo "↑ / ↓ : se déplacer    q : quitter"
}

# ---- Programme principal ----
tput civis                  # cache le curseur
clear                       # efface l'écran une seule fois au départ

while true; do
    afficher

    # Lit une touche sans attendre Entrée (-n1) et sans l'afficher (-s)
    IFS= read -rsn1 touche || quitter

    # Une flèche envoie 3 caractères : Échap, '[', puis A/B/C/D
    if [[ $touche == $'\e' ]]; then
        read -rsn2 -t 0.1 touche            # on lit les 2 caractères suivants
    fi

    case $touche in
        '[A') SEL=$(( (SEL - 1 + NB) % NB )) ;;   # flèche haut (revient en bas si on est en haut)
        '[B') SEL=$(( (SEL + 1) % NB )) ;;        # flèche bas  (revient en haut si on est en bas)
        q|Q)  quitter ;;
    esac
done
