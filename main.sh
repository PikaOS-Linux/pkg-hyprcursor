#! /bin/bash

DEBIAN_FRONTEND=noninteractive

set -e

apt-get update

# Dead PikaOS 3 Workaround
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
