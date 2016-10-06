#include <ACPI.hpp>
#include <Memory.hpp>
#include <Console.hpp>

bool ACPI::Initialize(void) {
    Console cons;
    // Find the RSDP/XSDP
    uint8_t *ptr = (uint8_t *)(0x0000);
    uint64_t sig = 0x2052545020445352;
    for (int i = 0; i < 0xFFFFF; i += 16) {
        if (Memory::Equal(ptr + i, &sig, 8)) {
            RSDP *rsdp = (RSDP *)(ptr + i);
            if (rsdp->Revision == 0) {
                uint8_t *structPtr = (uint8_t *)(rsdp);
                uint8_t val = 0;
                for (int i = 0; i < 20; i++) {
                    val += *(structPtr + i);
                }
                if (val == 0) {
                    m_RSDP = rsdp;
                    m_XSDP = nullptr;
                }
            }
            else {
                uint8_t *structPtr = (uint8_t *)(rsdp);
                uint8_t val = 0;
                for (int i = 0; i < 36; i++) {
                    val += *(structPtr + i);
                }
                if (val == 0) {
                    m_RSDP = rsdp;
                    m_XSDP = (XSDP *)(rsdp);
                    break;
                }
            }
        }
    }

    char arr[7];
    Memory::Copy((uint8_t *)arr, (uint8_t *)m_RSDP->OEMID, 6);
    arr[6] = 0;

    cons.Print((uint32_t)m_RSDP);
    cons.Print(" - ");
    cons.Print((uint32_t)m_RSDP->Checksum);
    cons.Print(" - ");
    cons.Print(arr);
    cons.Print(" - ");
    cons.Print((uint32_t)m_RSDP);
    cons.Print(" - ");
    cons.Print((uint32_t)m_RSDP->Revision);
    cons.Print(" - ");
    cons.Print((uint32_t)m_RSDP->RSDTAddress);

    if (m_RSDP == nullptr) return false;

    if (m_RSDP->Revision == 0) {
        return false;
    }
    else {
        // uint64_t addr = m_XSDP->XSDTAddress;
        // m_XSDT = (XSDT *)(addr);
        //if (!ValidateTable(m_XSDT)) return false;
    }

    return true;
}