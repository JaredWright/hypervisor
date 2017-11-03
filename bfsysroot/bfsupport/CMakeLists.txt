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
project(bfsupport C CXX)
include(${BF_FLAGS_DIR}/flags.cmake)
set(TIDY_EXCLUSIONS ,-cert-err34-c,-misc-misplaced-widening-cast,-cppcoreguidelines-no-malloc)

set(CMAKE_ASM_NASM_OBJECT_FORMAT "elf64")
enable_language(ASM_NASM)

include_directories(
    ${CMAKE_CURRENT_LIST_DIR}/include
    ${BUILD_SYSROOT_VMM}/include/c++/v1
    ${BUILD_SYSROOT_VMM}/include
)

link_directories(
    ${BUILD_SYSROOT_VMM}/lib
)

generate_flags(VMM ADD_CXX_FLAGS "-fno-stack-protector")

add_subdirectory(crt)
add_subdirectory(syscall)
add_subdirectory(pthread)
add_subdirectory(dummy_lib1)
add_subdirectory(dummy_lib2)
add_subdirectory(dummy_main)

# Temp hack until we can restructure unit tests
if(ENABLE_UNITTESTING)
    include(CTest)
    enable_testing(true)
    include(${BF_SCRIPTS_DIR}/cmake/macros.cmake)
    include(ExternalProject)

    add_subproject(
        ${CMAKE_CURRENT_LIST_DIR}/crt/tests
        bfsupport_test
        ${TOOLCHAIN_PATH_USERSPACE}
        " "
    )
endif()
