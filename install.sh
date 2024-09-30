tput clear
echo
echo -e "\033[97;44;1mDAVINCI RESOLVE INSTALLATION FOR FEDORA 41+ SCRIPT\033[0m"
echo -e "\033[1mby yiannis ioannides\033[0m"
echo
sleep 1

# installing prerequisites
sudo dnf install -y libxcrypt-compat libcurl libcurl-devel mesa-libGLU --allowerasing

# installing NVIDIA drivers
lspci | grep -qi "NVIDIA" && sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda

# installing rocm for AMD drivers
lspci | grep VGA -qi "AMD" && config-manager --add-repo=http://repo.radeon.com/rocm/yum/rpm -y && sudo dnf install -y rocm

# downloading Davinci Resolve
python python/main.py

# installing DaVinci Resolve
chmod +x ./*.run
SKIP_PACKAGE_CHECK=1 ./*.run -i -y

# resolving dependencies
cd /opt/resolve/libs
mkdir disabled-libraries
sudo mv libglib* libgio* libmodule* libgobject* disabled-libraries
# sudo cp -f /usr/lib64/libglib-2.0.so.0.* /opt/resolve/libs/

# installing h.264 video encoder plugin (export only)
cp -r '/home/$USER/fedora-resolve/h264/'* /opt/resolve/IOPlugins/

echo
echo "Installation completed!"

# to edit
mkdir -p transcoded; for i in *.mp4; do ffmpeg -i "$i" -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov "transcoded/${i%.*}.mov"; done
