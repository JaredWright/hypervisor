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
project(bfsysroot C CXX)

set(DISABLE_WARNINGS ON)
set(DISABLE_VISIBILITY_HIDDEN ON)

# ------------------------------------------------------------------------------
# Clean
# ------------------------------------------------------------------------------

if(ENABLE_UNITTESTING)

    add_custom_target(distclean
        COMMAND ${CMAKE_COMMAND} --build . --target clean
        COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfunwind/build --target clean
        COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfsupport/build --target clean
    )

else()

    add_custom_target(distclean
        COMMAND ${CMAKE_COMMAND} --build . --target clean
        COMMAND make -C ${CMAKE_BINARY_DIR}/newlib/build clean > /dev/null 2>&1
        COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfunwind/build --target clean
        COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/libcxxabi/build --target clean
        COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/libcxx/build --target clean
        COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfsupport/build --target clean
    )

endif()

# ------------------------------------------------------------------------------
# Test
# ------------------------------------------------------------------------------

if(ENABLE_UNITTESTING)

    if(POLICY CMP0037)
        cmake_policy(SET CMP0037 OLD)
    endif()

    add_custom_target(test
        COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_BINARY_DIR}/bfsupport/build ctest
    )

endif()

