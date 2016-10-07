#pragma once

#include <stdint.h>

namespace Memory {
    inline bool Equal(const void *lhs, const void *rhs, uint64_t count) {
        const uint8_t* a = (const uint8_t*) lhs;
        const uint8_t* b = (const uint8_t*) rhs;
        for (uint32_t i = 0; i < count; i++) {
            if (a[i] < b[i])
                return false;
            else if (b[i] < a[i])
                return false;
        }
        return true;
    }

    inline void Set(uint8_t *dest, uint8_t value, uint64_t count) {
        for (int i = 0; i < count; i++) {
            *dest++ = value;
        }
    }

    inline void Copy(uint8_t *dest, uint8_t *src, uint64_t count) {
        if (dest == src) return;
        for (int i = 0; i < count; i++) {
            *dest++ = *src++;
        }
    }

    inline void Move(uint8_t *dest, uint8_t *src, uint64_t count) {
        Copy(dest, src, count);
    }
}