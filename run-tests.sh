#!/bin/bash

jars=`echo /opt/eclipse/plugins/*.jar | sed 's~ ~:~g'`
bins=`echo /alpha/*/*/bin | sed 's~ ~:~g'`
pushd /alpha/tests/alpha.model.tests/

#java -cp $jars:$bins org.junit.runner.JUnitCore alpha.model.tests.AlphaAShowTest
