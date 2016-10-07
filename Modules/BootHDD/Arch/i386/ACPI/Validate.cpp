#include <ACPI.hpp>
#include <Memory.hpp>

#include <Console.hpp>

bool ACPI::ValidateTable(void *ptr) {
    ACPI::Header *header = (ACPI::Header *)(ptr);
    uint8_t *structPtr = (uint8_t *)(ptr);
    uint8_t sum = 0;
    for (int i = 0; i < 36; i++) {
        sum += *(structPtr + i);
    }
    return (sum == 0);
}