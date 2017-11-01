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
project(bfvmm C CXX)

set(CMAKE_ASM_NASM_OBJECT_FORMAT "elf64")
enable_language(ASM_NASM)

if(ENABLE_UNITTESTING)
    include(CTest)
    enable_testing(true)
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${C_FLAGS_VMM} -fvisibility=hidden")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CXX_FLAGS_VMM} -fvisibility-inlines-hidden -fvisibility=hidden")

list(APPEND BFSUPPORT_INCLUDE_DIRS
    "${CMAKE_CURRENT_LIST_DIR}/include"
    "${BUILD_SYSROOT_VMM}/include/c++/v1"
    "${BUILD_SYSROOT_VMM}/include"
)
include_directories(${BFSUPPORT_INCLUDE_DIRS})

list(APPEND BFSUPPORT_LINK_DIRS
    "${BUILD_SYSROOT_VMM}/lib"
)
link_directories(${BFSUPPORT_LINK_DIRS})

# if(NOT CMAKE_TOOLCHAIN_FILE)
#     set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DDEBUG_LEVEL=1")
#     set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DDEBUG_LEVEL=1")
# endif()

add_subdirectory(src)

install(DIRECTORY include/ DESTINATION ${BUILD_SYSROOT_VMM}/include)
