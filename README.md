# Librain for X-Plane 11

Fork of [skiselkov](https://github.com/skiselkov)'s [librain](https://github.com/skiselkov/librain) repository with compilation improvements. **Requires [libacfutils from this forked repository](https://github.com/JT8D-17/libacfutils).** Will build the X-Plane plugin version of librain for Linux and Windows (via MingW). Please visit the [original repo](https://github.com/skiselkov/librain) for the original readme and data.

&nbsp;

**Note that this fork is intended for Arch Linux and any derived distro (like Manjaro). Package names and installation locations on other distros will vary.    
No Mac support!**

&nbsp;

## Requirements

- A build of [libacfutils](https://github.com/JT8D-17/libacfutils) with the parent `libacf` folder located in the same folder as this `librain` folder. Other locations require editing `build_all`.    
Consult the `libacfutils` documentation for build instructions.
- Packages: `mingw-w64-gcc`, `automake-1.15`, `gtk-doc`
- AUR package: [spirv-cross](https://aur.archlinux.org/packages/spirv-cross/)

&nbsp;

## Changes

- `zlib1.dll` and `libpng16-16.dll` are now shipped with the Windows release of the librain plugin.
- Added `build_all`, which triggers shader compilation, sets the path to `libacfutils` and triggers the `build` script in `plugin/qmake`
- Modified `build`, adding information about compilation progress; copies `zlib1.dll` and `libpng16-16.dll`from `libacfutils/dep_mingw64/bin` folder
- Added `plugin/qmake/build-lin`, which will only build the Linux release of `librain`. Edit `build_all` to use this!
- Edits to `plugin/qmake/qmake.pro`, reflecting changes made to the fork of `libacfutils`  and to fix build errors

&nbsp;

## Build tips

- Run `build_all` to build the plugin version of librain
- [Libacfutils](https://github.com/JT8D-17/libacfutils) **must** be built before librain!

&nbsp;

## Usage in X-Plane

As per the original documentation.