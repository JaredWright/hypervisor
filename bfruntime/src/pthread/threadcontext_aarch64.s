/*
 * Bareflank Hypervisor
 *
 * Copyright (C) 2018 Assured Information Security, Inc.
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

.section .text
.balign 4

.global _thread_context_cpuid
_thread_context_cpuid:
    mov x2, #0x7FFF

    mov x0, sp
    mov x1, x2
    mvn x1, x1
    and x0, x0, x1

    add x0, x0, x2
    sub x0, x0, #32

    ldr x0, [x0]
    ret

.global _thread_context_tlsptr
_thread_context_tlsptr:
    mov x2, #0x7FFF

    mov x0, sp
    mov x1, x2
    mvn x1, x1
    and x0, x0, x1

    add x0, x0, x2

    sub x0, x0, #24

    ldr x0, [x0]
    ret
