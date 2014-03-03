#!/bin/bash

version="1.3.0"
release="1"

rm -rf build/
mkdir -p build/
git clone https://github.com/opinkerfi/adagios.git build/adagios-${version}
cd build/adagios-${version}
git checkout adagios-${version}-${release}

# Prepare source for DEB
cp -r ../../debian .
python setup.py build
rm -rf build/
cd ..

tar czf adagios_${version}+kaji.orig.tar.gz adagios-${version}
cd adagios-${version}

dpkg-buildpackage -tc -us -uc


# copy patches
#cp debian/patches/*.patch ../../../opensusebuildservice/home\:sfl-monitoring/shinken
# copy deb files
cd ..
cp adagios*.changes adagios*.dsc adagios*.tar.xz adagios*.tar.gz ../
