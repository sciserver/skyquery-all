#!/bin/bash
#git clone --recursive --branch v1.1/develop git@github.com:idies/skyquery-all.git

GRAYWULF="v1.2/develop"
SKYQUERY="v1.2/develop"
SHARPFITSIO="develop"
SPHERICAL="develop"

cd graywulf
git checkout -B $GRAYWULF remotes/origin/$GRAYWULF --

cd ../graywulf-build
git checkout -B $GRAYWULF remotes/origin/$GRAYWULF --

cd ../graywulf-plugins
git checkout -B $GRAYWULF remotes/origin/$GRAYWULF --

cd ../graywulf-tools
git checkout -B $GRAYWULF remotes/origin/$GRAYWULF --

cd ../graywulf-sciserver-init
git checkout -B $GRAYWULF remotes/origin/$GRAYWULF --

cd ../sharpfitsio
git checkout -B $SHARPFITSIO remotes/origin/$SHARPFITSIO --

cd ../skyquery
git checkout -B $SKYQUERY remotes/origin/$SKYQUERY --

cd ../skyquery-config
git checkout -B $SKYQUERY remotes/origin/$SKYQUERY --

cd ../skyquery-skynodes
git checkout -B $SKYQUERY remotes/origin/$SKYQUERY --

cd ../spherical
git checkout -B $SPHERICAL remotes/origin/$SPHERICAL --

cd ..