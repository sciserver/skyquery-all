$GRAYWULF="v1.4/develop"
$SKYQUERY="v1.4/develop"
$FOOTPRINT="v2.0/develop"
$SHARPFITSIO="v1.1/develop"
$SPHERICAL="v2.1/develop"
$SCISERVER="skyquery-v1.4"

cd modules

cd graywulf
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

cd ../skyquery-python-client
git checkout -B $SKYQUERY remotes/origin/$SKYQUERY --

cd ../spherical
git checkout -B $SPHERICAL remotes/origin/$SPHERICAL --

cd ../sciserver-logging
git checkout -B $SCISERVER remotes/origin/$SCISERVER --

cd ../footprint
git checkout -B $FOOTPRINT remotes/origin/$FOOTPRINT --

cd ../footprint-config
git checkout -B $FOOTPRINT remotes/origin/$FOOTPRINT --

cd ../sharpastrolib
git checkout -B v1.0/develop remotes/origin/v1.0/develop --

cd ../sharpvolibs
git checkout -B v1.0/develop remotes/origin/v1.0/develop --

cd ../..