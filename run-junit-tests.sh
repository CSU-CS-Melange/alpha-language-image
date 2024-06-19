#!/bin/bash

if [[ -z $ALPHA_REPO_ROOT ]]; then
  ALPHA_REPO_ROOT=/alpha
  echo "ALPHA_REPO_ROOT not specified, defaulting to '$ALPHA_REPO_ROOT'"
fi
if [[ -z $TEST_PACKAGE ]]; then
  TEST_PACKAGE="alpha.model.tests"
  echo "TEST_PACKAGE not specified, defaulting to '$TEST_PACKAGE'"
fi
if [[ -z $JACOCO_PREFIX ]]; then
  JACOCO_PREFIX=/opt/jacoco/reports
  echo "JACOCO_PREFIX not specified, defaulting to '$JACOCO_PREFIX'"
fi

mkdir -p `basename $ALPHA_REPO_ROOT`
mkdir -p `basename $JACOCO_PREFIX`

ALPHA_REPO_ROOT=`realpath $ALPHA_REPO_ROOT`
JACOCO_PREFIX=`realpath $JACOCO_PREFIX`

# git requires that the current user be the owner of the files
# this occurs when the repo is mounted "into" a container
git config --global --add safe.directory $ALPHA_REPO_ROOT

if [[ -z $GITHUB_SHA ]]; then
  REV=$(git rev-parse HEAD)
else
  REV=$GITHUB_SHA
fi

bins=`echo $ALPHA_REPO_ROOT/*/*/bin | sed 's~ ~:~g'`
jars=`echo /opt/eclipse/plugins/*.jar | sed 's~ ~:~g'`
pushd $ALPHA_REPO_ROOT/tests/$TEST_PACKAGE/

JACOCO_DESTFILE=$JACOCO_PREFIX/jacoco-$REV-$TEST_PACKAGE.exec
java -javaagent:/opt/jacoco/lib/jacocoagent.jar=destfile=$JACOCO_DESTFILE -cp $bins:$jars org.junit.runner.JUnitCore $@
exit_code=$?

popd
exit $exit_code
