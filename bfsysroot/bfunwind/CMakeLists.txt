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
project(bfunwind C CXX)

if(ENABLE_UNITTESTING)
    include(CTest)
    enable_testing(true)
endif()

include(${BF_SCRIPTS_DIR}/cmake/macros.cmake)

set(TIDY_EXCLUSIONS ,-cppcoreguidelines-pro*)
# include_directories(${CMAKE_CURRENT_LIST_DIR}/include)
include_directories(${BF_BUILD_INSTALL_DIR}/include)
include_directories(${BF_SOURCE_DIR}/bfsdk/include)
include_directories(${CMAKE_CURRENT_LIST_DIR}/include)
# include_directories(SYSTEM ${BF_BUILD_INSTALL_DIR}/include)

# if(CMAKE_TOOLCHAIN_FILE)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DNOSTDLIB_C")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DNOSTDLIB_C -DNOSTDINC_CXX")
# endif()

add_subdirectory(src)

install(FILES include/ia64_cxx_abi.h DESTINATION ${BF_BUILD_INSTALL_DIR}/include RENAME unwind.h)

