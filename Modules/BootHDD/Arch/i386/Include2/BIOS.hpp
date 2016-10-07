#pragma once

namespace BIOS {
    struct DataArea {
        uint16_t COM1;
        uint16_t COM2;
        uint16_t COM3;
        uint16_t COM4;
        uint16_t LPT1;
        uint16_t LPT2;
        uint16_t LPT3;
        uint16_t EBDA;
        uint16_t PackedHardware;
        uint8_t Reserved1[5];
        uint16_t KeyboardFlags;
        uint8_t Reserved2[5];
        uint8_t KeyboardBuffer[32];
        uint8_t Reserved3[11];
        uint8_t DisplayMode;
        uint16_t TextModeColumns;
        uint8_t Reserved4[23];
    };
}