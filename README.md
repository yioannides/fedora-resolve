# fedora-resolve

This is a Davinci Resolve auto-installation script for Fedora 39, that also includes AMD GPU fixes and a h.264 video encoder plugin fix (for exporting only).

The reason for creating this script is because not only anyone using (or wanting to use) Davinci Resolve on Linux knows how arduous of a process installing the aforementioned is, but being able to use an AMD dGPU with Davinci Resolve on Linux requires you to tinker with system directories that is not recommended for the uninitiated.

**INSTALLATION INSTRUCTIONS:**

1. Clone this repo:
```
git clone https://github.com/yioannides/fedora-resolve.git
```
2. Register and download the latest version of Davinci Resolve: https://www.blackmagicdesign.com/products/davinciresolve

3. Unzip Davinci Resolve's .zip and **move the .run file to the `fedora-resolve` folder**.

4. Back in the terminal, while inside `fedora-resolve`, execute the following command (requires sudo):
```
cd fedora-resolve
sudo ./install.sh
```
