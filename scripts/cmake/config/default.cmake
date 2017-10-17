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
# This file defines all CONFIGURABLE cmake variables set to their default value.
# These variables are configurable through cmake-gui and ccmake.
#

# ------------------------------------------------------------------------------
# Cmake build attributes
# ------------------------------------------------------------------------------

set(CMAKE_BUILD_TYPE "Release"
    CACHE STRING
    "The type of build"
)
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
    "Release"
    "Debug"
)

# ------------------------------------------------------------------------------
# Build attributes
# ------------------------------------------------------------------------------

set(BUILD_TARGET_ARCH "host"
    CACHE STRING
    "The target architecture for the build"
)
set_property(CACHE BUILD_TARGET_ARCH PROPERTY STRINGS
    "host"      # Auto-detect the host architecture of the current build
    "x86_64"
    "aarch64"
)

set(BUILD_TARGET_OS "host"
    CACHE STRING
    "The target operating system for the build"
)
set_property(CACHE BUILD_TARGET_OS PROPERTY STRINGS
    "host"      # Auto-detect the host operating system of the current build
    "none"      # VMM-only build
    "linux"
    "windows"
)

set(BUILD_SHARED_LIBS OFF
    CACHE BOOL
    "Build libraries as shared libraries"
)

set(BUILD_STATIC_LIBS ON
    CACHE BOOL
    "Build libraries as static libraries"
)

# ------------------------------------------------------------------------------
# Developer Features
# ------------------------------------------------------------------------------

set(ENABLE_UNITTESTING OFF
    CACHE BOOL
    "Enable unit testing"
)

set(ENABLE_ASAN OFF
    CACHE BOOL
    "Enable clang AddressSanitizer"
)

set(ENABLE_USAN OFF
    CACHE BOOL
    "Enable clang UndefinedBehaviorSanitizer"
)

set(ENABLE_COVERITY OFF
    CACHE BOOL
    "Enable coverity static analysis"
)

set(ENABLE_TIDY OFF
    CACHE BOOL
    "Enable clang-tidy"
)

set(ENABLE_ASTYLE OFF
    CACHE BOOL
    "Enable astyle formatting"
)

set(ENABLE_DEPEND_UPDATES OFF
    CACHE BOOL
    "Check dependencies for updates on every build"
)

# ------------------------------------------------------------------------------
# Toolchains
# ------------------------------------------------------------------------------

set(TOOLCHAIN_PATH_ASTYLE ${BF_DEFAULT_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building astyle"
)

set(TOOLCHAIN_PATH_BINUTILS ${BF_DEFAULT_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building GNU binutils"
)

set(TOOLCHAIN_PATH_CATCH ${BF_DEFAULT_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building catch"
)

set(TOOLCHAIN_PATH_GSL ${BF_DEFAULT_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building C++ guidelines support library"
)

set(TOOLCHAIN_PATH_HIPPOMOCKS ${BF_DEFAULT_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building hippomocks"
)

set(TOOLCHAIN_PATH_JSON ${BF_DEFAULT_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building JSON"
)

set(TOOLCHAIN_PATH_LIBCXX ${BF_DEFAULT_VMM_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building libc++"
)

set(TOOLCHAIN_PATH_LIBCXXABI ${BF_DEFAULT_VMM_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building libc++abi"
)

set(TOOLCHAIN_PATH_NEWLIB ${BF_DEFAULT_VMM_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building newlib"
)

set(TOOLCHAIN_PATH_BFDRIVER ${BF_DEFAULT_KERNEL_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building bfdriver"
)

set(TOOLCHAIN_PATH_BFELF_LOADER ${BF_DEFAULT_VMM_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building bfelf_loader"
)

set(TOOLCHAIN_PATH_BFM ${BF_DEFAULT_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building bfm"
)

set(TOOLCHAIN_PATH_BFSDK ${BF_DEFAULT_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building bfsdk"
)

set(TOOLCHAIN_PATH_BFSYSROOT ${BF_DEFAULT_VMM_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building bfsysroot"
)

set(TOOLCHAIN_PATH_BFVMM ${BF_DEFAULT_VMM_TOOLCHAIN_FILE}
    CACHE PATH
    "Path to a cmake toolchain file for building bfvmm"
)
