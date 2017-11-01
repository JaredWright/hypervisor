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
project(bfm C CXX)

if(ENABLE_UNITTESTING)
    include(CTest)
    enable_testing(true)
endif()

set(CMAKE_ASM_NASM_OBJECT_FORMAT "elf64")
enable_language(ASM_NASM)

list(APPEND CMAKE_C_FLAGS
    ${C_FLAGS_HOST}
)
string(REPLACE ";" " " CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")

list(APPEND CMAKE_CXX_FLAGS
    ${CXX_FLAGS_HOST}
    -DBAREFLANK_VMM_BIN_PATH="${BUILD_SYSROOT_VMM}/bin/"
    -DBAREFLANK_VMM_LIB_PATH="${BUILD_SYSROOT_VMM}/lib/"
)
string(REPLACE ";" " " CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CXX_FLAGS_HOST} -DBFM_DEFAULT_VMM=eapis")

message(STATUS "BFM C Flags: ${CMAKE_C_FLAGS}")
message(STATUS "BFM CXX Flags: ${CMAKE_CXX_FLAGS}")

list(APPEND BFM_INCLUDE_DIRS
    "${CMAKE_CURRENT_LIST_DIR}/include"
    "${BUILD_SYSROOT_OS}/include"
)
include_directories(${BFM_INCLUDE_DIRS})
# ------------------------------------------------------------------------------
# Subdirectories
# ------------------------------------------------------------------------------

add_subdirectory(ioctl)
add_subdirectory(src)
add_subdirectory(main)

if(ENABLE_UNITTESTING)
    add_subdirectory(tests)
endif()
