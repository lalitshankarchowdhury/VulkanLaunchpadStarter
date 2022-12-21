#!/bin/bash
set -e -o pipefail

apt update && apt upgrade -y && apt install -y wget sudo gpg lsb-release software-properties-common

wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
sudo rm /etc/apt/trusted.gpg.d/kitware.gpg && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6AF7F09730B3F0A4
sudo apt-add-repository -y "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main"
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo add-apt-repository -y ppa:oibaf/graphics-drivers
wget -qO- https://packages.lunarg.com/lunarg-signing-key-pub.asc | tee /etc/apt/trusted.gpg.d/lunarg.asc
wget -qO /etc/apt/sources.list.d/lunarg-vulkan-jammy.list http://packages.lunarg.com/vulkan/lunarg-vulkan-jammy.list

sudo apt update && sudo apt upgrade -y && sudo apt install -y  g++ gdb make ninja-build rsync zip kitware-archive-keyring cmake libassimp-dev g++-11 libvulkan-dev libvulkan1 mesa-vulkan-drivers vulkan-tools vulkan-sdk dpkg-dev libvulkan1-dbgsym vulkan-tools-dbgsym libglfw3 libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev libglew-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev
sudo apt clean all

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 60 --slave /usr/bin/g++ g++ /usr/bin/g++-11

echo ""
echo "Now running \"vulkaninfo\" to see if vulkan has been installed successfully:"
vulkaninfo