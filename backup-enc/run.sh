#!/bin/bash
# Sauvegarde des données sous forme de TARBALL chiffrées AES-256.
# Le script réalise des archives TAR compressées BZIP2 et les stocke
# en local. Ensuite, une opération de chiffrement de ces archives
# est réalisée. En local, on ne conservera que les TARBALL non
# chiffrées. Les TARBALL chiffrées seront envoyées via FTP au
# serveur de backup.
#
# Ce fichier est l'exécutable. Veillez à lire le manuel afin
# de confiurer la tâche CRON ainsi que la notification par SMS
# le cas échéant.
#
# # Codes d'erreur #
# 0 : Code de sortie nominale
# 1 : Répertoire local de sauvegarde inexistant
# 2 : Répertoire ou fichier à sauvegarder inexistant
#
# Auteur : echodeltaFR <edouard@hello-community.fr>
# Version : 1.1
# Licence : GNU GPLv3 <https://www.gnu.org/licenses/gpl.html>
###########

### VARIABLES ###
## Répertoires à sauvegarder
## Ex: ('/etc' '/home' '/var/lib')
RepToBak=()

## Répertoire de sauvegarde locale
## Ex: RepLocalBak='/var/archives'
RepLocalBak=''

## Mot de passe de chiffrement
## Ex: PassEnc='motdepasse'
PassEnc=''

## Paramètres FTP
##
# Utilisateur
# Ex: FTPuser='user'
FTPuser=''
# Mot de passe
# Ex: FTPpass='pass'
FTPpass=''
# Serveur distant
# Ex: FTPserver='example.com'
FTPserver=''
###		###

datec=$(date +%y%m%d)
dateold=$(($datec - 2))

echo -e "\tSauvegarde du $datec"
echo

if [ ! -d $RepLocalBak ] ; then
  echo "$RepLocalBak : Répertoire local de sauvegarde inexistant"
  exit 1
fi

for rep in $RepToBak ; do
  if [ ! -e $rep ] ; then
    echo "$rep : Répertoire ou fichier inexistant"
    exit 2
  fi

  archive=$RepLocalBak/sd-72079_$(echo $rep | awk -F"/" ' { for (i=2;i<=NF;i++) printf($i"-") }')_$datec.tar.bz2
  archiveold=$RepLocalBak/sd-72079_$(echo $rep | awk -F"/" ' { for (i=2;i<=NF;i++) printf($i"-") }')_$dateold.tar.bz2
  echo "> $archive"
  tar jcf $archive $rep
  openssl enc -in $archive -aes256 -pass pass:$PassEnc -out $archive.enc
  lftp -e "put $archive.enc ; quit" -u $FTPuser,$FTPpass $FTPserver
  lftp -e "rm $archiveold.enc ; quit" -u $FTPuser,$FTPpass $FTPserver
  rm $archive.enc $archiveold
  echo
done

#./bin/notif-backup-manager.sh # Notif SMS API Free Mobile

echo -e "\n"
exit 0
