#!/bin/bash

version="1.3.0"
release="1"

rm -rf build/
mkdir -p build/
git clone https://github.com/opinkerfi/adagios.git build/adagios-${version}
cd build/adagios-${version}
git checkout adagios-${version}-${release}

# Prepare source for RPM
cd ..
tar czf adagios-${version}.tar.gz adagios-${version}
cd -
# Prepare source for DEB
cp -r debian.upstream debian
sed -i "s/adagios (${version})/adagios (${version}-${release})/g" debian/changelog
patch -p1 < ../../kaji/kaji.patch
python setup.py build
rm -rf build/
cd ..

tar czf adagios_${version}.orig.tar.gz adagios-${version}
cd adagios-${version}

dpkg-buildpackage -tc -us -uc


# copy patches
#cp debian/patches/*.patch ../../../opensusebuildservice/home\:sfl-monitoring/shinken
# Copy spec file
cp ../adagios-${version}.tar.gz adagios.spec ../../
# copy deb files
cd ..
cp adagios*.changes adagios*.dsc adagios*.tar.xz adagios*.tar.gz ../
