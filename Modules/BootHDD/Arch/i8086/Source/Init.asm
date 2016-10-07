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

// This code will be executed in a 16 bit real mode environment.
.code16

// This code is located in the .text (executable) section of the binary.
.section .text

Boot16:
    mov eax, 0xb8000
    mov word ptr [eax], 0x4040
    //call I8086.Memory.ClearBSS
    //call I8086.Memory.Map
    //call I8086.A20.Enable
    //call I8086.CPU.Query
    //call I8086.CPU.GDT.Load

    //cmp byte ptr [BSS.A20.Status], 0x01
    //jmp Boot16.Failure

    //cli
    //mov eax, cr0
    //or al, 0x01
    //mov cr0, eax

    //jmp 0x08:Boot32
    
//Boot16.Failure:
    mov eax, 0xb8000
    mov word ptr [eax], 0x4040

Boot16.Failure.Loop:
    cli
    hlt
    jmp Boot16.Failure.Loop