> [!IMPORTANT]
> At the time of release, everything works 100%, but please note that API access, workarounds and libraries can be deprecated at any time.

![showcase](https://github.com/user-attachments/assets/0314d0d3-dbd7-4fd8-a712-00465affbbdc)

## Installation

Simply copy-paste the following command in Terminal and enter your user password:
```sh
git clone https://github.com/yioannides/fedora-resolve.git && cd fedora-resolve && chmod +x ./install.sh && sudo ./install.sh
```
- To install the Studio version*, add the optional argument `--studio` at the end of the script above.

<sup>* I don't own a Davinci Resolve Studio license, so I was not able to test anything past downloading its executable.

## Things to consider

### No mp4 import / AAC audio format

Due to licensing issues, it is not possible to import .mp4 files on the free Linux version of Davinci Resolve.<br>
Therefore, installing the free version of Resolve also includes:
- a transcoder script for batch conversion from .mp4 to .mov (via `ffmpeg`)
- an additional h.264 video encoder plugin (for exporting only)

To automatically batch-convert .mp4 videos to .mov: 
1. `cd` onto your project's media folder and
2. simply type `transcode`

All of the converted files will be on a new folder called "transcoded", inside your media folder. If you prefer .avi, find the transcode alias script in `~/.bashrc` and change all "mov" strings to "avi".

<sup>* please pay close attention to your disk space after converting to .avi and .mov, or else you might end up with hundreds of gigabytes worth of converted files!

### User fonts

If you want to use your own fonts in Davinci Resolve for text input, you have to copy them in your system's font folder: `usr/share/fonts`

Your local user font folder in `~/.fonts` won't be seen by Davinci Resolve.


## Acknowledgments

<b>Perfect Linux Gaming</b> for the h.264 export plugin : https://youtu.be/NoVQz79eSpw

<b>pobthebuilder's Python scripts</b> for auto-downloading Resolve : https://github.com/pobthebuilder/resolve-flatpak

Davinci Resolve, for helping me realize how terribly unoptimized it is on Linux and unironically helping me discover my current video editor of choice, <b>Lightworks</b> : https://lwks.com/
