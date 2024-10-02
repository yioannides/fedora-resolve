#!/bin/bash

tput clear
echo
echo -e "\033[97;44;1mDAVINCI RESOLVE INSTALLATION FOR FEDORA 40+ SCRIPT\033[0m"
echo -e "\033[1mby yiannis ioannides\033[0m"
echo
sleep 1

# installing prerequisites
sudo dnf install -y libxcrypt-compat libcurl libcurl-devel mesa-libGLU --allowerasing

# installing NVIDIA drivers
lspci | grep -qi "NVIDIA" && sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda

# installing rocm for AMD drivers
lspci | grep -i "VGA" | grep -qi "AMD" && sudo dnf install -y rocm-opencl

# check if the first argument is --studio
STUDIO_ARG=""
if [[ "$1" == "--studio" ]]; then
    STUDIO_ARG="--studio"
fi

# downloading Davinci Resolve
python python/main.py $STUDIO_ARG

# installing DaVinci Resolve
chmod +x ./*.run
SKIP_PACKAGE_CHECK=1 ./*.run -i -y

# resolving dependencies
cd /opt/resolve/libs
mkdir disabled-libraries
sudo mv libglib* libgio* libgmodule* libgobject* disabled-libraries
# sudo cp -f /usr/lib64/libglib-2.0.so.0.* /opt/resolve/libs/

# installing h.264 encoder plugin (export only) & ffmpeg transcode script

USER_HOME=$(eval echo ~$SUDO_USER)

if [[ "$1" != "--studio" ]]; then
    sudo dnf install -y ffmpeg
    cp -r "$USER_HOME/fedora-resolve/h264/"* /opt/resolve/IOPlugins/
    echo 'alias transcode="mkdir -p transcoded; for i in *.mp4; do ffmpeg -i \"$i\" -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov \"transcoded/${i%.*}.mov\"; done"' >> "$USER_HOME/.bashrc"
fi

echo
echo "Installation completed!"
