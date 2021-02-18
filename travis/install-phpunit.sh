#!/bin/bash
set -ex

BASE_PATH=$(pwd)
MW_INSTALL_PATH=$BASE_PATH/../mw

cd $MW_INSTALL_PATH

if [ "$PHPUNIT" != "" ]; then
  composer require 'phpunit/phpunit='$PHPUNIT --update-with-dependencies
fi
