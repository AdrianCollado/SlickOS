BootHDD_OBJINIT := Build/Arch-Objects/BootHDD/i8086/Init.asm.o

BootHDD_CFLAGS :=
BootHDD_CXXFLAGS := -std=c++11 -ffreestanding -Wall -Wextra -fno-exceptions -fno-rtti
BootHDD_CPPFLAGS := -IModules/BootHDD/Arch/x86_64/Include
BootHDD_ASFLAGS :=
BootHDD_LDFLAGS := -ffreestanding -nostdlib -lgcc