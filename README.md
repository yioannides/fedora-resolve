# fedora-resolve

## Introduction

This is a Davinci Resolve auto-installation script for Fedora 40, that also includes AMD GPU fixes and a h.264 video encoder plugin fix (for exporting only).

The reason for creating this script is because everyone using (or wanting to use) Davinci Resolve on Linux knows how arduous of a process installing the aforementioned is, but also being able to use an AMD dGPU with Davinci Resolve on Linux requires you to tinker with system directories, something not recommended for the uninitiated.

## Installation instructions

Execute the following command in Terminal:
```sh
git clone https://github.com/yioannides/fedora-resolve.git && cd fedora-resolve && chmod +x ./install.sh && sudo ./install.sh
```
<sup>* include the argument `--studio` at the end of the script to download Davinci Resolve Studio instead

## Things to consider next

### No mp4 import / AAC audio format

As you might have read already, it is currently impossible to import mp4 files on the free Linux version of Davinci Resolve (not an issue on the Studio version), so you may want to use `ffmpeg` via RPM Fusion:
```sh
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install ffmpeg
```
Next, there are two ways to go about converting video formats:

- manual conversion of .mp4 files you want to work with to .avi or .mov via Terminal, for example:
```sh
ffmpeg -i raw_footage.mp4 -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov footage_mjpeg.mov
```
- batch conversion of .mp4 files in a folder to .avi or .mov via Terminal, for example:
```sh
for i in *.mp4; do ffmpeg -i "$i" "${i%.*}.avi"; done
```

Either way, you need to pay close attention to your disk space after converting to .avi and .mov, or else you might end up with hundreds of gigabytes worth of converted files.

### User fonts

If you want to use your own fonts in Davinci Resolve for text input, you have to copy all your fonts in your system's font folder: `usr/share/fonts`

Your local fonts installed in `/home/$USER/.fonts` won't be seen by Davinci Resolve.

## Conclusion

I wrote this shell script as a personal challenge (because I am not a programmer), but upon completing it, I realized how unoptimized (the free version of) Davinci Resolve for Linux is.

Surely figuring out how to properly install and use DR on Linux is a small victory in itself, but batch converting mp4 videos every time I want to drag and drop something in DR is not my idea of productivity and above all, the notion that a piece of software is this hard to install completely put me off.

With that said, I switched to Kdenlive and I'm currently very happy with it. I would also like to recommend [Lightworks](https://lwks.com/) that works great on Linux; it's very easy to install, offers a beautiful UI (very similar to DR) and has a great community for technical support. The free tier only offers 720p video export, but both Create and Pro tiers are cheaper than Davinci Resolve Studio, so it's something worth considering.

## Acknowledgments

Fedora 39 pixbuf / lippango fix → MiMillie : https://youtu.be/8jVTN1kLfZw

h.264 export plugin → Perfect Linux Gaming : https://youtu.be/NoVQz79eSpw
