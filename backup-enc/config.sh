#!/bin/bash
# Sauvegarde des données sous forme de TARBALL chiffrées AES-256.
# Le script réalise des archives TAR compressées BZIP2 et les stocke
# en local. Ensuite, une opération de chiffrement de ces archives
# est réalisée. En local, on ne conservera que les TARBALL non
# chiffrées. Les TARBALL chiffrées seront envoyées via FTP au
# serveur de backup.
#
# Ce fichier contient uniquement les paramètres.
#
# Auteur : Édouard LUMET <edouard@hello-community.fr>
# Version : 1.0
# Licence : GNU GPLv3 <https://www.gnu.org/licenses/gpl.html>
###########

## Répertoires à sauvegarder
## Ex: ('/etc' '/home' '/var/lib')
RepToBak=('')

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
