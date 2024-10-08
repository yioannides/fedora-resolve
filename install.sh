#!/bin/bash

tput clear
echo
echo -e "\033[97;44;1mDAVINCI RESOLVE INSTALLATION SCRIPT FOR LINUX\033[0m"
echo -e "\033[1mby yiannis ioannides\033[0m"
echo
sleep 1

# check if the first argument is --studio
STUDIO_ARG=""
if [[ "$1" == "--studio" ]]; then
    STUDIO_ARG="--studio"
fi

# distro-specific installs
DISTRO=$(lsb_release -is)
case "$DISTRO" in
    Ubuntu|Debian|Pop|Linuxmint|Elementary)
        sudo apt install libasound2t64 libaprutil1t64 libasound2t64 libglib2.0-0t64 libxcb-composite0 libxcb-cursor0
        ;;
    Fedora)
        sudo dnf install -y libxcrypt-compat libcurl libcurl-devel mesa-libGLU --allowerasing
        lspci | grep -qi "NVIDIA" && sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
	lspci | grep -i "VGA" | grep -qi "AMD" && sudo dnf install -y rocm-opencl
        ;;
    openSUSE)
        sudo zypper in -y libapr1-0 libapr-util1-0 libopencl-clang14 libopenCL1 mesa-libopenCL libpango-1_0-0 libpango1_0-0-32bit libpangomm-1_4-1 libpango-2_48-1
        ;;
    Arch|cachyos|ManjaroLinux|EndeavourOS)
        # placeholder for other distros
        ;;
esac

# downloading Davinci Resolve
python python/main.py $STUDIO_ARG

# installing DaVinci Resolve
chmod +x ./*.run
SKIP_PACKAGE_CHECK=1 ./*.run -i -y

# resolving dependencies
cd /opt/resolve/libs
mkdir disabled-libraries
sudo mv libglib* libgio* libgmodule* libgobject* disabled-libraries

# defining Home in sudo
USER_HOME=$(eval echo ~$SUDO_USER)

# installing h.264 encoder plugin (export only) & transcoder script
if [[ "$1" != "--studio" ]]; then
    cp -r "$USER_HOME/fedora-resolve/h264/" /opt/resolve/IOPlugins/
    if ! grep -q 'alias transcode=' "$USER_HOME/.bashrc"; then 
        echo 'alias transcode="mkdir -p transcoded; for i in *.mp4; do [ -f '$i' ] && echo 'Processing $i' && ffmpeg -i '$i' -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov 'transcoded/${i%.mp4}.mov'; done"' >> "$USER_HOME/.bashrc"
    fi
fi

# updater script
if ! grep -q 'alias resolve-update=' "$USER_HOME/.bashrc"; then 
    echo 'alias resolve-update="git clone https://github.com/yioannides/resolve-linux.git && cd fedora-resolve && chmod +x ./install.sh && sudo ./install.sh"' >> "$USER_HOME/.bashrc"
fi

echo
echo "Installation complete!"
