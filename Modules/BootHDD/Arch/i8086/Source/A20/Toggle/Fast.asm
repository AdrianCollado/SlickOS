//===========================================================================//
// Generic Loader for Operating System Software (GLOSS)                      //
//                                                                           //
// The purpose of this file is to toggle the status of the A20 line          //
// extensions using the "Fast" A20 method (System Control Port 0x92)         //
//                                                                           //
// Copyright (C) 2015-2016 - Adrian J. Collado     <acollado@polaritech.net> //
//===========================================================================//

// Seeing how AT&T assembly syntax is much more verbose than Intel assembly
// syntax, the assembly language code in this project will use Intel syntax.
.intel_syntax noprefix

// This code will be executed in a 16 bit real mode environment.
.code16

// This code is located in the .TEXT (executable) section of the binary.
.section .text

.global I8086.A20.Toggle.Fast
I8086.A20.Toggle.Fast:
    // This function, while called the Fast A20 method, is actually quite slow
    // (although it is much faster than enabling the A20 line using the PS/2
    // keyboard controller), and on some systems is quite dangerous. This
    // function is the least recommended of all of the functions we use to
    // toggle the A20 line. What this function does is outputs a value through
    // system control port 0x92. The problem with this method is that on some
    // computers it is unsupported, and may do something entirely unexpected
    // (such as clearing the screen or eating your laundry). Therefore, we
    // should only use this method if we have no other choice.
    push ax
    in al, 0x92
    xor al, 0x02
    and al, 0xFE
    out 0x92, al
    pop ax
    ret
