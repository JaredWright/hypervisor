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

set(CMAKE_ASM_NASM_OBJECT_FORMAT "elf64")
enable_language(ASM_NASM)

if(ENABLE_UNITTESTING)
    include(CTest)
    enable_testing(true)
endif()

set(TIDY_EXCLUSIONS ,-cert-err34-c,-misc-misplaced-widening-cast,-cppcoreguidelines-no-malloc)

list(APPEND BFSUPPORT_INCLUDE_DIRS
    "${CMAKE_CURRENT_LIST_DIR}/include"
    "${BF_BUILD_INSTALL_DIR}/include/c++/v1"
    "${BF_BUILD_INSTALL_DIR}/include"
)
include_directories(${BFSUPPORT_INCLUDE_DIRS})

list(APPEND BFSUPPORT_LINK_DIRS
    "${BF_BUILD_INSTALL_DIR}/lib"
)
link_directories(${BFSUPPORT_LINK_DIRS})

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${C_FLAGS_VMM}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CXX_FLAGS_VMM} -fno-stack-protector")

add_subdirectory(crt)
add_subdirectory(syscall)
add_subdirectory(pthread)

if(ENABLE_UNITTESTING)
    add_subdirectory(dummy_lib1)
    add_subdirectory(dummy_lib2)
    add_subdirectory(dummy_main)
endif()
