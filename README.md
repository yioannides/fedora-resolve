# fedora-resolve

## Introduction

This is a Davinci Resolve auto-installation script for Fedora 40+, that also includes AMD GPU fixes, as well as a h.264 video encoder plugin fix (for exporting only) and a transcoding script for the free version of Resolve.

The reason for creating this script is because everyone using (or wanting to use) Davinci Resolve on Linux knows how arduous of a process installing the aforementioned is, but also being able to use an AMD dGPU with Davinci Resolve on Linux requires you to tinker with system directories, something not recommended for the uninitiated.

## Installation

Execute the following command in Terminal:
```sh
git clone https://github.com/yioannides/fedora-resolve.git && cd fedora-resolve && chmod +x ./install.sh && sudo ./install.sh
```
<sup>* to install the Studio version, add the optional argument `--studio` at the end of the script above

## Things to consider next

### No mp4 import / AAC audio format

Due to licensing issues, it is not possible to import mp4 files on the free Linux version of Davinci Resolve. 
Therefore, installing the free version of Resolve also includes:
- a transcoder script for batch conversion from .mp4 to .mov (via `ffmpeg`)
- an additional mp4 encoder plugin (for exporting only)

To automatically batch-convert .mp4 videos to .mov, simply `cd` onto your project's media folder and type `transcode`.
All of the converted files will be on a new folder called "transcoded", inside your media folder.
If you prefer .avi, find the transcode alias script in `~/.bashrc` and change all "mov" strings to "avi".

<sup>* please pay close attention to your disk space after converting to .avi and .mov, or else you might end up with hundreds of gigabytes worth of converted files!

### User fonts

If you want to use your own fonts in Davinci Resolve for text input, you have to copy all your fonts in your system's font folder: `usr/share/fonts`

Your local fonts installed in `/home/$USER/.fonts` won't be seen by Davinci Resolve.

## Conclusion

I started this shell script last year as a personal challenge (because I am not a programmer), but upon completing it, I realized how truly unoptimized Davinci Resolve for Linux is.

I personally use [Lightworks](https://lwks.com/) that works amazingly well on Linux; it's _factually_ supported natively on Linux (with both .rpm and .deb packages available), offers a beautiful Resolve-esque UI and has a great community for technical support. The free tier only offers 720p video export, but both Create and Pro tiers are cheaper than Davinci Resolve Studio, so it's something worth considering. Linux users deserve better, and Resolve on Linux just isn't it.

## Acknowledgments

h.264 export plugin → Perfect Linux Gaming : https://youtu.be/NoVQz79eSpw

pobthebuilder's Python scripts for auto-downloading Resolve : https://github.com/pobthebuilder/resolve-flatpak
