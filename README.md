# 🛠️ Boîte à outils d'administration système

Ce projet regroupe plusieurs scripts d'administration système dans une **interface unique**. L'objectif est de simplifier les tâches d'exploitation courantes en automatisant les opérations via une seule commande.

---

## 📑 Sommaire

- [main.sh — Script principal](#-mainsh--script-principal)
- [update_system.sh — Mise à jour du système](#-update_systemsh--mise-à-jour-du-système)
- [backup_logs.sh — Sauvegarde des journaux](#-backup_logssh--sauvegarde-des-journaux)
- [network_diag.sh — Diagnostic réseau](#-network_diagsh--diagnostic-réseau)
- [user_manager.sh — Gestion des utilisateurs](#-user_managersh--gestion-des-utilisateurs)

---

## 🚀 main.sh — Script principal

Le script principal, qui **centralise les options** et lance les autres scripts.

### Utilisation

```bash
./main.sh [OPTION]
```

| Option | Description |
|--------|-------------|
| `-s` | Lance la mise à jour du système (`update_system.sh`) |
| `-b` | Lance la sauvegarde (`backup_logs.sh`) |
| `-n` | Lance le diagnostic réseau (`network_diag.sh`) |

### ⚠️ Erreurs courantes

| Erreur | Cause | Solution |
|--------|-------|----------|
| `./main.sh: Permission denied` | Le script n'est pas exécutable | Exécuter : `chmod +x main.sh` |
| `./update_system.sh: No such file or directory` | Le fichier n'existe pas ou le chemin est erroné | Vérifier que le script est bien dans le même dossier que `main.sh` |
| `[OPTION INVALIDE]` | Mauvaise option passée au script | Vérifier la syntaxe : `./main.sh -s`, `-b` ou `-n` |
| Permission non accordée lors d'une sauvegarde | Le script n'a pas les droits d'accès aux fichiers | Exécuter avec `sudo ./main.sh -b` |

---

## 🔄 update_system.sh — Mise à jour du système

Met à jour le système en trois étapes :

- `apt update` — mise à jour de la liste des paquets
- `apt upgrade` — installation des mises à jour disponibles
- `apt autoremove` — nettoyage des paquets obsolètes

### ⚠️ Erreurs courantes

| Erreur | Cause | Solution |
|--------|-------|----------|
| `Permission denied` | Le script n'a pas le droit d'exécution | `chmod +x update_system.sh` |
| `sudo: command not found` | Sudo n'est pas installé ou l'utilisateur n'a pas les droits | Installer sudo ou exécuter en root |
| Erreur pendant `apt update` | Une erreur s'est produite durant la mise à jour | Vérifier `update.log` pour le détail de l'erreur |
| Impossible d'ouvrir le fichier log | Le dossier `Log_MAJ` n'existe pas | Le script le crée automatiquement — vérifier les permissions |

### 💡 Cas d'usage

1. **Automatisation via cron** — planifier la mise à jour automatique du système.

---

## 💾 backup_logs.sh — Sauvegarde des journaux

Effectue une sauvegarde des fichiers/journaux selon les étapes suivantes :

1. Vérifie la taille du disque
2. Crée le répertoire `/backup/logs` si nécessaire
3. Archive les journaux de `/var/log` au format `tar.gz`
4. Déplace l'archive vers `/backup/logs`
5. Supprime automatiquement les sauvegardes de plus de **7 jours**
6. Affiche le taux de compression de l'archive créée

### ⚠️ Erreurs courantes

| Erreur | Cause | Solution |
|--------|-------|----------|
| `Permission denied` | Le script n'a pas les droits sur `/backup` ou `/var/log` | Exécuter le script avec `sudo` |
| `Alerte : utilisation du disque à XX%` | L'espace disque dépasse la limite fixée (80 %) | Libérer de l'espace disque avant de relancer |
| `mv: cannot move ...` | Le fichier d'archive n'existe pas ou le chemin est incorrect | Vérifier la variable `ARCHIVE` et le répertoire source |
| `gzip: not found` ou `tar: command not found` | Outils manquants | Installer avec : `sudo apt install gzip tar -y` |

### 💡 Cas d'usage

1. **Sauvegarde quotidienne des journaux** — automatise la rotation et la compression des logs pour éviter la saturation du disque.
2. **Nettoyage automatique** — supprime automatiquement les fichiers `.tar.gz` de plus de 7 jours dans `/backup/logs`.
3. **Supervision disque** — arrête la sauvegarde si l'utilisation du disque dépasse 80 %, pour éviter un crash système.

---

## 🌐 network_diag.sh — Diagnostic réseau

Exécute des diagnostics réseau :

- Un test de **ping** vers Google DNS (`8.8.8.8`)
- Un **scan des ports ouverts** en écoute (`LISTENING`)
- L'**affichage des interfaces réseau** et leurs adresses

### ⚠️ Erreurs courantes

| Erreur | Cause | Solution |
|--------|-------|----------|
| `netstat: command not found` | `net-tools` non installé | Installer avec `sudo apt install net-tools -y` |
| `Permission denied` | Script non exécutable | `chmod +x network_diag.sh` |
| Pas de réponse au ping | Problème réseau ou firewall | Vérifier la connexion et les règles de firewall |

### 💡 Cas d'usage

1. **Vérification de la connectivité Internet** — permet de savoir si le serveur peut atteindre Internet (via le ping).
2. **Audit rapide des ports en écoute** — vérifie quels services sont disponibles et sur quelles interfaces/ports.
3. **Inventaire des interfaces réseau** — affiche les interfaces et leurs adresses IP pour la configuration ou le dépannage.

---

## 👤 user_manager.sh — Gestion des utilisateurs

Gère les utilisateurs du système :

- Créer un utilisateur
- Supprimer un utilisateur
- Lister les utilisateurs système

### Utilisation

```bash
./user_manager.sh [OPTION] [ARGUMENT]
```

| Option | Description |
|--------|-------------|
| `-a` | Création d'un utilisateur |
| `-d` | Suppression d'un utilisateur |
| `-l` | Affichage de la liste des utilisateurs (UID ≥ 1000) |

### ⚠️ Erreurs courantes

| Erreur | Cause | Solution |
|--------|-------|----------|
| `Permission denied` | Commande `useradd` ou `userdel` exécutée sans droits root | Ajouter `sudo` ou exécuter le script avec `sudo ./user_manager.sh` |
| `useradd: user exists` | L'utilisateur existe déjà | Choisir un autre nom d'utilisateur |
| `userdel: user does not exist` | L'utilisateur n'existe pas | Vérifier le nom exact avec `./user_manager.sh -l` |
| `[OPTION INVALIDE]` | Option non reconnue | Vérifier la syntaxe : `-a`, `-d` ou `-l` |
| Nom d'utilisateur vide | Aucun argument passé à `-a` ou `-d` | Toujours fournir le nom de l'utilisateur : `./user_manager.sh -a username` |

### 💡 Cas d'usage

1. **Créer un utilisateur** — `./user_manager.sh -a alice` crée un nouvel utilisateur `alice`.
2. **Supprimer un utilisateur** — `./user_manager.sh -d alice` supprime l'utilisateur `alice`.
3. **Lister les utilisateurs** — `./user_manager.sh -l` affiche la liste des utilisateurs dont l'UID est supérieur ou égal à 1000 (utilisateurs normaux).
