#pragma once

#include <stdint.h>

class ACPI {
public:
    struct RSDP {
        char Signature[8];
        uint8_t Checksum;
        char OEMID[6];
        uint8_t Revision;
        uint32_t RSDTAddress;
    } __attribute__((packed));

    // struct XSDP : public RSDP {
    //     uint32_t Length;
    //     uint64_t XSDTAddress;
    //     uint8_t TotalChecksum;
    //     uint8_t Reserved[3];
    // } __attribute__((packed));

    struct Header {
        char Signature[4];
        uint32_t Length;
        uint8_t Revision;
        uint8_t Checksum;
        char OEMID[6];
        char OEMTableID[8];
        char OEMRevision[4];
        char CreatorID[4];
        char CreatorRevision[4];
    } __attribute__((packed));

    struct RSDT : public Header {
        uint32_t *Entries;
    } __attribute__((packed));

    // struct XSDT : public Header {
    //     uint64_t *Entries;
    // } __attribute__((packed));

    struct FADT : public Header {

    } __attribute__((packed));

    bool Initialize(void);

    RSDP *GetRSDP(void);
    //XSDT *GetXSDT(void);
    FADT *GetFADT(void);

private:
    bool ValidateTable(void *ptr);

    RSDP *m_RSDP;
    //XSDP *m_XSDP;

    RSDT *m_RSDT;
    //XSDT *m_XSDT;
    FADT *m_FADT;
};