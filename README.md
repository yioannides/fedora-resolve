# fedora-resolve

## Introduction

This is a Davinci Resolve auto-installation script for Fedora 39, that also includes AMD GPU fixes and a h.264 video encoder plugin fix (for exporting only).

The reason for creating this script is because everyone using (or wanting to use) Davinci Resolve on Linux knows how arduous of a process installing the aforementioned is, but also being able to use an AMD dGPU with Davinci Resolve on Linux requires you to tinker with system directories, something not recommended for the uninitiated.

## Installation instructions

1. Clone this repo:
```
git clone https://github.com/yioannides/fedora-resolve.git
```
2. Register and download the [latest version of Davinci Resolve](https://www.blackmagicdesign.com/products/davinciresolve).

4. Unzip Davinci Resolve's .zip file.

5. Move the .run file to the `fedora-resolve` folder.

6. Back in the terminal, execute the following command (requires sudo):
```
cd fedora-resolve && sudo ./install.sh
```

## Things to consider next

As you might have read already, it is currently impossible to import mp4 files on the free Linux version of Davinci Resolve (not an issue on the Studio version), so you may want to use `ffmpeg` via RPM Fusion:
```
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install ffmpeg
```
Next, you'll have to manually convert every .mp4 file you want to work with to .mov via Terminal, here's an example below:
```
ffmpeg -i raw_footage.mp4 -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov footage_mjpeg.mov
```
