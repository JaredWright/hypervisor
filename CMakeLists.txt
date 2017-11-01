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
project(hypervisor)

# ------------------------------------------------------------------------------
# Cmake global properties
# ------------------------------------------------------------------------------
include(${CMAKE_SOURCE_DIR}/scripts/cmake/global_vars.cmake)
include(${CMAKE_SOURCE_DIR}/scripts/cmake/macros.cmake)
include(${BF_CONFIG_DIR}/default.cmake)

include(ExternalProject)
set_property(GLOBAL PROPERTY EP_PREFIX ${BF_BUILD_DEPENDS_DIR})
if(ENABLE_DEPEND_UPDATES)
    set_property(GLOBAL PROPERTY EP_UPDATE_DISCONNECTED OFF)
else()
    set_property(GLOBAL PROPERTY EP_UPDATE_DISCONNECTED ON)
endif()
set(CMAKE_PREFIX_PATH ${BF_BUILD_INSTALL_DIR})

# ------------------------------------------------------------------------------
# Toolchain components
# ------------------------------------------------------------------------------
add_subproject(
    ${BF_SOURCE_DIR}/bfsdk
    bfsdk
    ${TOOLCHAIN_PATH_BFSDK}
    " "
)
include(${BF_DEPENDS_DIR}/binutils.cmake)

# ------------------------------------------------------------------------------
# External dependencies
# ------------------------------------------------------------------------------
include(${BF_DEPENDS_DIR}/python.cmake)
include(${BF_DEPENDS_DIR}/git.cmake)
include(${BF_DEPENDS_DIR}/gsl.cmake)
include(${BF_DEPENDS_DIR}/json.cmake)
include(${BF_DEPENDS_DIR}/newlib.cmake)
include(${BF_DEPENDS_DIR}/llvm.cmake)
if(${BUILD_TARGET_ARCH} STREQUAL "x86_64")
    include(${BF_DEPENDS_DIR}/nasm.cmake)
endif()
if(ENABLE_ASTYLE)
    include(${BF_DEPENDS_DIR}/astyle.cmake)
endif()
if(ENABLE_TIDY)
    include(${BF_DEPENDS_DIR}/clang_tidy.cmake)
endif()
if(ENABLE_UNITTESTING)
	include(${BF_DEPENDS_DIR}/catch.cmake)
	include(${BF_DEPENDS_DIR}/hippomocks.cmake)
endif()

# ------------------------------------------------------------------------------
# Messages
# ------------------------------------------------------------------------------

set_property(GLOBAL PROPERTY TARGET_MESSAGES OFF)

add_custom_command(
        OUTPUT success_message_completed
        COMMAND touch success_message_completed
        COMMAND ${CMAKE_COMMAND} -E cmake_echo_color ""
        COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --magenta --bold "  ___                __ _           _   "
        COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --magenta --bold " | _ ) __ _ _ _ ___ / _| |__ _ _ _ | |__"
        COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --magenta --bold " | _ \\/ _` | '_/ -_)  _| / _` | ' \\| / /"
        COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --magenta --bold " |___/\\__,_|_| \\___|_| |_\\__,_|_||_|_\\_\\"
        COMMAND ${CMAKE_COMMAND} -E cmake_echo_color ""
        COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --green --bold --no-newline " Please give us a star on:"
        COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --white --bold --no-newline " https://github.com/Bareflank/hypervisor"
        COMMAND ${CMAKE_COMMAND} -E cmake_echo_color ""
        COMMAND ${CMAKE_COMMAND} -E cmake_echo_color ""
        COMMAND ${CMAKE_COMMAND} -E cmake_echo_color ""
        VERBATIM
)

add_custom_target(complete_once ALL
    DEPENDS success_message_completed
)

add_custom_target(complete_always ALL
    COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --cyan "Compilation was successful!!!"
)

if(NOT WIN32)
    add_dependencies(complete_once bfsdk bfsysroot bfelf_loader bfm bfvmm bfdriver)
    add_dependencies(complete_always bfsdk bfsysroot bfelf_loader bfm bfvmm bfdriver complete_once)
else()
    add_dependencies(complete_once bfsdk bfelf_loader bfm bfdriver)
    add_dependencies(complete_always bfsdk bfelf_loader bfm bfdriver complete_once)
endif()

if(ENABLE_UNITTESTING)
    add_dependencies(complete_once test_bfvmm test_bfsysroot)
    add_dependencies(complete_always test_bfvmm test_bfsysroot)
endif()

# ------------------------------------------------------------------------------
# Bareflank sub-projects
# ------------------------------------------------------------------------------
add_subproject(
    ${BF_SOURCE_DIR}/bfsysroot/bfunwind
    bfunwind
    ${TOOLCHAIN_PATH_BFUNWIND}
    "bfsdk binutils newlib"
)

# C++ support relies on the above bareflank sub-projects
include(${BF_DEPENDS_DIR}/libcxx_download.cmake)
include(${BF_DEPENDS_DIR}/libcxxabi.cmake)
include(${BF_DEPENDS_DIR}/libcxx.cmake)

add_subproject(
    ${BF_SOURCE_DIR}/bfsysroot/bfsupport
    bfsupport
    ${TOOLCHAIN_PATH_BFSUPPORT}
    "bfsdk binutils libcxx libcxxabi newlib gsl"
)

add_subproject(
    ${BF_SOURCE_DIR}/bfelf_loader
    bfelf_loader
    ${TOOLCHAIN_PATH_BFELF_LOADER}
    "bfsdk binutils"
)

add_subproject(
    ${BF_SOURCE_DIR}/bfvmm
    bfvmm
    ${TOOLCHAIN_PATH_BFVMM}
    "bfsdk binutils bfunwind bfsupport"
)

add_subproject(
    ${BF_SOURCE_DIR}/bfdriver
    bfdriver
    ${TOOLCHAIN_PATH_BFDRIVER}
    "bfsdk"
)

add_subproject(
    ${BF_SOURCE_DIR}/bfm
    bfm
    ${TOOLCHAIN_PATH_BFM}
    "bfsdk bfelf_loader gsl json"
)

# add_subproject(
#     ${BF_SOURCE_DIR}/extended_apis
#     extended_apis
#     ${TOOLCHAIN_PATH_EXTENDED_APIS}
#     "bfsdk binutils bfvmm"
# )

# ------------------------------------------------------------------------------
# Custom build system targets
# ------------------------------------------------------------------------------
include(${BF_TARGETS_DIR}/targets.cmake)
