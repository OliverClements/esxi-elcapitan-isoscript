# Create a VMware ESXi 6+ bootable El Capitan Install .ISO

A basic script to create an .ISO from the 'Install El Capitan' installation App – which is required to use this script – so that it can be used on VMware ESXi servers as a boot/installation medium.

ESXi requires Unlocker 2.0.8 to be installed for this to work – http://www.insanelymac.com/forum/files/file/339-unlocker/

# Usage

Simply run the script anywhere and watch/wait/make a cup of tea -- eventually an iso will appear on your desktop, ready for an ESXi datastore.

# To-Do

Figure out a better way to present user feedback because I am terrible at shell scripting

# Thanks

For the various folks on various forums that made the bits and pieces of this script. Here specifically: http://www.insanelymac.com/forum/topic/308533-how-to-create-a-bootable-el-capitan-iso-fo-vmware/

p.s. - script needs to be run under sudo.

p.p.s. - if this installer stalls on the VM when first loading (around 75%), you may need to add the following parameters to the VM:

`VM options -> Advanced -> Configuration parameters`

`ich7m.present	    true`
`smc.present	      true`
`smbios.reflectHost	true`

(from https://idmedia.no/general/installing-os-x-el-capitan-on-esxi/)


