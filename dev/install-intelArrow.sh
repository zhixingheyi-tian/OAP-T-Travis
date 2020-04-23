#!/usr/bin/env sh
set -ex

cd /tmp

#install vemecache
git clone https://github.com/pmem/vmemcache.git
cd vmemcache
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCPACK_GENERATOR=deb
make package
sudo dpkg -i libvmemcache*.deb
#popd
#install arrow and plasms
cd /tmp
# TODO change to Intel-bigdata one
git clone https://github.com/jikunshang/arrow-1.git
cd arrow-1 && git checkout rebase_oap_master
cd cpp
rm -rf release
mkdir release
cd release
#build libarrow, libplasma, libplasma_java
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="-g -O3" -DCMAKE_CXX_FLAGS="-g -O3" -DARROW_BUILD_TESTS=on -DARROW_PLASMA_JAVA_CLIENT=on -DARROW_PLASMA=on -DARROW_DEPENDENCY_SOURCE=BUNDLED ..
make -j$(nproc)
sudo make install -j$(nproc)
cd ../../java
mvn clean -q -DskipTests install

cd ${TRAVIS_BUILD_DIR}




