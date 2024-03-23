#include "multiboot.h"

#define MULTIBOOT_HEADER_FLAGS (MULTIBOOT_PAGE_ALIGN | MULTIBOOT_MEMORY_INFO)

.section .multiboot
.align MULTIBOOT_HEADER_ALIGN
.long MULTIBOOT_HEADER_MAGIC
.long MULTIBOOT_HEADER_FLAGS
.long -(MULTIBOOT_HEADER_FLAGS + MULTIBOOT_HEADER_MAGIC)

/*
 * The stack, required by C functions and not defined by default.
 * Should be placed inside the stack pointer register (esp) inside
 * the start function.
 *
 * The x86 ABI requires the stack to be 16-byte aligned.
 */

#define STACK_SIZE 16384

.section .bss
.align 16
stack_bottom:
    .skip STACK_SIZE
stack_top:

/*
 * The entry point of our kernel (as defined in our linker script).
 *
 * This is the function called by the bootloader after detecting the
 * previously defined multiboot header (c.f. linker.ld).
 */

.section .text
.global _kernel_start
.type _kernel_start, @function

_kernel_start:

    // Initialize stack pointer
    mov $stack_top, %esp

    // Call our main function (yet to be implemented)
    call kernel_main

    // If we exit from the kernel, loop infinitely.

    cli
_kernel_exit_loop:
    hlt
    jmp _kernel_exit_loop

// Set the size of the _kernel_start symbol for debugging purposes
.size _kernel_start, . - _kernel_start
