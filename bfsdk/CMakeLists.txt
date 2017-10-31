#
# Bareflank Hypervisor
# Copyright (C) 2015 Assured Information Security, Inc.
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
    #oooooooooooooo version 2.1 of the License, or (at your option) any later version.
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
project(bfsdk C CXX)

include(${CMAKE_SOURCE_DIR}/../scripts/cmake/macros.cmake)

if(ENABLE_UNITTESTING)
    include(CTest)
    enable_testing(true)
    add_subdirectory(tests)
endif()

install(DIRECTORY include DESTINATION ${BF_BUILD_INSTALL_DIR})
# install(FILES src/bfvmcall_intel_x64.asm DESTINATION ${BF_BUILD_INSTALL_DIR}/src)
install(
    PROGRAMS ${BF_SCRIPTS_DIR}/util/compiler_wrapper.sh
    DESTINATION ${BF_BUILD_INSTALL_DIR}/bin RENAME x86_64-vmm-clang
)
