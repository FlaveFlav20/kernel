#!/usr/bin/env sh

KERNEL_BIN="kernel.elf" # Our bootable executable
KERNEL_ISO="kernel.iso"

echo "Generating $KERNEL_ISO from $KERNEL_BIN ..."

# Create a minimal boot partition for grub to be able to generate an iso file
mkdir -p ./iso/boot/grub
cp "$KERNEL_BIN" ./iso/boot

# Add a custom multiboot entry for grub to be able to boot our kernel
cat <<EOF > ./iso/boot/grub/grub.cfg
menuentry "Kernel - kernel" {
    multiboot /boot/$KERNEL_BIN
}
EOF

# Create the ISO file
grub-mkrescue -o "$KERNEL_ISO" ./iso
