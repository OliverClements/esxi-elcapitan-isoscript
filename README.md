# Create a VMware ESXi 6+ bootable El Capitan / macOS Sierra Install .ISO

This is the first step in creating a Mac OS VM on an ESXi server (v6+)

This script is for Mac OS only, and needs to be run under sudo. `Install El Capitan` also needs to be downloaded and present in your `/Applications` directory. It can be acquired from the Mac App Store.

This basic script creates an .ISO by decompiling the `Install El Capitan` installation image so that it can be used on VMware ESXi 6+ servers as a boot/installation medium – once copied to the ESXi datastore.

ESXi requires *Unlocker 2.0.8* to be installed on the ESXi Server for this to work. Details can be found here – http://www.insanelymac.com/forum/files/file/339-unlocker/

# Usage

Download script and run `$ sudo ./make-esxi-elcap.sh`

Run the script anywhere and watch/wait/make a cup of tea (it takes about 10 minutes) – eventually `ElCapitan.iso` will appear on your desktop. 

*n.b Make sure you've got at least 20gb free on your system drive for these operations (the temporary volumes are deleted later, freeing up the space used).*

Once finished, copy `ElCapitan.iso` to your ESXi datastore.

# TODO

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


