# kernel
The goal of this repos is to understand how to work a kernel. The gistre site make me to begin: https://blog.gistre.epita.fr/posts/leo.duboin-2023-11-26-my_first_kernel/

Dependencies:  
    - binutils  
    - gcc  
    - libgcc  

Steps:  
    - i686-elf-gcc -c -ffreestanding crt0.S -o crt0.o  
    - i686-elf-gcc -c -ffreestanding kernel.c -o kernel.o  
    - i686-elf-gcc -fPIE crt0.o kernel.o -T ./linker.ld -nostdlib -o kernel.elf  
    - qemu-system-i386 -cdrom ./kernel.iso
