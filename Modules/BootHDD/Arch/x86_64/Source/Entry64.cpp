#include <Device/Console.hpp>
#include <Device/IDT.hpp>
#include <Device/PIC.hpp>
#include <Device/Port.hpp>
#include <Device/PIT.hpp>
#include <Device/PS2Controller.hpp>
#include <Device/Keyboard.hpp>
#include <Device/PhysicalMemory.hpp>
#include <Device/VirtualMemory.hpp>
#include <Device/Memory.hpp>

using namespace Device;

extern "C" void Entry64(void) {
    Console::Print("Initializing Hardware\n");
}