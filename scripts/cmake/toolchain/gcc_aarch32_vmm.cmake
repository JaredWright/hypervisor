#
# Bareflank Hypervisor
# Copyright (C) 2018 Assured Information Security, Inc.
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

if(CMAKE_INSTALL_PREFIX)
    set(ENV{CMAKE_INSTALL_PREFIX} "${CMAKE_INSTALL_PREFIX}")
else()
    set(CMAKE_INSTALL_PREFIX "$ENV{CMAKE_INSTALL_PREFIX}")
endif()

set(CMAKE_SYSTEM_NAME Linux)

if(NOT WIN32)
    set(CMAKE_C_COMPILER /usr/bin/arm-linux-gnueabihf-gcc)
    set(CMAKE_CXX_COMPILER /usr/bin/arm-linux-gnueabihf-gcc)
endif()

string(CONCAT LD_FLAGS
    "--sysroot=${CMAKE_INSTALL_PREFIX} "
    "-L${CMAKE_INSTALL_PREFIX}/lib "
    "-z max-page-size=4096 "
    "-z common-page-size=4096 "
    "-z relro "
    "-z now "
    "-nostdlib "
)

if(EXISTS "${CMAKE_INSTALL_PREFIX}/lib/libbfdso_static.a")
    string(CONCAT LD_FLAGS
        "--whole-archive ${CMAKE_INSTALL_PREFIX}/lib/libbfdso_static.a --no-whole-archive "
    )
endif()

if(DEFINED ENV{LD_BIN})
    set(LD_BIN $ENV{LD_BIN})
else()
    set(LD_BIN arm-linux-gnueabihf-ld)
endif()

if(DEFINED ENV{AR_BIN})
    set(AR_BIN $ENV{AR_BIN})
else()
    set(AR_BIN arm-linux-gnueabihf-ar)
endif()

set(CMAKE_C_ARCHIVE_CREATE
    "${AR_BIN} qc <TARGET> <OBJECTS>"
)

set(CMAKE_CXX_ARCHIVE_CREATE
    "${AR_BIN} qc <TARGET> <OBJECTS>"
)

set(CMAKE_C_LINK_EXECUTABLE
    "${LD_BIN} ${LD_FLAGS} -pie <OBJECTS> -o <TARGET> <LINK_LIBRARIES> "
)

set(CMAKE_CXX_LINK_EXECUTABLE
    "${LD_BIN} ${LD_FLAGS} -pie <OBJECTS> -o <TARGET> <LINK_LIBRARIES>"
)

set(CMAKE_C_CREATE_SHARED_LIBRARY
    "${LD_BIN} ${LD_FLAGS} -shared <OBJECTS> -o <TARGET>"
)

set(CMAKE_CXX_CREATE_SHARED_LIBRARY
    "${LD_BIN} ${LD_FLAGS} -shared <OBJECTS> -o <TARGET>"
)

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)
