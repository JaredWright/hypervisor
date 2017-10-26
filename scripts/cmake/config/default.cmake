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
# Build attributes
# ------------------------------------------------------------------------------
set(BUILD_TYPE ${CMAKE_BUILD_TYPE}
    CACHE STRING
    "The type of build"
)
set_property(CACHE BUILD_TYPE PROPERTY STRINGS
    "Release"
    "Debug"
)

set(BUILD_TARGET_ARCH ${CMAKE_HOST_SYSTEM_PROCESSOR}
    CACHE STRING
    "The target architecture for the build"
)
set_property(CACHE BUILD_TARGET_ARCH PROPERTY STRINGS
    "x86_64"
    "aarch64"
)

set(BUILD_TARGET_OS ${CMAKE_HOST_SYSTEM_NAME}
    CACHE STRING
    "The target operating system for the build"
)
set_property(CACHE BUILD_TARGET_OS PROPERTY STRINGS
    "None"      # VMM-only build
    "Linux"
    "Windows"
)

set(BUILD_SHARED_LIBS OFF
    CACHE BOOL
    "Build libraries as shared libraries"
)

set(BUILD_STATIC_LIBS ON
    CACHE BOOL
    "Build libraries as static libraries"
)

set(BUILD_VERBOSE ${CMAKE_VERBOSE_MAKEFILE}
    CACHE BOOL
    "Display verbose output during build"
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
# High-level cmake toolchains
# ------------------------------------------------------------------------------
set(TOOLCHAIN_PATH_USERSPACE "${BF_TOOLCHAIN_DIR}/default.cmake"
    CACHE PATH
    "Path to the default cmake toolchain file for building userspace components"
)

set(TOOLCHAIN_PATH_KERNEL "${BF_TOOLCHAIN_DIR}/default_kernel.cmake"
    CACHE PATH
    "Path to the default cmake toolchain file for building kernel components"
)

set(TOOLCHAIN_PATH_VMM "${BF_TOOLCHAIN_DIR}/default_vmm.cmake"
    CACHE PATH
    "Path to the default cmake toolchain file for building vmm components"
)

# ------------------------------------------------------------------------------
# Advanced (granular) cmake toolchains
# ------------------------------------------------------------------------------
set(TOOLCHAIN_PATH_ASTYLE ${TOOLCHAIN_PATH_USERSPACE}
    CACHE PATH
    "Path to a cmake toolchain file for building astyle"
)
mark_as_advanced(TOOLCHAIN_PATH_ASTYLE)

set(TOOLCHAIN_PATH_BINUTILS ${TOOLCHAIN_PATH_USERSPACE}
    CACHE PATH
    "Path to a cmake toolchain file for building GNU binutils"
)
mark_as_advanced(TOOLCHAIN_PATH_BINUTILS)

set(TOOLCHAIN_PATH_CATCH ${TOOLCHAIN_PATH_USERSPACE}
    CACHE PATH
    "Path to a cmake toolchain file for building catch"
)
mark_as_advanced(TOOLCHAIN_PATH_CATCH)

set(TOOLCHAIN_PATH_EXTENDED_APIS ${TOOLCHAIN_PATH_VMM}
    CACHE PATH
    "Path to a cmake toolchain file for building the bareflank extended apis"
)
mark_as_advanced(TOOLCHAIN_PATH_EXTENDED_APIS)

set(TOOLCHAIN_PATH_GSL ${TOOLCHAIN_PATH_USERSPACE}
    CACHE PATH
    "Path to a cmake toolchain file for building C++ guidelines support library"
)
mark_as_advanced(TOOLCHAIN_PATH_GSL)

set(TOOLCHAIN_PATH_HIPPOMOCKS ${TOOLCHAIN_PATH_USERSPACE}
    CACHE PATH
    "Path to a cmake toolchain file for building hippomocks"
)
mark_as_advanced(TOOLCHAIN_PATH_HIPPOMOCKS)

set(TOOLCHAIN_PATH_JSON ${TOOLCHAIN_PATH_USERSPACE}
    CACHE PATH
    "Path to a cmake toolchain file for building JSON"
)
mark_as_advanced(TOOLCHAIN_PATH_JSON)

set(TOOLCHAIN_PATH_LIBCXX ${TOOLCHAIN_PATH_VMM}
    CACHE PATH
    "Path to a cmake toolchain file for building libc++"
)
mark_as_advanced(TOOLCHAIN_PATH_LIBCXX)

set(TOOLCHAIN_PATH_LIBCXXABI ${TOOLCHAIN_PATH_VMM}
    CACHE PATH
    "Path to a cmake toolchain file for building libc++abi"
)
mark_as_advanced(TOOLCHAIN_PATH_LIBCXXABI)

set(TOOLCHAIN_PATH_BFDRIVER ${TOOLCHAIN_PATH_KERNEL}
    CACHE PATH
    "Path to a cmake toolchain file for building bfdriver"
)
mark_as_advanced(TOOLCHAIN_PATH_BFDRIVER)

set(TOOLCHAIN_PATH_BFELF_LOADER ${TOOLCHAIN_PATH_VMM}
    CACHE PATH
    "Path to a cmake toolchain file for building bfelf_loader"
)
mark_as_advanced(TOOLCHAIN_PATH_BFELF_LOADER)

set(TOOLCHAIN_PATH_BFM ${TOOLCHAIN_PATH_USERSPACE}
    CACHE PATH
    "Path to a cmake toolchain file for building bfm"
)
mark_as_advanced(TOOLCHAIN_PATH_BFM)

set(TOOLCHAIN_PATH_BFSDK ${TOOLCHAIN_PATH_USERSPACE}
    CACHE PATH
    "Path to a cmake toolchain file for building bfsdk"
)
mark_as_advanced(TOOLCHAIN_PATH_BFSDK)

set(TOOLCHAIN_PATH_BFSYSROOT ${TOOLCHAIN_PATH_VMM}
    CACHE PATH
    "Path to a cmake toolchain file for building bfsysroot"
)
mark_as_advanced(TOOLCHAIN_PATH_BFSYSROOT)

set(TOOLCHAIN_PATH_BFSUPPORT ${TOOLCHAIN_PATH_VMM}
    CACHE PATH
    "Path to a cmake toolchain file for building bfsupport"
)
mark_as_advanced(TOOLCHAIN_PATH_BFSUPPORT)

set(TOOLCHAIN_PATH_BFUNWIND ${TOOLCHAIN_PATH_VMM}
    CACHE PATH
    "Path to a cmake toolchain file for building bfunwind"
)
mark_as_advanced(TOOLCHAIN_PATH_BFUNWIND)

set(TOOLCHAIN_PATH_BFVMM ${TOOLCHAIN_PATH_VMM}
    CACHE PATH
    "Path to a cmake toolchain file for building bfvmm"
)
mark_as_advanced(TOOLCHAIN_PATH_BFVMM)

# ------------------------------------------------------------------------------
# Non-cmake toolchains
# ------------------------------------------------------------------------------
set(TOOLCHAIN_NEWLIB_CC ${BF_BUILD_INSTALL_DIR}/bin/${BUILD_TARGET_ARCH}-vmm-clang
    CACHE PATH
    "Path to a compiler for building newlib"
)
mark_as_advanced(TOOLCHAIN_NEWLIB_CC)

set(TOOLCHAIN_NEWLIB_AS ${BF_BUILD_INSTALL_DIR}/bin/${BUILD_TARGET_ARCH}-vmm-elf-as
    CACHE PATH
    "Path to an assembler for building newlib"
)
mark_as_advanced(TOOLCHAIN_NEWLIB_AS)

set(TOOLCHAIN_NEWLIB_AR ${BF_BUILD_INSTALL_DIR}/bin/${BUILD_TARGET_ARCH}-vmm-elf-ar
    CACHE PATH
    "Path to binutils archiver for building newlib"
)
mark_as_advanced(TOOLCHAIN_NEWLIB_AR)

set(TOOLCHAIN_NEWLIB_RANLIB ${BF_BUILD_INSTALL_DIR}/bin/${BUILD_TARGET_ARCH}-vmm-elf-ranlib
    CACHE PATH
    "Path to binutils ranlib for building newlib"
)
mark_as_advanced(TOOLCHAIN_NEWLIB_RANLIB)
