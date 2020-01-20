#!/bin/sh

raspi_fs_init() {

  image_path="/sdcard/filesystem.img"
  zip_path="/filesystem.zip"

  if [ ! -e $image_path ]; then
    echo "No filesystem detected at ${image_path}!"
    if [ -e $zip_path ]; then
        echo "Extracting fresh filesystem..."
        unzip $zip_path
        mv *.img $image_path
	rm $zip_path
    else
      exit 1
    fi
  fi
}

if [ ! -e /raspi-init ]; then
  touch /raspi-init
  raspi_fs_init
  echo "Initiating Expect..."
  /usr/bin/expect /pi_ssh_enable.exp `hostname -I`
  echo "Expect Ended..."
else
  /usr/local/bin/qemu-system-arm \
	--machine versatilepb \
	--cpu arm1176 \
	--m 256M \
	--hda /sdcard/filesystem.img \
	--net nic \
	--net user,hostfwd=tcp:`hostname -I`:2222-:22 \
	--dtb /root/qemu-rpi-kernel/versatile-pb.dtb \
	--kernel /root/qemu-rpi-kernel/kernel-qemu-4.19.50-buster \
	--append "root=/dev/sda2 panic=1" \
	--no-reboot \
	--display none \
	--serial mon:stdio
fi
