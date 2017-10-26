#
# Bareflank Hypervisor
# Copyright (C) 2015 Assured Information Security, Inc.
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
    #oooooooooooooo version 2.1 of the License, or (at your option) any later version.
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
project(bfsdk C CXX)

include(${CMAKE_SOURCE_DIR}/../scripts/cmake/macros.cmake)

if(ENABLE_UNITTESTING)
    include(CTest)
    enable_testing(true)
    add_subdirectory(tests)
endif()

list(APPEND SDK_HEADER_FILES
    include/bfaffinity.h
    include/bfbenchmark.h   
    include/bfbitmanip.h
    include/bfbuffer.h
    include/bfconstants.h
    include/bfdebug.h
    include/bfdebugringinterface.h
    include/bfdriverinterface.h
    include/bfdwarf.h
    include/bfehframelist.h
    include/bferrorcodes.h
    include/bfexception.h
    include/bfexports.h
    include/bffile.h
    include/bfgsl.h
    include/bfjson.h
    include/bfmemory.h
    include/bfnewdelete.h
    include/bfplatform.h
    include/bfshuffle.h
    include/bfstd.h
    include/bfstring.h
    include/bfsupport.h
    include/bfthreadcontext.h
    include/bftypes.h
    include/bfupperlower.h
    include/bfvcpuid.h
    include/bfvector.h
    include/bfvmcallinterface.h
)

install(FILES ${SDK_HEADER_FILES} DESTINATION ${BF_BUILD_INSTALL_DIR}/include)

install(FILES src/bfvmcall_intel_x64.asm DESTINATION ${BF_BUILD_INSTALL_DIR}/src)

install(
    PROGRAMS ${BF_SCRIPTS_DIR}/util/compiler_wrapper.sh
    DESTINATION ${BF_BUILD_INSTALL_DIR}/bin RENAME x86_64-vmm-clang
)
