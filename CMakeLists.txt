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
project(hypervisor C CXX)

set(BAREFLANK_INSTALL_TEST_PREFIX ${CMAKE_BINARY_DIR}/bfprefix_test)

include(${CMAKE_SOURCE_DIR}/scripts/cmake/global_vars.cmake)
include(${CMAKE_SOURCE_DIR}/scripts/cmake/macros.cmake)
include(${BF_CONFIG_DIR}/default.cmake)
include(${BF_FLAGS_DIR}/flags.cmake)

# Global properties for all projects built using ExternalProject_Add()
include(ExternalProject)
set_property(GLOBAL PROPERTY EP_PREFIX ${BF_BUILD_DEPENDS_DIR})
if(ENABLE_DEPEND_UPDATES)
    set_property(GLOBAL PROPERTY EP_UPDATE_DISCONNECTED OFF)
else()
    set_property(GLOBAL PROPERTY EP_UPDATE_DISCONNECTED ON)
endif()

# Download, build, and check local system for build dependencies
include(${BF_DEPENDS_DIR}/depends.cmake)

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
cross_compile_project(
    ${CMAKE_SOURCE_DIR}/bfsysroot/bfunwind
    bfunwind
    ${TOOLCHAIN_PATH_BFUNWIND}
    "newlib"
)

include(${BF_SCRIPTS_DIR}/cmake/subprojects/bfsdk.cmake)
include(${BF_SCRIPTS_DIR}/cmake/subprojects/bfsysroot.cmake)
include(${BF_DEPENDS_DIR}/libcxx_src.cmake)
include(${BF_SCRIPTS_DIR}/cmake/subprojects/bfsupport.cmake)
# include(${BF_DEPENDS_DIR}/libcxxabi.cmake)
# include(${BF_DEPENDS_DIR}/libcxx.cmake)
include(${BF_SCRIPTS_DIR}/cmake/subprojects/bfelf_loader.cmake)
include(${BF_SCRIPTS_DIR}/cmake/subprojects/bfm.cmake)
include(${BF_SCRIPTS_DIR}/cmake/subprojects/bfvmm.cmake)
include(${BF_SCRIPTS_DIR}/cmake/subprojects/bfdriver.cmake)
include(${BF_SCRIPTS_DIR}/cmake/subprojects/extended_apis.cmake)

include(${BF_TARGETS_DIR}/targets.cmake)
