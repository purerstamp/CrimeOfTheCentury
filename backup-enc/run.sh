#!/bin/bash
# Sauvegarde des données sous forme de TARBALL chiffrées AES-256.
# Le script réalise des archives TAR compressées BZIP2 et les stocke
# en local. Ensuite, une opération de chiffrement de ces archives
# est réalisée. En local, on ne conservera que les TARBALL non
# chiffrées. Les TARBALL chiffrées seront envoyées via FTP au
# serveur de backup.
#
# Ce fichier est l'exécutable. Veillez à ce que le fichier de
# configuration soit dans le même répertoire. N'oubliez pas de
# compléter ce dernier. Voir : config.sh
#
# # Codes d'erreur #
# 1 : Répertoire local de sauvegarde inexistant
# 2 : Répertoire ou fichier à sauvegarder inexistant
#
# Auteur : echodeltaFR <edouard@hello-community.fr>
# Version : 1.0
# Licence : GNU GPLv3 <https://www.gnu.org/licenses/gpl.html>
###########
. ./config.sh

if [ ! -d $RepLocalBak ] ; then
  echo "$RepLocalBak : Répertoire local de sauvegarde inexistant"
  exit 1
fi

for rep in $RepToBak ; do
  if [ ! -e $rep ] ; then
    echo "$rep : Répertoire ou fichier inexistant"
    exit 2
  fi

done
exit 0
