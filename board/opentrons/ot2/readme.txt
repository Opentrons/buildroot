Opentrons OT2

Intro
=====
This is the board directory for the Opentrons OT2’s system.

How to build it
===============

Configure Buildroot
-------------------

  # make opentronsot2_defconfig

Build the rootfs
----------------

Note: you will need to have access to the network, since Buildroot will
download the packages' sources.

You may now build your rootfs with:

  $ make

(This may take a while, consider getting yourself a coffee ;-) )

Result of the build
-------------------

After building, you should obtain this tree:

    output/images/
    +-- bcm2708-rpi-b.dtb           [1]
    +-- bcm2708-rpi-b-plus.dtb      [1]
    +-- bcm2709-rpi-2-b.dtb         [1]
    +-- bcm2710-rpi-3-b.dtb         [1]
    +-- bcm2710-rpi-3-b-plus.dtb    [1]
    +-- boot.vfat
    +-- rootfs.ext4
    +-- rpi-firmware/
    |   +-- bootcode.bin
    |   +-- cmdline.txt
    |   +-- config.txt
    |   +-- fixup.dat
    |   +-- start.elf
    |   `-- overlays/               [2]
    +-- sdcard.img
    `-- zImage


How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Insert the SDcard into the Raspberry Pi, on the OT2 and power it up. Your
new system should come up now (though without the Opentrons API server)
and start a serial console.
