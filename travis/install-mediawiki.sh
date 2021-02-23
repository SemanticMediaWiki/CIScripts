#!/bin/bash
set -ex

## Download
cd ..
wget https://github.com/wikimedia/mediawiki/archive/$MW.tar.gz
tar -zxf $MW.tar.gz
mv mediawiki-$MW mw

## Install
cd mw
if [ -f composer.json ]; then
  composer install
fi
if [ "$DB" == "postgres" ]; then
  psql -c 'create database its_a_mw;' -U postgres
  php maintenance/install.php --dbtype $DB --dbuser postgres --dbname its_a_mw --pass AdminPassword TravisWiki admin --scriptpath /TravisWiki
else
  mysql -e 'create database its_a_mw;'
  php maintenance/install.php --dbtype $DB --dbuser root --dbname its_a_mw --dbpath $(pwd) --pass AdminPassword TravisWiki admin --scriptpath /TravisWiki
fi

## Configure
echo 'error_reporting(E_ALL|E_STRICT);' >> LocalSettings.php
echo 'ini_set("display_errors", 1);' >> LocalSettings.php
echo '$wgShowExceptionDetails = true;' >> LocalSettings.php
echo '$wgDevelopmentWarnings = true;' >> LocalSettings.php
echo "putenv( 'MW_INSTALL_PATH=$(pwd)' );" >> LocalSettings.php

# Site language
if [ "$SITELANG" != "" ]
then
  echo '$wgLanguageCode = "'$SITELANG'";' >> LocalSettings.php
fi