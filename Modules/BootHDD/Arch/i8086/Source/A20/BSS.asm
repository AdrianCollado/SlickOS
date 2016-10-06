//===========================================================================//
// Generic Loader for Operating System Software (GLOSS)                      //
//                                                                           //
// Copyright (C) 2015-2016 - Adrian J. Collado     <acollado@polaritech.net> //
//===========================================================================//

// Seeing how AT&T assembly syntax is much more verbose than Intel assembly
// syntax, the assembly language code in this project will use Intel syntax.
.intel_syntax noprefix

// This code will be executed in a 16 bit real mode environment.
.code16

// The following code is located in the .BSS (uninitialized variable) section
// of the binary.
.section .bss

.global BSS.A20
BSS.A20:
    .global BSS.A20.Status
    BSS.A20.Status:                                         .skip 0x01, 0x00
