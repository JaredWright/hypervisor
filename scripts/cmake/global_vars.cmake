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
# This file defines all NON CONFIGURABLE cmake variables that are shared across
# all sub-projects. The "BF_" prefix signifies that the variable is bareflank
# specific and applies to all sub-projects and dependencies globally
#
# Do NOT assign built-in CMake variables here (vars that start with "CMAKE_")
#

# ------------------------------------------------------------------------------
# Source tree structure
# ------------------------------------------------------------------------------

set(BF_SOURCE_DIR ${CMAKE_SOURCE_DIR}
    CACHE INTERNAL
    "Top-level source directory"
)

set(BF_SCRIPTS_DIR "${BF_SOURCE_DIR}/scripts"
    CACHE INTERNAL
    "Scripts directory"
)

set(BF_CONFIG_DIR "${BF_SCRIPTS_DIR}/cmake/config"
    CACHE INTERNAL
    "Cmake build configurations directory"
)

set(BF_DEPENDS_DIR "${BF_SCRIPTS_DIR}/cmake/depends"
    CACHE INTERNAL
    "Cmake external dependencies directory"
)

set(BF_FLAGS_DIR "${BF_SCRIPTS_DIR}/cmake/flags"
    CACHE INTERNAL
    "Cmake compiler flags directory"
)

set(BF_TARGETS_DIR "${BF_SCRIPTS_DIR}/cmake/targets"
    CACHE INTERNAL
    "Cmake custom build targets directory"
)

set(BF_TOOLCHAIN_DIR "${BF_SCRIPTS_DIR}/cmake/toolchain"
    CACHE INTERNAL
    "Cmake toolchain files directory"
)

# ------------------------------------------------------------------------------
# Build tree structure
# ------------------------------------------------------------------------------

set(BF_BUILD_DIR ${CMAKE_BINARY_DIR}
    CACHE INTERNAL
    "Top-level build directory"
)

set(BF_BUILD_DEPENDS_DIR ${BF_BUILD_DIR}/depends
    CACHE INTERNAL
    "Build directory for external dependencies"
)

set(BF_BUILD_INSTALL_DIR "${BF_BUILD_DIR}/install"
    CACHE INTERNAL
    "Intermediate build installation directory"
)

set(BF_BUILD_DIR_BFDRIVER "${BF_BUILD_DIR}/bfdriver/src/bfdriver-build"
    CACHE INTERNAL
    "Build directory for bfdriver"
)

set(BF_BUILD_DIR_BFELF_LOADER "${BF_BUILD_DIR}/bfelf_loader/src/bfelf_loader-build"
    CACHE INTERNAL
    "Build directory for bfelf_loader"
)

set(BF_BUILD_DIR_BFM "${BF_BUILD_DIR}/bfm/src/bfm-build"
    CACHE INTERNAL
    "Build directory for bfm"
)

set(BF_BUILD_DIR_BFSDK "${BF_BUILD_DIR}/bfsdk/src/bfsdk-build"
    CACHE INTERNAL
    "Build directory for bfsdk"
)

set(BF_BUILD_DIR_BFSUPPORT "${BF_BUILD_DIR}/bfsupport/src/bfsupport-build"
    CACHE INTERNAL
    "Build directory for bfsupport"
)

set(BF_BUILD_DIR_BFSUPPORT_TEST "${BF_BUILD_DIR}/bfsupport_test/src/bfsupport_test-build"
    CACHE INTERNAL
    "Build directory for bfsupport tests"
)

set(BF_BUILD_DIR_BFUNWIND "${BF_BUILD_DIR}/bfunwind/src/bfunwind-build"
    CACHE INTERNAL
    "Build directory for bfunwind"
)

set(BF_BUILD_DIR_BFVMM "${BF_BUILD_DIR}/bfvmm/src/bfvmm-build"
    CACHE INTERNAL
    "Build directory for bfvmm"
)

set(BF_BUILD_DIR_BFVMM_TEST "${BF_BUILD_DIR}/bfvmm_test/src/bfvmm_test-build"
    CACHE INTERNAL
    "Build directory for bfvmm tests"
)

set(BF_BUILD_DIR_EXTENDED_APIS "${BF_BUILD_DIR}/extended_apis/src/extended_apis-build"
    CACHE INTERNAL
    "Build directory for bareflank Extended APIs"
)
