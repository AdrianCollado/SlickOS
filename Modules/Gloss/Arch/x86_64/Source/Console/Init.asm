//===========================================================================//
// GLOSS - Generic Loader for Operating System Software                      //
// An extensible and configurable bootloader.                                //
//---------------------------------------------------------------------------//
// Copyright (C) 2013-2016 ~ Adrian J. Collado     <acollado@polaritech.com> //
// All Rights Reserved                                                       //
//===========================================================================//

// Seeing as how AT&T syntax is much more obscure and difficult to read (IMO)
// than Intel syntax, the assembly language code in this project for x86 based
// architectures will be using Intel syntax.
.intel_syntax noprefix

// This code will be executed in a 64 bit long mode environment.
.code64

// This code is located in the .TEXT (executable) section of the executable.
.section .text

.global AMD64.Console.Init
AMD64.Console.Init:
    mov di, offset AMD64.Console.Color.LightGray
    call AMD64.Console.SetForegroundColor
    mov di, offset AMD64.Console.Color.Black
    call AMD64.Console.SetBackgroundColor

    xor rdi, rdi
    call AMD64.Console.SetX
    call AMD64.Console.SetY

    mov qword ptr [AMD64.Console.VideoMemory], 0xB8000

    mov word ptr [AMD64.Console.TabWidth], 0x08

    ret