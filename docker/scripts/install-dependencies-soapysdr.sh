#!/bin/bash
set -euxo pipefail

function cmakebuild() {
  cd $1
  mkdir build
  cd build
  cmake ..
  make
  make install
  cd ../..
  rm -rf $1
}

cd /tmp

STATIC_PACKAGES="udev"
BUILD_PACKAGES="git cmake make patch wget sudo gcc g++"

apk add --no-cache $STATIC_PACKAGES
apk add --no-cache --virtual .build-deps $BUILD_PACKAGES

git clone https://github.com/pothosware/SoapySDR
cmakebuild SoapySDR

git clone https://github.com/rxseger/rx_tools
cmakebuild rx_tools

apk del .build-deps
