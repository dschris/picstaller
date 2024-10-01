picstaller is a bash script that allows you to install AppImages with a user-friendly name and icon.

It does this by:

* Making the AppImage executable
* Moving the AppImage to /opt
* Downloading the icon
* Creating a desktop entry

## Installation

1. Move picstaller.sh to /usr/local/bin/picstaller
2. Make it executable
```bash
chmod +x /usr/local/bin/picstaller
```

## Note on Privileges

picstaller must be run with root privileges so that it can:
* make the AppImage executable
* move it to /opt
* create entries in /usr/share/applications.

## Usage

picstaller can be run either with a command-line argument:
```bash
sudo picstaller /path/to/AppImage
```
or by being run in interactive mode, in which case it will prompt for the path to the AppImage:
```bash
sudo picstaller
```


