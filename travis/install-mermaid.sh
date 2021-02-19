#!/bin/bash
set -ex

BASE_PATH=$(pwd)
MW_INSTALL_PATH=$BASE_PATH/../mw

# Install
cd $MW_INSTALL_PATH
if [ "$MERMAID" != "" ]; then
  composer require 'mediawiki/mermaid='$MERMAID --update-with-dependencies
fi

# Configure
echo 'wfLoadExtension( "Mermaid" );' >> LocalSettings.php