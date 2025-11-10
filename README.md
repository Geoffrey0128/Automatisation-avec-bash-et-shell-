Le projet regroupe plusieurs scripts d’administration système dans une interface unique :

main.sh : le script principal, qui centralise les options.

./main.sh [OPTION] : 
-s	Lance la mise à jour du système (update_system.sh)
-b	Lance la sauvegarde (backup_logs.sh)
-n	Lance le diagnostic réseau (network_diag.sh)

ERREUR COURANTE : 
1)./main.sh: Permission denied | Le script n’est pas exécutable  | Exécuter : chmod +x main.sh
2)./update_system.sh: No such file or directory |	Le fichier n’existe pas ou le chemin est erroné	| Vérifier que le script est bien dans le même dossier que main.sh
3)[OPTION INVALIDE]	| Mauvaise option passée au script	| Vérifier la syntaxe : ./main.sh -s, -b ou -n
4)Permission non accordée lors d’une sauvegarde | Le script n’a pas les droits d’accès aux fichiers | Exécuter avec sudo ./main.sh -b




update_system.sh : met à jour le système.

- apt update — mise à jour de la liste des paquets.
- apt upgrade — installation des mises à jour disponibles.
- apt autoremove — nettoyage des paquets obsolètes.

ERREUR COURANTE
1)Permission denied	| Le script n’a pas le droit d’exécution | chmod +x update_system.sh
2)sudo: command not found | Sudo n’est pas installé ou l’utilisateur n’a pas les droits	| Installer sudo ou exécuter en root
4)Error pendant apt update | Une erreur s’est produite durant la mise à jour |Vérifier update.log pour le détail de l’erreur
5)Impossible d’ouvrir le fichier log | Le dossier Log_MAJ n’existe pas | Le script le crée automatiquement — vérifier les permissions

CAS D'USAGE 
2. Automatisation via cron
Planifier la mise à jour automatique



backup_logs.sh : effectue une sauvegarde de fichiers/journaux.

1. Verifie la taille du disque 
2. Crée le répertoire /backup/logs si nécessaire.
3. Archive les journaux de /var/log au format tar.gz.
4. Déplace l’archive vers /backup/logs.
5. Supprime automatiquement les sauvegardes de plus de 7 jours.
6. Affiche le taux de compression de l’archive créée

ERREUR COURANTE
1)Permission denied | Le script n’a pas les droits sur /backup ou /var/log | Exécuter le script avec sudo
2)Alerte : utilisation du disque à XX% | L’espace disque dépasse la limite fixée (80%) | Libérer de l’espace disque avant de relancer
3)mv: cannot move ... | Le fichier d’archive n’existe pas ou le chemin est incorrect | Vérifier la variable ARCHIVE et le répertoire source
4)gzip: not found ou tar: command not found	 | Outils manquants	 | Installer avec : sudo apt install gzip tar -y

CAS D'USAGE
1. Sauvegarde quotidienne des journaux
Automatise la rotation et la compression des logs pour éviter la saturation du disque
2. Nettoyage automatique
Supprime automatiquement les fichiers .tar.gz de plus de 7 jours dans /backup/logs.
3. Supervision disque
Arrête la sauvegarde si l’utilisation du disque dépasse 80 %, pour éviter un crash système.




network_diag.sh : exécute des diagnostics réseau.

Un test de ping vers Google DNS (8.8.8.8).
Un scan des ports ouverts en écoute (LISTENING).
L’affichage des interfaces réseau et leurs adresses.

ERREUR COURANTE
1)netstat: command not found | net-tools non installé | Installer avec sudo apt install net-tools -y
2)Permission denied | Script non exécutable	| chmod +x network_diag.sh
3)Pas de réponse au ping | Problème réseau ou firewall | Vérifier la connexion et les règles de firewall

CAS D'USAGE
1. Vérification de la connectivité Internet
Permet de savoir si le serveur peut atteindre Internet (via le ping).
2. Audit rapide des ports en écoute
Vérifie quels services sont disponibles et sur quelles interfaces/ports.
3. Inventaire des interfaces réseau
Affiche les interfaces et leurs adresses IP pour la configuration ou le dépannage.

L’objectif est de simplifier les tâches d’exploitation courantes en automatisant les opérations via une seule commande.




user_manager.sh : gère les utilisateurs.

Créer un utilisateur
Supprimer un utilisateu
Lister les utilisateurs système

./user_manager.sh [OPTION] [ARGUMENT]
-a	Création d’un utilisateur	
-d	Suppression d’un utilisateur	
-l	Affichage de la liste des utilisateurs (UID ≥ 1000)

ERREUR COURANTE
1)Permission denied | Commande useradd ou userdel exécutée sans droits root | Ajouter sudo ou exécuter le script avec sudo ./user_manager.sh
2)useradd: user exists | L’utilisateur existe déjà | Choisir un autre nom d’utilisateur
3)userdel: user does not exist | L’utilisateur n’existe pas | Vérifier le nom exact avec ./user_manager.sh -l
4)[OPTION INVALIDE] | Option non reconnue | Vérifier la syntaxe : -a, -d ou -l
5)Nom d’utilisateur vide | Aucun argument passé à -a ou -d	 | Toujours fournir le nom de l’utilisateur : ./user_manager.sh -a username

CAS D'USAGE 
1. Créer un utilisateur
Crée un nouvel utilisateur alice.
2. Supprimer un utilisateur
Supprime l’utilisateur alice.
3. Lister les utilisateurs
Affiche la liste des utilisateurs dont l’UID est supérieur ou égal à 1000 (utilisateurs normaux).