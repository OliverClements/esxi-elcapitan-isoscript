#!/bin/bash

echo "----------------------------------------"
echo "EL CAPITAN ISO GENERATOR FOR VMWARE ESXi"
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

# Mount the installer image from the El Capitan Install App

echo "Mount the installer image from the El Capitan Install App"
echo "----------------------------------------------------------"
echo "$ hdiutil attach /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app"
echo ""
hdiutil attach /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app
echo ""


# Create the El Capitan Blank ISO Image of 8500mb with a Single Partition - Apple Partition Map

echo "Create the El Capitan Blank ISO Image of 8500mb with a Single Partition - Apple Partition Map"
echo "----------------------------------------------------------"
echo "$ hdiutil create -o /tmp/ElCapitan -size 8500m -layout SPUD -fs HFS+J -type SPARSE"
echo ""
hdiutil create -o /tmp/ElCapitan -size 8500m -layout SPUD -fs HFS+J -type SPARSE
echo ""

# Mount the El Capitan Blank ISO Image

echo "Mount the El Capitan Blank ISO Image"
echo "----------------------------------------------------------"
echo "$ hdiutil attach /tmp/ElCapitan.sparseimage -noverify -nobrowse -mountpoint /Volumes/install_build"
echo ""
hdiutil attach /tmp/ElCapitan.sparseimage -noverify -nobrowse -mountpoint /Volumes/install_build
echo ""

# Restore the Base System into the ElCapitan Blank ISO Image
echo "Restore the Base System into the ElCapitan Blank ISO Image"
echo "----------------------------------------------------------"
echo "$ asr restore -source /Volumes/install_app/BaseSystem.dmg -target /Volumes/install_build -noprompt -noverify -erase"
echo ""
asr restore -source /Volumes/install_app/BaseSystem.dmg -target /Volumes/install_build -noprompt -noverify -erase
echo ""


# Remove Package link and replace with actual files
echo "Remove Package link and replace with actual files"
echo "----------------------------------------------------------"
echo "$ rm /Volumes/OS\ X\ Base\ System/System/Installation/Packages"
rm /Volumes/OS\ X\ Base\ System/System/Installation/Packages
echo "$ cp -rvp /Volumes/install_app/Packages /Volumes/OS\ X\ Base\ System/System/Installation/"
echo ""
echo ""
cp -rvp /Volumes/install_app/Packages /Volumes/OS\ X\ Base\ System/System/Installation/
echo ""
echo ""


# Copy El Capitan installer dependencies

echo "Copy El Capitan installer dependencies"
echo "----------------------------------------------------------"
echo "$ cp -rvp /Volumes/install_app/BaseSystem.chunklist /Volumes/OS\ X\ Base\ System/BaseSystem.chunklist"
echo ""
cp -rvp /Volumes/install_app/BaseSystem.chunklist /Volumes/OS\ X\ Base\ System/BaseSystem.chunklist
echo ""
echo "$ cp -rvp /Volumes/install_app/BaseSystem.dmg /Volumes/OS\ X\ Base\ System/BaseSystem.dmg"
echo ""
cp -rvp /Volumes/install_app/BaseSystem.dmg /Volumes/OS\ X\ Base\ System/BaseSystem.dmg
echo ""

 
# Unmount the installer image

echo "Unmount the installer image"
echo "----------------------------------------------------------"
echo "	$ hdiutil detach /Volumes/install_app"
echo ""
hdiutil detach /Volumes/install_app
echo ""

  
# Unmount the ElCapitan ISO Image

echo "Unmount the ElCapitan ISO Image"
echo "----------------------------------------------------------"
echo "$ hdiutil detach /Volumes/OS\ X\ Base\ System/"
echo ""
hdiutil detach /Volumes/OS\ X\ Base\ System/
echo ""

# Not quite sure what this does, removing for now.
## hdiutil resize -size `hdiutil resize -limits /tmp/ElCapitan.sparseimage | tail -n 1 | awk '{ print $1 }'`b /tmp/ElCapitan.sparseimage
 
# Convert the ElCapitan ISO Image to ISO/CD master

echo "Convert the ElCapitan ISO Image to ISO/CD master"
echo "----------------------------------------------------------"
echo "$ hdiutil convert /tmp/ElCapitan.sparseimage -format UDTO -o /tmp/ElCapitan.iso"
echo ""
hdiutil convert /tmp/ElCapitan.sparseimage -format UDTO -o /tmp/ElCapitan.iso
echo ""


# Rename the El Capitan ISO Image and move it to the desktop

echo "Rename the El Capitan ISO Image and move it to the desktop"
echo "----------------------------------------------------------"
echo "$ mv -v /tmp/ElCapitan.iso.cdr ~/Desktop/ElCapitan.iso"
echo ""
mv -v /tmp/ElCapitan.iso.cdr ~/Desktop/ElCapitan.iso
echo ""


# Clean up - delete sparseimage if it still exists.
echo "Clean up - delete sparseimage if it still exists."
echo "----------------------------------------------------------"
echo "$ rm /tmp/ElCapitan.sparseimage"
echo ""
rm /tmp/ElCapitan.sparseimage
echo ""
echo "----------------------------------------------------------"
echo "All operations complete!"
echo "----------------------------------------------------------"
echo ""