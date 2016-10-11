#!/bin/bash
clear
echo "----------------------------------------"
echo "macosSierra ISO GENERATOR FOR VMWARE ESXi"
echo "----------------------------------------"

echo ""
echo "----------------------------------------------------------"
echo "If you have installation problems (stalling at 75%, etc) then add the following to your VM Advanced settings:"
echo ""
echo "ich7m.present				true"
echo "smc.present				true"
echo "smbios.reflectHost		true"
echo ""
echo "----------------------------------------------------------"
echo ""
echo "Let's go!"
echo ""

# Mount the installer image from the macOS Sierra Install App

echo "Mount the installer image from the macOS Sierra Install App"
echo "----------------------------------------------------------"
echo ""
hdiutil attach /Applications/Install\ macOS\ Sierra.app//Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app
echo ""


# Create the macOS Sierra Blank ISO Image of 8500mb with a Single Partition - Apple Partition Map

echo "Create the macOS Sierra Blank ISO Image of 8500mb with a Single Partition - Apple Partition Map"
echo "----------------------------------------------------------"
echo ""
hdiutil create -o /tmp/macosSierra -size 8500m -layout SPUD -fs HFS+J -type SPARSE
echo ""

# Mount the macOS Sierra Blank ISO Image

echo "Mount the macOS Sierra Blank ISO Image"
echo "----------------------------------------------------------"
echo ""
hdiutil attach /tmp/macosSierra.sparseimage -noverify -nobrowse -mountpoint /Volumes/install_build
echo ""

# Restore the Base System into the macosSierra Blank ISO Image
echo "Restore the Base System into the macosSierra Blank ISO Image"
echo "----------------------------------------------------------"
echo ""
asr restore -source /Volumes/install_app/BaseSystem.dmg -target /Volumes/install_build -noprompt -noverify -erase
echo ""


# Remove Package link and replace with actual files
echo "Remove Package link and replace with actual files"
echo "----------------------------------------------------------"
echo ""
rm /Volumes/OS\ X\ Base\ System/System/Installation/Packages
echo ""
cp -rvp /Volumes/install_app/Packages /Volumes/OS\ X\ Base\ System/System/Installation/
echo ""

# Copy macOS Sierra installer dependencies

echo "Copy macOS Sierra installer dependencies"
echo "----------------------------------------------------------"
echo ""
cp -rvp /Volumes/install_app/BaseSystem.chunklist /Volumes/OS\ X\ Base\ System/BaseSystem.chunklist
echo ""
cp -rvp /Volumes/install_app/BaseSystem.dmg /Volumes/OS\ X\ Base\ System/BaseSystem.dmg
echo ""

 
# Unmount the installer image

echo "Unmount the installer image"
echo "----------------------------------------------------------"
echo ""
hdiutil detach /Volumes/install_app
echo ""

  
# Unmount the macosSierra ISO Image

echo "Unmount the macosSierra ISO Image"
echo "----------------------------------------------------------"
echo ""
hdiutil detach /Volumes/OS\ X\ Base\ System/
echo ""

# Not quite sure what this does, removing for now.
hdiutil resize -size `hdiutil resize -limits /tmp/macosSierra.sparseimage | tail -n 1 | awk '{ print $1 }'`b /tmp/macosSierra.sparseimage
 
# Convert the macosSierra ISO Image to ISO/CD master

echo "Convert the ElCapitan ISO Image to ISO/CD master"
echo "----------------------------------------------------------"
echo ""
hdiutil convert /tmp/macosSierra.sparseimage -format UDTO -o /tmp/macosSierra.iso
echo ""


# Rename the macOS Sierra ISO Image and move it to the desktop

echo "Rename the macOS Sierra ISO Image and move it to the desktop"
echo "----------------------------------------------------------"
echo ""
mv -v /tmp/macosSierra.iso.cdr ~/Desktop/macosSierra.iso
echo ""


# Clean up - delete sparseimage if it still exists.
echo "Clean up - delete sparseimage if it still exists."
echo "----------------------------------------------------------"
echo ""
rm /tmp/macosSierra.sparseimage
echo ""
echo "----------------------------------------------------------"
echo "All operations complete!"
echo "----------------------------------------------------------"
echo ""