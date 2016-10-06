//===========================================================================//
// Generic Loader for Operating System Software (GLOSS)                      //
// Hard Disk Boot Loader Stage 2                                             //
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

// This code will be executed in a 32 bit protected mode environment.
.code32

// This code is located in the .text (executable) section of the binary.
.section .text

.global Boot32
Boot32:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    call Entry32

    mov edi, 0x2000000
    mov cr3, edi
    xor eax, eax
    mov ecx, 0x1000
    rep stosd
    mov edi, cr3

    mov dword ptr [edi], 0x2001003
    add edi, 0x1000
    mov dword ptr [edi], 0x2002003
    add edi, 0x1000

    mov ebx, 0x2003003
    mov ecx, 0x0200

    SetTEntry:
        mov dword ptr [edi], ebx
        add ebx, 0x1000
        add edi, 0x0008
        loop SetTEntry

    mov ebx, 0x00000003
    mov ecx, 0x00040000

    SetEntry:
        mov dword ptr [edi], ebx
        add ebx, 0x1000
        add edi, 0x0008
        loop SetEntry

    mov eax, cr4
    or eax, 1 << 5
    mov cr4, eax

    mov ecx, 0xC0000080
    rdmsr
    or eax, 1 << 8
    wrmsr

    mov eax, cr0
    or eax, 1 << 31
    mov cr0, eax

    lgdt [GDT64.End]
    jmp 0x08:Boot64

GDT64:
GDT64.Null:
    .word 0x0000
    .word 0x0000
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
GDT64.Code:
    .word 0x0000
    .word 0x0000
    .byte 0x00
    .byte 0x9A
    .byte 0x20
    .byte 0x00
GDT64.Data:
    .word 0x0000
    .word 0x0000
    .byte 0x00
    .byte 0x92
    .byte 0x00
    .byte 0x00
GDT64.End:
    .word (GDT64.End - GDT64 - 1)
    .quad GDT64
