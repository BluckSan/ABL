#!/bin/bash

mkdir -p build

cd build

nasm -f bin ../boot.asm -o boot.bin
nasm -f bin ../stage2.asm -o stage2.bin

dd if=/dev/zero of=abl.img bs=512 count=2880
dd if=boot.bin of=abl.img conv=notrunc
dd if=stage2.bin of=abl.img bs=512 seek=1 conv=notrunc

mkdir -p iso/boot/grub
cp abl.img iso/

cat > iso/boot/grub/grub.cfg << EOF
set timeout=5
set default=0

menuentry "Android Boot Loader" {
    insmod part_msdos
    insmod ext2
    set root='(hd0,msdos1)'
    chainloader /abl.img
}

menuentry "Reboot" {
    reboot
}

menuentry "Shutdown" {
    halt
}
EOF

if command -v grub-mkrescue >/dev/null 2>&1; then
    grub-mkrescue -o abl.iso iso/
    echo "Build complete: abl.img and abl.iso created in build/"
else
    echo "Warning: grub-mkrescue not found, ISO creation skipped"
    echo "Build complete: abl.img created in build/"
fi

cd ..
