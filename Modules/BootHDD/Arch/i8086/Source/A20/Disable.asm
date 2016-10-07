//===========================================================================//
// Generic Loader for Operating System Software (GLOSS)                      //
//                                                                           //
// The purpose of this file is to diasble the A20 line extensions             //
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

.global I8086.A20.Disable
I8086.A20.Disable:
    // Our A20 line disabling function uses our toggle function in conjunction
    // with the check function to disable the A20 line for us. The first thing
    // we do, however, is store some state.
    push ax

    // Next we check the current A20 line value. We also set the A20 line
    // status flag in our flags variable to disabled (we will reset it later on
    // the off chance we cannot disable the A20 line).
    mov al, [BSS.A20.Status]
    and al, 0xFE
    mov [BSS.A20.Status], al
    call I8086.A20.Check
    jc I8086.A20.Disable.Exit

    // Now we attempt to toggle the A20 line value.
    call I8086.A20.Toggle
    jnc I8086.A20.Disable.Exit

    // If we reach this point, we were unable to disable the A20 line. We thus
    // set the A20 line value in or flags variable to enabled.
    mov al, [BSS.A20.Status]
    or al, 0x01
    mov [BSS.A20.Status], al

    I8086.A20.Disable.Exit:
        // The final thing we do is restore state and return ot the calling
        // function.
        pop ax
        ret
