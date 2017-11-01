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
# To override the default settings, you can specify an alternate config file
# using: cmake /path/to/src -DBFCONFIG=/path/to/config.cmake

# ------------------------------------------------------------------------------
# Import user configuration file (if specified)
# ------------------------------------------------------------------------------
if(BFCONFIG)
    find_file(BFCONFIG_PATH ${BFCONFIG} ${CMAKE_BINARY_DIR})
    if(EXISTS ${BFCONFIG_PATH})
        message(STATUS "Configuring Bareflank using: ${BFCONFIG_PATH}")
        include(${BFCONFIG_PATH})
    else()
        message(FATAL_ERROR "Configuration file ${BFCONFIG} not found")
    endif()
else()
    message(STATUS "No configuration specified, using default settings")
endif()

# ------------------------------------------------------------------------------
# Build attributes
# ------------------------------------------------------------------------------
set(_BUILD_TYPE_DEFAULT "Release" CACHE INTERNAL "")
if(CMAKE_BUILD_TYPE)
    set(_BUILD_TYPE_DEFAULT ${CMAKE_BUILD_TYPE})
endif()
add_config(BUILD_TYPE ${_BUILD_TYPE_DEFAULT} 
    STRING "The type of build"
)
set_property(CACHE BUILD_TYPE PROPERTY STRINGS
    "Release"
    "Debug"
)

add_config(BUILD_TARGET_ARCH ${CMAKE_HOST_SYSTEM_PROCESSOR}
    STRING "The target architecture for the build"
)
set_property(CACHE BUILD_TARGET_ARCH PROPERTY STRINGS
    "x86_64"
    "aarch64"
)

add_config(BUILD_TARGET_OS ${CMAKE_HOST_SYSTEM_NAME}
    STRING "The target operating system for the build"
)
set_property(CACHE BUILD_TARGET_OS PROPERTY STRINGS
    "None"      # VMM-only build
    "Linux"
    "Windows"
)

add_config(BUILD_SHARED_LIBS OFF 
    BOOL "Build libraries as shared libraries"
)

add_config(BUILD_STATIC_LIBS ON 
    BOOL "Build libraries as static libraries"
)

add_config(BUILD_VERBOSE ${CMAKE_VERBOSE_MAKEFILE} 
    BOOL "Display verbose output during build"
)

STRING(TOLOWER "${BF_BUILD_INSTALL_DIR}/${BUILD_TARGET_OS}-${BUILD_TARGET_ARCH}-${BUILD_TYPE}" _BUILD_SYSROOT_OS)
set(_BUILD_SYSROOT_OS ${_BUILD_SYSROOT_OS} CACHE INTERNAL "")
add_config(BUILD_SYSROOT_OS
    ${_BUILD_SYSROOT_OS}
    PATH "Path to userspace build-system sysroot"
)

STRING(TOLOWER "${BF_BUILD_INSTALL_DIR}/vmm-${BUILD_TARGET_ARCH}-${BUILD_TYPE}" _BUILD_SYSROOT_VMM)
set(_BUILD_SYSROOT_VMM ${_BUILD_SYSROOT_VMM} CACHE INTERNAL "")
add_config(BUILD_SYSROOT_VMM
    ${_BUILD_SYSROOT_VMM}
    PATH "Path to vmm build-system sysroot"
)

STRING(TOLOWER "${BF_BUILD_INSTALL_DIR}/${BUILD_TARGET_OS}-${BUILD_TARGET_ARCH}-test" _BUILD_SYSROOT_OS_TEST)
set(_BUILD_SYSROOT_OS_TEST ${_BUILD_SYSROOT_OS_TEST} CACHE INTERNAL "")
add_config(BUILD_SYSROOT_OS_TEST
    ${_BUILD_SYSROOT_OS_TEST}
    PATH "Path to vmm build-system sysroot"
)

STRING(TOLOWER "${BF_BUILD_INSTALL_DIR}/vmm-${BUILD_TARGET_ARCH}-test" _BUILD_SYSROOT_VMM_TEST)
set(_BUILD_SYSROOT_VMM_TEST ${_BUILD_SYSROOT_VMM_TEST} CACHE INTERNAL "")
add_config(BUILD_SYSROOT_VMM_TEST
    ${_BUILD_SYSROOT_VMM_TEST}
    PATH "Path to vmm build-system sysroot"
)
# ------------------------------------------------------------------------------
# Developer Features
# ------------------------------------------------------------------------------
add_config(ENABLE_UNITTESTING OFF
    BOOL "Enable unit testing"
)

add_config(ENABLE_COMPILER_WARNINGS OFF
    BOOL "Enable compiler warnings"
)

add_config(ENABLE_ASAN OFF
    BOOL "Enable clang AddressSanitizer"
)

add_config(ENABLE_USAN OFF
    BOOL "Enable clang UndefinedBehaviorSanitizer"
)

add_config(ENABLE_COVERITY OFF
    BOOL "Enable coverity static analysis"
)

add_config(ENABLE_TIDY OFF
    BOOL "Enable clang-tidy"
)

add_config(ENABLE_ASTYLE OFF
    BOOL "Enable astyle formatting"
)

add_config(ENABLE_DEPEND_UPDATES OFF
    BOOL "Check dependencies for updates on every build"
)

# ------------------------------------------------------------------------------
# High-level cmake toolchains
# ------------------------------------------------------------------------------
add_config(TOOLCHAIN_PATH_USERSPACE "${BF_TOOLCHAIN_DIR}/default.cmake"
    PATH "Path to the default cmake toolchain file for building userspace components"
)

add_config(TOOLCHAIN_PATH_KERNEL "${BF_TOOLCHAIN_DIR}/default_kernel.cmake"
    PATH "Path to the default cmake toolchain file for building kernel components"
)

add_config(TOOLCHAIN_PATH_VMM "${BF_TOOLCHAIN_DIR}/default_vmm.cmake"
    PATH "Path to the default cmake toolchain file for building vmm components"
)

# ------------------------------------------------------------------------------
# Advanced (granular) cmake toolchains
# ------------------------------------------------------------------------------
add_config(TOOLCHAIN_PATH_ASTYLE ${TOOLCHAIN_PATH_USERSPACE}
    PATH "Path to a cmake toolchain file for building astyle"
)
mark_as_advanced(TOOLCHAIN_PATH_ASTYLE)

add_config(TOOLCHAIN_PATH_BINUTILS ${TOOLCHAIN_PATH_USERSPACE}
    PATH "Path to a cmake toolchain file for building GNU binutils"
)
mark_as_advanced(TOOLCHAIN_PATH_BINUTILS)

add_config(TOOLCHAIN_PATH_CATCH ${TOOLCHAIN_PATH_USERSPACE}
    PATH "Path to a cmake toolchain file for building catch"
)
mark_as_advanced(TOOLCHAIN_PATH_CATCH)

add_config(TOOLCHAIN_PATH_EXTENDED_APIS ${TOOLCHAIN_PATH_VMM}
    PATH "Path to a cmake toolchain file for building the bareflank extended apis"
)
mark_as_advanced(TOOLCHAIN_PATH_EXTENDED_APIS)

add_config(TOOLCHAIN_PATH_GSL ${TOOLCHAIN_PATH_USERSPACE}
    PATH "Path to a cmake toolchain file for building C++ guidelines support library"
)
mark_as_advanced(TOOLCHAIN_PATH_GSL)

add_config(TOOLCHAIN_PATH_HIPPOMOCKS ${TOOLCHAIN_PATH_USERSPACE}
    PATH "Path to a cmake toolchain file for building hippomocks"
)
mark_as_advanced(TOOLCHAIN_PATH_HIPPOMOCKS)

add_config(TOOLCHAIN_PATH_JSON ${TOOLCHAIN_PATH_USERSPACE}
    PATH "Path to a cmake toolchain file for building JSON"
)
mark_as_advanced(TOOLCHAIN_PATH_JSON)

add_config(TOOLCHAIN_PATH_LIBCXX ${TOOLCHAIN_PATH_VMM}
    PATH "Path to a cmake toolchain file for building libc++"
)
mark_as_advanced(TOOLCHAIN_PATH_LIBCXX)

add_config(TOOLCHAIN_PATH_LIBCXXABI ${TOOLCHAIN_PATH_VMM}
    PATH "Path to a cmake toolchain file for building libc++abi"
)
mark_as_advanced(TOOLCHAIN_PATH_LIBCXXABI)

add_config(TOOLCHAIN_PATH_BFDRIVER ${TOOLCHAIN_PATH_KERNEL}
    PATH "Path to a cmake toolchain file for building bfdriver"
)
mark_as_advanced(TOOLCHAIN_PATH_BFDRIVER)

add_config(TOOLCHAIN_PATH_BFELF_LOADER ${TOOLCHAIN_PATH_VMM}
    PATH "Path to a cmake toolchain file for building bfelf_loader"
)
mark_as_advanced(TOOLCHAIN_PATH_BFELF_LOADER)

add_config(TOOLCHAIN_PATH_BFM ${TOOLCHAIN_PATH_USERSPACE}
    PATH "Path to a cmake toolchain file for building bfm"
)
mark_as_advanced(TOOLCHAIN_PATH_BFM)

add_config(TOOLCHAIN_PATH_BFSDK ${TOOLCHAIN_PATH_USERSPACE}
    PATH "Path to a cmake toolchain file for building bfsdk"
)
mark_as_advanced(TOOLCHAIN_PATH_BFSDK)

add_config(TOOLCHAIN_PATH_BFSYSROOT ${TOOLCHAIN_PATH_VMM}
    PATH "Path to a cmake toolchain file for building bfsysroot"
)
mark_as_advanced(TOOLCHAIN_PATH_BFSYSROOT)

add_config(TOOLCHAIN_PATH_BFSUPPORT ${TOOLCHAIN_PATH_VMM}
    PATH "Path to a cmake toolchain file for building bfsupport"
)
mark_as_advanced(TOOLCHAIN_PATH_BFSUPPORT)

add_config(TOOLCHAIN_PATH_BFUNWIND ${TOOLCHAIN_PATH_VMM}
    PATH "Path to a cmake toolchain file for building bfunwind"
)
mark_as_advanced(TOOLCHAIN_PATH_BFUNWIND)

add_config(TOOLCHAIN_PATH_BFVMM ${TOOLCHAIN_PATH_VMM}
    PATH "Path to a cmake toolchain file for building bfvmm"
)
mark_as_advanced(TOOLCHAIN_PATH_BFVMM)

# ------------------------------------------------------------------------------
# Non-cmake toolchains
# ------------------------------------------------------------------------------
add_config(TOOLCHAIN_NEWLIB_CC
    ${BUILD_SYSROOT_VMM}/bin/${BUILD_TARGET_ARCH}-vmm-clang
    PATH "Path to a compiler for building newlib"
)
mark_as_advanced(TOOLCHAIN_NEWLIB_CC)

add_config(TOOLCHAIN_NEWLIB_AS
    ${BUILD_SYSROOT_VMM}/bin/${BUILD_TARGET_ARCH}-vmm-elf-as
    PATH "Path to an assembler for building newlib"
)
mark_as_advanced(TOOLCHAIN_NEWLIB_AS)

add_config(TOOLCHAIN_NEWLIB_AR
    ${BUILD_SYSROOT_VMM}/bin/${BUILD_TARGET_ARCH}-vmm-elf-ar
    PATH "Path to binutils archiver for building newlib"
)
mark_as_advanced(TOOLCHAIN_NEWLIB_AR)

add_config(TOOLCHAIN_NEWLIB_RANLIB
    ${BUILD_SYSROOT_VMM}/bin/${BUILD_TARGET_ARCH}-vmm-elf-ranlib
    PATH "Path to binutils ranlib for building newlib"
)
mark_as_advanced(TOOLCHAIN_NEWLIB_RANLIB)

# ------------------------------------------------------------------------------
# Compiler Flags
# ------------------------------------------------------------------------------
include(${BF_FLAGS_DIR}/flags.cmake)
add_config(C_FLAGS_VMM "${DEFAULT_C_FLAGS_VMM}"
    STRING "C compiler flags for VMM components"
)

add_config(CXX_FLAGS_VMM "${DEFAULT_CXX_FLAGS_VMM}"
    STRING "C++ compiler flags for VMM components"
)

add_config(C_FLAGS_HOST "${DEFAULT_C_FLAGS_HOST}"
    STRING "C compiler flags for host OS components"
)

add_config(CXX_FLAGS_HOST "${DEFAULT_CXX_FLAGS_HOST}"
    STRING "C++ compiler flags for host OS components"
)

add_config(C_FLAGS_WARNING "${DEFAULT_C_FLAGS_WARNING}"
    STRING "C compiler flags to be used when compiler warnings are enabled"
)

add_config(CXX_FLAGS_WARNING "${DEFAULT_CXX_FLAGS_WARNING}"
    STRING "C++ compiler flags to be used when compiler warnings are enabled"
)
