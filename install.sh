tput clear
echo
echo -e "\033[97;44;1mDAVINCI RESOLVE INSTALLATION FOR FEDORA 39+ SCRIPT\033[0m"
echo -e "\033[1mby yiannis ioannides\033[0m"
echo
sleep 1

# installing prerequisites
sudo dnf install -y libxcrypt-compat libcurl libcurl-devel mesa-libGLU

# installing NVIDIA drivers
lspci | grep -qi "NVIDIA" && sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda

# installing rocm-opencl for AMD drivers
lspci | grep VGA -qi "AMD" && sudo dnf install -y rocm-opencl

# installing DaVinci Resolve
chmod +x ./*.run
./*.run -i -y

# resolving dependencies
cd /opt/resolve/libs
mkdir disabled-libraries
mv libglib-2.0.so* disabled-libraries/
sudo cp -f /usr/lib64/libglib-2.0.so.0.* /opt/resolve/libs/

# installing h.264 video encoder plugin (export only)
sudo cp -r '/home/$USER/fedora-resolve/h264/'* /opt/resolve/IOPlugins/

echo
echo "Installation completed!"
