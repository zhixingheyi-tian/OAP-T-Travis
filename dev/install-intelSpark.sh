#!/usr/bin/env sh
set -ex

cd /tmp
git clone -b v2.4.4 https://github.com/Intel-bigdata/spark.git
cd spark
./build/mvn -q -Pyarn -Phadoop-3.2 -Dhadoop.version=3.2.0 -Dcheckstyle.skip=true -Dmaven.test.skip=true clean install
echo $(ls -R ~/.m2/repository/org/apache/spark/)
cd ${TRAVIS_BUILD_DIR}



