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

.global BSS.Memory
BSS.Memory:
    .global BSS.Memory.Map
    BSS.Memory.Map:
        .global I8086_Memory_Map_Address
        .global BSS.Memory.Map.Address
        I8086_Memory_Map_Address:
        BSS.Memory.Map.Address:                             .skip 0x08, 0x00
        .global I8086_Memory_Map_Count
        .global BSS.Memory.Map.Count
        I8086_Memory_Map_Count:
        BSS.Memory.Map.Count:                               .skip 0x08, 0x00
        .global BSS.Memory.Map.End
        BSS.Memory.Map.End:                                 .skip 0x08, 0x00
