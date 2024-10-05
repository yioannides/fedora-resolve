#!/bin/bash

tput clear
echo
echo -e "\033[97;44;1mDAVINCI RESOLVE INSTALLATION SCRIPT FOR LINUX\033[0m"
echo -e "\033[1mby yiannis ioannides\033[0m"
echo
sleep 1

# distro-specific installs
DISTRO=$(lsb_release -is)
case "$DISTRO" in
    Ubuntu|Debian)
        sudo apt install libasound2t64 libaprutil1t64 libasound2t64 libglib2.0-0t64 libxcb-composite0 libxcb-cursor0
        ;;
    Fedora)
        sudo dnf install -y libxcrypt-compat libcurl libcurl-devel mesa-libGLU --allowerasing
        lspci | grep -qi "NVIDIA" && sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
	lspci | grep -i "VGA" | grep -qi "AMD" && sudo dnf install -y rocm-opencl
	if [[ "$1" != "--studio" ]]; then
   		sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
		sudo dnf install -y ffmpeg --allowerasing
	fi
        ;;
    *)
        # placeholder for other distros
        ;;
esac

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

# installing h.264 encoder plugin (export only) & transcoder script
USER_HOME=$(eval echo ~$SUDO_USER)

if [[ "$1" != "--studio" ]]; then
    cp -r "$USER_HOME/fedora-resolve/h264/" /opt/resolve/IOPlugins/
    if ! grep -q 'alias transcode=' "$USER_HOME/.bashrc"; then 
        echo 'alias transcode="mkdir -p transcoded; for i in *.mp4; do ffmpeg -i \"$i\" -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov \"transcoded/${i%.*}.mov\"; done"' >> "$USER_HOME/.bashrc"
    fi
fi

# updater script
if ! grep -q 'alias resolve-update=' "$USER_HOME/.bashrc"; then 
	echo 'alias resolve-update="git clone https://github.com/yioannides/resolve-linux.git && cd fedora-resolve && chmod +x ./install.sh && sudo ./install.sh"' >> "$USER_HOME/.bashrc"
fi

echo
echo "Installation complete!"
