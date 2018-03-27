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
project(bfpthread C CXX)

include(${SOURCE_CMAKE_DIR}/project.cmake)
init_project()

list(APPEND SOURCES
    pthread.cpp
)

if(${BUILD_TARGET_ARCH} STREQUAL "x86_64")
    list(APPEND SOURCES
        threadcontext_x64.asm
    )
endif()

if(${BUILD_TARGET_ARCH} STREQUAL "aarch64")
    list(APPEND SOURCES
        threadcontext_aarch64.s
    )
endif()

add_shared_library(
    bfpthread
    SOURCES ${SOURCES}
    DEFINES SHARED_PTHREAD
)

add_static_library(
    bfpthread
    SOURCES ${SOURCES}
    DEFINES STATIC_PTHREAD
)
