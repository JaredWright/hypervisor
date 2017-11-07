#
# Bareflank Hypervisor
# Copyright (C) 2015 Assured Information Security, Inc.
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

cmake_minimum_required(VERSION 3.6)
project(bfvmm_test C CXX)
include(${BF_FLAGS_DIR}/flags.cmake)

set(CMAKE_ASM_NASM_OBJECT_FORMAT "elf64")
enable_language(ASM_NASM)

list(APPEND VMM_TEST_C_FLAGS
    "-fvisibility=hidden"
    "-DDEBUG_LEVEL=1"
)

list(APPEND VMM_TEST_CXX_FLAGS
    "-fvisibility=hidden"
    "-fvisibility-inlines-hidden"
    "-DDEBUG_LEVEL=1"
)

generate_flags(
    USERSPACE
    ADD_C_FLAGS ${VMM_TEST_C_FLAGS}
    ADD_CXX_FLAGS ${VMM_TEST_CXX_FLAGS}
)

include_directories(
    ${CMAKE_CURRENT_LIST_DIR}/../include
    ${BUILD_SYSROOT_OS}/include
    ${BUILD_SYSROOT_TEST}/include
)

link_directories(
    ${BUILD_SYSROOT_OS}/lib
    ${BUILD_SYSROOT_TEST}/lib
    ${BUILD_SYSROOT_VMM}/lib
)

add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/../src ${CMAKE_CURRENT_BINARY_DIR}/src)

install(DIRECTORY include/ DESTINATION ${BUILD_SYSROOT_VMM}/include)
