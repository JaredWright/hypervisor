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

include(ExternalProject)
set_property(GLOBAL PROPERTY EP_BASE "${BF_BUILD_DEPENDS_DIR}/${BUILD_TARGET_ARCH}")
# set_property(GLOBAL PROPERTY EP_PREFIX ${BF_BUILD_DEPENDS_DIR})

include(${BF_DEPENDS_DIR}/python.cmake)
include(${BF_DEPENDS_DIR}/git.cmake)
include(${BF_DEPENDS_DIR}/binutils.cmake)
include(${BF_DEPENDS_DIR}/gsl.cmake)
include(${BF_DEPENDS_DIR}/json.cmake)
include(${BF_DEPENDS_DIR}/newlib.cmake)
include(${BF_DEPENDS_DIR}/llvm.cmake)
include(${BF_DEPENDS_DIR}/libcxxabi.cmake)
include(${BF_DEPENDS_DIR}/libcxx.cmake)

# TODO move this check to an x86 toolchain file
# if(is an x86 build)
    include(${BF_DEPENDS_DIR}/nasm.cmake)
# endif()

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
