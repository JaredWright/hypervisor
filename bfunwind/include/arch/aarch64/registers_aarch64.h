//
// Bareflank Unwind Library
// Copyright (C) 2018 Assured Information Security, Inc.
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

#ifndef REGISTERS_AARCH64_H
#define REGISTERS_AARCH64_H

#include <log.h>
#include <abort.h>
#include <registers.h>

#if (MAX_NUM_REGISTERS < 65)
#error MAX_NUM_REGISTERS was set too low
#endif

// -----------------------------------------------------------------------------
// Load / Store Registers
// -----------------------------------------------------------------------------

#pragma pack(push, 1)

struct registers_aarch64_t {
    // Shared register numbers:
    // IP1 = 17
    // LR = 30
    uint64_t x[31];
    uint64_t sp;
    // We don't save these, but they have defined register numbers so
    // we want to skip the right number of spaces anyway.
    uint64_t v[32];
    uint64_t ip;
};

#pragma pack(pop)

/// __store_registers_aarch64
///
/// Stores the state of the registers into a structure
///
/// @param state the register state to store state too
/// @return always returns 0
///
extern "C"
void __store_registers_aarch64(registers_aarch64_t *state);

/// __load_registers_aarch64
///
/// Restores the state of the registers from a structure
///
/// @param state the register state to store state too
/// @return always returns 0
///
extern "C"
void __load_registers_aarch64(registers_aarch64_t *state);

// -----------------------------------------------------------------------------
// Register State
// -----------------------------------------------------------------------------
//
// Defines the register state for aarch64.
//
// See register.h for more information
//

class register_state_aarch64 : public register_state
{
public:
    register_state_aarch64(const registers_aarch64_t &registers) :
        m_registers(registers),
        m_tmp_registers(registers)

    { }

    ~register_state_aarch64() override = default;

    register_state_aarch64(register_state_aarch64 &&) noexcept = default;
    register_state_aarch64(const register_state_aarch64 &) = default;

    register_state_aarch64 &operator=(register_state_aarch64 &&) noexcept = default;
    register_state_aarch64 &operator=(const register_state_aarch64 &) = default;

    uint64_t get_ip() const override
    { return m_registers.ip; }

    register_state &set_ip(uint64_t value) override
    {
        m_tmp_registers.ip = value;
        return *this;
    }

    uint64_t get(uint64_t index) const override
    {
        if (index >= max_num_registers()) {
            ABORT("register index out of bounds");
        }

        return reinterpret_cast<const uint64_t *>(&m_registers)[index];
    }

    register_state &set(uint64_t index, uint64_t value) override
    {
        if (index >= max_num_registers()) {
            ABORT("register index out of bounds");
        }

        reinterpret_cast<uint64_t *>(&m_tmp_registers)[index] = value;

        return *this;
    }

    void commit() override
    { m_registers = m_tmp_registers; }

    void commit(uint64_t cfa) override
    {
        m_tmp_registers.sp = cfa;
        commit();
    }

    void resume() override
    { __load_registers_aarch64(&m_registers); }

    uint64_t max_num_registers() const override
    { return 68; }

    const char *name(uint64_t index) const override
    {
        if (index >= max_num_registers()) {
            ABORT("register index out of bounds");
        }

        switch (index) {
            case 0x00: return "x0";
            case 0x01: return "x1";
            case 0x02: return "x2";
            case 0x03: return "x3";
            case 0x04: return "x4";
            case 0x05: return "x5";
            case 0x06: return "x6";
            case 0x07: return "x7";
            case 0x08: return "x8";
            case 0x09: return "x9";
            case 0x0a: return "x10";
            case 0x0b: return "x11";
            case 0x0c: return "x12";
            case 0x0d: return "x13";
            case 0x0e: return "x14";
            case 0x0f: return "x15";
            case 0x10: return "x16";
            case 0x11: return "x17";
            case 0x12: return "x18";
            case 0x13: return "x19";
            case 0x14: return "x20";
            case 0x15: return "x21";
            case 0x16: return "x22";
            case 0x17: return "x23";
            case 0x18: return "x24";
            case 0x19: return "x25";
            case 0x1a: return "x26";
            case 0x1b: return "x27";
            case 0x1c: return "x28";
            case 0x1d: return "x29";
            case 0x1e: return "lr";
            case 0x1f: return "sp";
            case 0x20: return "v0";
            case 0x21: return "v1";
            case 0x22: return "v2";
            case 0x23: return "v3";
            case 0x24: return "v4";
            case 0x25: return "v5";
            case 0x26: return "v6";
            case 0x27: return "v7";
            case 0x28: return "v8";
            case 0x29: return "v9";
            case 0x2a: return "v10";
            case 0x2b: return "v11";
            case 0x2c: return "v12";
            case 0x2d: return "v13";
            case 0x2e: return "v14";
            case 0x2f: return "v15";
            case 0x30: return "v16";
            case 0x31: return "v17";
            case 0x32: return "v18";
            case 0x33: return "v19";
            case 0x34: return "v20";
            case 0x35: return "v21";
            case 0x36: return "v22";
            case 0x37: return "v23";
            case 0x38: return "v24";
            case 0x39: return "v25";
            case 0x3a: return "v26";
            case 0x3b: return "v27";
            case 0x3c: return "v28";
            case 0x3d: return "v29";
            case 0x3e: return "v30";
            case 0x3f: return "v31";
            case 0x40: return "sfp";
            case 0x41: return "ap";
            case 0x42: return "cc";
            case 0x43: return "ip";
            default: return "";
        }
    }

    void dump() const override
    {
        log("Register State:\n")

        for (uint64_t i = 0; i < max_num_registers(); ++i) {
            log("  %-3s: 0x%80lx\n", name(i), get(i));
        }

        log("\n")
    }

private:
    registers_aarch64_t m_registers;
    registers_aarch64_t m_tmp_registers;
};

#endif
