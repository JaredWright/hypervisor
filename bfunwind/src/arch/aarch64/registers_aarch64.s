/*
 * Bareflank Unwind Library
 * Copyright (C) 2015 Assured Information Security, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

.global __store_registers_aarch64
.global __load_registers_aarch64
.section .text

/*
 * void __store_registers_aarch64(registers_aarch64_t *state)
 *
 * This function saves the current register state. Since this function is
 * "naked", the state of the registers is identical to the state of the
 * registers prior to the call to this function.
 *
 * Also note that we use the return address as ip. The DWARF code is going to
 * give us a set of instructions on how to roll back the stack, and those
 * instructions are relative to ip. So, we could have used ip just prior to
 * the call to this function, but since this function is "naked" we can also use
 * ip just after the call to this function (which is the return address) as
 * the register state has not changed.
 *
 * Because load/store cannot access the stack pointer, we use x1 to help move
 * that value after its original value is stored.
 */
__store_registers_aarch64:
    str x0, [x0, #0]
    str x1, [x0, #8]
    stp x2, x3, [x0, #16]
    stp x4, x5, [x0, #32]
    stp x6, x7, [x0, #48]
    stp x8, x9, [x0, #64]
    stp x10, x11, [x0, #80]
    stp x12, x13, [x0, #96]
    stp x14, x15, [x0, #128]
    stp x16, x17, [x0, #144]
    stp x18, x19, [x0, #160]
    stp x20, x21, [x0, #176]
    stp x22, x23, [x0, #192]
    stp x24, x25, [x0, #208]
    stp x26, x27, [x0, #224]
    stp x28, x29, [x0, #240]

    mov x1, sp
    stp x30, x1, [x0, #256]

    str x30, [x0, #512]

    ret

/*
 * void __load_registers_aarch64(registers_aarch64_t *state)
 *
 * The goal of this function is to "resume" by setting the current state of the
 * CPU to the state that was saved. This function is a little complicated
 * because the order of each instruction needs to be just right.
 *
 * x0 is the last register restored, because it contains the pointer to the
 * register struct itself. Because load/store cannot access the stack pointer,
 * we use x1 to help move that value in before x1 is restored.
 */
__load_registers_aarch64:
    ldp x30, x1, [x0, #256]
    mov sp, x1

    ldr x30, [x0, #512]

    ldp x28, x29, [x0, #240]
    ldp x26, x27, [x0, #224]
    ldp x24, x25, [x0, #208]
    ldp x22, x23, [x0, #192]
    ldp x20, x21, [x0, #176]
    ldp x18, x19, [x0, #160]
    ldp x16, x17, [x0, #144]
    ldp x14, x15, [x0, #128]
    ldp x12, x13, [x0, #96]
    ldp x10, x11, [x0, #80]
    ldp x8, x9, [x0, #64]
    ldp x6, x7, [x0, #48]
    ldp x4, x5, [x0, #32]
    ldp x2, x3, [x0, #16]
    ldr x1, [x0, #8]
    ldr x0, [x0, #0]
    ret
