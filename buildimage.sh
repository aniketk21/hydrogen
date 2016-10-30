#!/bin/bash
sudo losetup /dev/loop0 references/grub.img
sudo mkdir /mnt/sos
sudo mount /dev/loop0 /mnt/sos
sudo cp hydrogen /mnt/sos/SOS
sudo sync
sudo umount /dev/loop0
sudo losetup -d /dev/loop0
