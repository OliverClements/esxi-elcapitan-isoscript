# Create a VMware ESXi 6+ bootable El Capitan Install .ISO

A basic script to create an .ISO from the 'Install El Capitan' installation App – which is required to use this script – so that it can be used on VMware ESXi 6+ servers as a boot/installation medium once copied to the ESXi datastore.

ESXi requires Unlocker 2.0.8 to be installed on the ESXi Server for this to work. Details can be found here – http://www.insanelymac.com/forum/files/file/339-unlocker/

This script is for Mac OS only, and needs to be run under sudo.

# Usage

Download script
run `$ sudo ./make-esxi-elcap.sh`

Run the script anywhere and watch/wait/make a cup of tea (it takes about 10 minutes) – eventually an iso will appear on your desktop, ready for an ESXi datastore.

Make sure you've got at least 20gb free on your system drive.

# To-Do

Figure out a better way to present user feedback because I am terrible at shell scripting

# Thanks

For the various folks on various forums that made the bits and pieces of this script. Here specifically: http://www.insanelymac.com/forum/topic/308533-how-to-create-a-bootable-el-capitan-iso-fo-vmware/

# VM Installation Issues
If this installer stalls on the VM when first loading (around 75%), you may need to add the following parameters to the VM:

`VM options -> Advanced -> Configuration parameters`

`ich7m.present	    true`
`smc.present	      true`
`smbios.reflectHost	true`

(from https://idmedia.no/general/installing-os-x-el-capitan-on-esxi/)


