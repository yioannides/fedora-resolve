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

