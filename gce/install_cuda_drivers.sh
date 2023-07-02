#!/bin/bash

# https://docs.nvidia.com/datacenter/tesla/tesla-installation-notes/index.html#ubuntu-lts

lspci | grep -i nvidia
sudo apt-get install linux-headers-$(uname -r)
distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
echo $distribution
wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb
sudo apt-get update
# sudo apt-get -y install cuda-drivers
sudo apt-get -y install cuda-runtime-12-1
echo 'export LD_LIBRARY_PATH="/usr/local/cuda/lib64"' >> ~/.bashrc  # TODO: if you already have LD_LIBRARY_PATH set

echo "run 'sudo reboot' to enable the driver"
