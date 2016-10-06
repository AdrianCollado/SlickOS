#include <ACPI.hpp>
#include <Memory.hpp>

ACPI::RSDP *ACPI::GetRSDP(void) {
    return m_RSDP;
}