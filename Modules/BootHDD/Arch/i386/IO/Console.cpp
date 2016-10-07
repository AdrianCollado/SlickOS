#include <Console.hpp>

void Console::Print(const char *val) {
    while (*val != 0x00) {
        Console::Print(*val);
        val++;
    }
}

void Console::Print(char val) {
    uint16_t *screenAddress = m_ScreenBuffer + (m_YScreen * m_XMax) + m_XScreen;

    *screenAddress = (val | m_TerminalColor << 8);
    m_XScreen++;
}

void Console::Print(uint32_t val) {
    if (val == 0) {
        Console::Print('0');
        return;
    }

    int32_t num = val;
    char reversed[32];
    int i = 0;
    while (num > 0) {
        reversed[i] = '0' + num % 10;
        num /= 10;
        i++;
    }
    reversed[i] = 0;

    char actual[32];
    actual[i--] = 0;
    int j = 0;
    while(i >= 0) {
        actual[i--] = reversed[j++];
    }
    Console::Print(actual);
}

Console::Console(void) : m_ScreenBuffer((uint16_t *)0xB8000), m_XScreen(0), m_YScreen(0), m_TerminalColor(0x07), m_XMax(80), m_YMax(25) {}
Console::~Console(void) {}