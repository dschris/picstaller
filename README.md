picstaller is a bash script that allows you to install AppImages with a user-friendly name and icon.

It does this by:

1. Making the AppImage executable
2. Moving the AppImage to /opt
3. Downloading the icon
4. Creating a desktop entry

## Installation

1. Move picstaller.sh to /usr/local/bin/picstaller
2. Make it executable
```bash
chmod +x /usr/local/bin/picstaller
```

## Note on Privileges

picstaller must be run with root privileges, so that it can make the AppImage executable and move it to /opt and create entries in /usr/share/applications.

## Usage

picstaller can be run either with a command-line argument:
```bash
sudopicstaller /path/to/AppImage
```
or by being run in interactive mode, in which case it will prompt for the path to the AppImage:
```bash
sudo picstaller
```

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

