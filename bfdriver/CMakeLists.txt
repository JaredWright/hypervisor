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
project(bfdrivers C CXX)

include_directories("include")

if(ENABLE_UNITTESTING)
    include(CTest)
    enable_testing(true)
    include_directories("tests")
    include_directories("${BUILD_SYSROOT_OS}/include")
    include_directories("${BUILD_SYSROOT_OS_TEST}/include")
    link_directories("${BUILD_SYSROOT_OS_TEST}/lib")
    set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-DBAREFLANK_SYSROOT_PATH='\"${BUILD_SYSROOT_VMM}\"'")
    add_subdirectory(src)
    add_subdirectory(tests)
endif()

execute_process(
    COMMAND ${CMAKE_SOURCE_DIR}/scripts/driver_build.sh ${CMAKE_SOURCE_DIR}
)

if(${BUILD_TARGET_OS} STREQUAL "Linux")
    install(
        PROGRAMS ${BF_SOURCE_DIR}/bfdriver/src/arch/linux/bareflank.ko
        DESTINATION ${BUILD_SYSROOT_OS}/lib
    )
elseif(${BUILD_TARGET_OS} STREQUAL "Windows")
    # TODO: Install bareflank.sys to ${BUILD_SYSROOT_OS}/lib
endif()

