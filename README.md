# Aseprite Scripts
Miscellaneous LUA scripts for Aseprite

To use, download the .lua files and put them in [Aseprite's user script folder](https://community.aseprite.org/t/locate-user-scripts-folder/2170)

## Export Undo History to PNG
This script will export a PNG file for each undo entry in your Undo History. However, since there is no way to get that count programatically, you will be prompted for the count when the script runs. If you enter too high of a number, it will just generate duplicate images for the extra "undo" count
