# Librain for X-Plane 11

Fork of [skiselkov](https://github.com/skiselkov)'s [librain](https://github.com/skiselkov/librain) repo fixing build errors on Arch Linux. Requires [libacfutils from this forked repository](https://github.com/JT8D-17/libacfutils). Will build the X-Plane plugin version of librain for Linux and Windows (via MingW). Please visit the [original repo](https://github.com/skiselkov/librain) for the original readme and data.

&nbsp;

**Note that this fork is intended for Arch Linux and any derived distro (like Manjaro). Package names and installation locations on other distros will vary.    
No Mac support, sorry!**

&nbsp;

## Requirements

- A build of [libacfutils](https://github.com/JT8D-17/libacfutils) with the parent `libacf` folder located in the same folder as this `librain` folder. Other locations require editing `build_all`.
- AUR package: [spirv-cross](https://aur.archlinux.org/packages/spirv-cross/)

&nbsp;

## Changes

- Added `build_all`, which triggers shader compilation, sets the path to `libacfutils` and triggers the `plugin/qmake/build`


&nbsp;

## Build tips

- Run `build_all` to build the plugin version of librain
- Libacfutils](https://github.com/JT8D-17/libacfutils) **must** be built before librain!

