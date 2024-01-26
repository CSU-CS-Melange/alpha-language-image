#!/bin/bash

if [[ -z $ALPHA_REPO_ROOT ]]; then
  echo "ALPHA_REPO_ROOT environment variable must be set and pointing to the repository root directory"
  exit 1
fi

ALPHA_REPO_ROOT=`realpath $ALPHA_REPO_ROOT`

jars=`echo /opt/eclipse/plugins/*.jar | sed 's~ ~:~g'`
bins=`echo $ALPHA_REPO_ROOT/*/*/bin | sed 's~ ~:~g'`
pushd $ALPHA_REPO_ROOT/tests/alpha.model.tests/

if [[ -z $1 ]]; then
  java -cp $bins:$jars org.junit.runner.JUnitCore alpha.model.tests.*
else
  java -cp $bins:$jars org.junit.runner.JUnitCore $@
fi
