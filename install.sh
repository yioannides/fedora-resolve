tput clear
echo
echo -e "\033[97;44;1mDAVINCI RESOLVE INSTALLATION FOR FEDORA 39+ SCRIPT\033[0m"
echo -e "\033[1mby yiannis ioannides\033[0m"
echo
sleep 1

# installing prerequisites
sudo dnf install mesa-libGLU -y

# installing NVIDIA drivers
lspci | grep -qi "NVIDIA" && sudo dnf install -y akmod-nvidia

# installing rocm-opencl for AMD drivers
lspci | grep VGA -qi "AMD" && sudo dnf install -y rocm-opencl

# installing DaVinci Resolve
chmod +x ./*.run
./*.run -i -y

# resolving dependencies
cd /opt/resolve/libs
mkdir _disabled
mv libglib-2.0.so* _disabled/
sudo cp -f /usr/lib64/libglib-2.0.so.* /opt/resolve/libs/

# installing h.264 video encoder plugin (export only)
# sudo cp -r '$HOME/fedora-resolve/h264/'* /opt/resolve/IOPlugins/

echo
echo "Installation completed!"
