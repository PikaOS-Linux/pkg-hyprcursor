#! /bin/bash

DEBIAN_FRONTEND=noninteractive

set -e

apt-get update

# Dead PikaOS 3 Workaround
wget http://archive.ubuntu.com/ubuntu/pool/universe/t/tomlplusplus/libtomlplusplus3t64_3.4.0+ds-0.2build1_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/universe/t/tomlplusplus/libtomlplusplus-dev_3.4.0+ds-0.2build1_amd64.deb
apt-install -y ./*libtoml*.deb
apt-get install libglib2.0-0=2.78.0-2 libglib2.0-bin=2.78.0-2 libglib2.0-dev-bin=2.78.0-2 -y --allow-downgrades

# Clone Upstream
git clone --recurse-submodules https://github.com/hyprwm/hyprcursor -b v0.1.9
cd hyprcursor
cp -rvf ../debian ./

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
