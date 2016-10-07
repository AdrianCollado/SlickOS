//===========================================================================//
// Generic Loader for Operating System Software (GLOSS)                      //
// Hard Disk Boot Sector                                                     //
//                                                                           //
// Copyright 2015-2016 - Adrian J. Collado         <acollado@polaritech.com> //
// All Rights Reserved                                                       //
//                                                                           //
// This file is licensed under the MIT license, see the LICENSE file in the  //
// root of this project for more information. If this file was not included  //
// with this project, see http://choosealicense.com/licenses/mit.            //
//===========================================================================//

// Seeing how AT&T assembly syntax is much more verbose than Intel assembly
// syntax, the assembly language code in this project will use Intel syntax.
.intel_syntax noprefix

// This code will be executed in a 16 bit real mode environment.
.code16

// This code is located in the .text (executable) section of the binary.
.section .text

// We need the size and location of stage 2 on the disk.
.equ STAGE2_SECTOR_SIZE,        100
.equ STAGE2_SECTOR_ADDRESS,     0x0001

// We define some constants.
.equ BOOT_DRIVE_OFFSET,         0x0000

.global BootEntry
BootEntry:
    jmp BootStart

BootStart:
    jmp 0x0000:BootReal

BootReal:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov sp, 0x7C00

    mov [0x0500 + BOOT_DRIVE_OFFSET], dl

    // Next we establish our stack frame.
    //push bp
    //mov bp, sp

    // Now we align the stack to the next lowest two-byte boundary.
    and sp, 0xFFFE

    // Next we construct the Disk Access Packet. We push the structure onto the
    // stack in reverse order, as the stack grows downward.
    push 0x0000
    push 0x0000
    push 0x0000
    push STAGE2_SECTOR_ADDRESS
    push 0x0000
    push 0x0600
    push STAGE2_SECTOR_SIZE
    push 0x0010

    // Now we load the address of the Disk Access Packet and store it in the SI
    // register. We then load the function number into the AH register.
    mov si, sp
    mov ah, 0x42

    // Now we execute the interrupt. If the function failed, the carry flag
    // will be set, and we will be unable to boot the bootsector.
    int 0x13

    // Now we store the carry flag in the AX register.
    pushf
    pop ax

    // We finally reset our stack frame.
    //mov sp, bp
    //pop bp

    mov eax, 0xb8000
    mov word ptr [eax], 0x4040

    // Now that our second stage is loaded, we can jump to it!
    jmp 0x0000:0x0600

.org 510
.word 0xAA55
