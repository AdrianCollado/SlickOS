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

// The following code is located in the .DATA (initialized variable) section of
// the binary.
.section .data

.global I8086.CPU.GDT
I8086.CPU.GDT:
    .global I8086.CPU.GDT.Null
    I8086.CPU.GDT.Null:
        I8086.CPU.GDT.Null.Limit.Low:                     .word   0x0000
        I8086.CPU.GDT.Null.Base.Low:                      .word   0x0000
        I8086.CPU.GDT.Null.Base.Middle:                   .byte   0x00
        I8086.CPU.GDT.Null.Access:                        .byte   0x00
        I8086.CPU.GDT.Null.Flags:                         .byte   0x00
        I8086.CPU.GDT.Null.Base.High:                     .byte   0x00
    .global I8086.CPU.GDT.Code
    I8086.CPU.GDT.Code:
        I8086.CPU.GDT.Code.Limit.Low:                     .word   0xFFFF
        I8086.CPU.GDT.Code.Base.Low:                      .word   0x0000
        I8086.CPU.GDT.Code.Base.Middle:                   .byte   0x00
        I8086.CPU.GDT.Code.Access:                        .byte   0x9A
        I8086.CPU.GDT.Code.Flags:                         .byte   0xCF
        I8086.CPU.GDT.Code.Base.High:                     .byte   0x00
    .global I8086.CPU.GDT.Data
    I8086.CPU.GDT.Data:
        I8086.CPU.GDT.Data.Limit.Low:                     .word   0xFFFF
        I8086.CPU.GDT.Data.Base.Low:                      .word   0x0000
        I8086.CPU.GDT.Data.Base.Middle:                   .byte   0x00
        I8086.CPU.GDT.Data.Access:                        .byte   0x92
        I8086.CPU.GDT.Data.Flags:                         .byte   0xCF
        I8086.CPU.GDT.Data.Base.High:                     .byte   0x00
    .global I8086.CPU.GDT.Pointer
    I8086.CPU.GDT.Pointer:
        .equ I8086.CPU.GDT.Size, (I8086.CPU.GDT.Pointer - I8086.CPU.GDT - 1)
        I8086.CPU.GDT.Pointer.Limit:                      .word   I8086.CPU.GDT.Size
        I8086.CPU.GDT.Pointer.Base:                       .int    I8086.CPU.GDT
