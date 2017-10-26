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

# TODO: The path to a directory named "bfprefix" is currently dictated
# by the env.sh script. Remove that requirement and make this path configurable
# set(BF_BUILD_INSTALL_DIR ${BF_BUILD_DIR}/install
set(BF_BUILD_INSTALL_DIR ${BF_BUILD_DIR}/bfprefix
    CACHE INTERNAL
    "Intermediate build installation directory"
)
