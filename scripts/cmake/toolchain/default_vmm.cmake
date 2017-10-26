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
#
# ------------------------------------------------------------------------------
# README
# ------------------------------------------------------------------------------
# The default toolchain for building bareflank vmm components
# Builds components for the current host OS and architecture so that bareflank
# can be used on the same system being used to build it
#

# TODO: Use the configured target platform/OS to determine a sensible default
# if(${BUILD_TARGET_ARCH} STREQUAL "x86_64")
    include(${CMAKE_CURRENT_LIST_DIR}/clang_x86_64_vmm_elf.cmake)
# endif()
