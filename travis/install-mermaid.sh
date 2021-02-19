#!/bin/bash
set -ex

BASE_PATH=$(pwd)
MW_INSTALL_PATH=$BASE_PATH/../mw

cd $MW_INSTALL_PATH

if [ "$MERMAID" != "" ]; then
  # Install
  composer require 'mediawiki/mermaid='$MERMAID --update-with-dependencies

  # Configure
  echo 'wfLoadExtension( "Mermaid" );' >> LocalSettings.php
fi