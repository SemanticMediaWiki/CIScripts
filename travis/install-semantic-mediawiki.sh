#!/bin/bash
set -ex

BASE_PATH=$(pwd)
MW_INSTALL_PATH=$BASE_PATH/../mw

if [ "$SMW" != "" ]; then
  cd $MW_INSTALL_PATH

  # Install
  composer require "mediawiki/semantic-media-wiki=$SMW" --update-with-dependencies

  # Configure
  echo 'wfLoadExtension( "SemanticMediaWiki" );' >> LocalSettings.php
  echo 'enableSemantics();' >> LocalSettings.php

  php maintenance/update.php --skip-external-dependencies --quick
fi