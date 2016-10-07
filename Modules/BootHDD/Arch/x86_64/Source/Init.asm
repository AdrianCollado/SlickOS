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

// This code will be executed in a 64 bit long mode environment.
.code64

// This code is located in the .text (executable) section of the binary.
.section .text

.global Boot64
Boot64:
    cli
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov rsp, 0x20000

    call AMD64.Console.Init

    mov word ptr [0xb8000], 0x4040

    cli

    call AMD64.IDT.Init
    call AMD64.IDT.Load
    call AMD64.PIC.Init

    sti

    call Entry64

    cli
    hlt
