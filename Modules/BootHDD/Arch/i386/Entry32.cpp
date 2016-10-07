#include <Console.hpp>
#include <ACPI.hpp>

extern "C" void Entry32(void) {
    Console console;
    ACPI acpi;

    uint16_t *vmem = (uint16_t *)(0xB8000);

    for (int i = 0; i < 25 * 80; i++) {
        *(vmem + i) = 0x0700;
    }

    if (acpi.Initialize()) {
        //*vmem = 0x4040;
    }
    else {
        //*vmem = 0x6060;
    }
}