# TODO: This toolchain uses the legacy "compiler_wrapper.sh" script, along
# with a version of binutils built from source to emulate
# a new clang compiler and binutils for bare-metal x86_64 targets. 
# This toolchain works, but is extremely complex. It would be preferable to
# replace this toolchain with clang_x86_64_none_elf.cmake in the future

set(CMAKE_SYSTEM_NAME Linux)

# C and C++ compiler
find_program(CC_PATH x86_64-vmm-clang)
set(CMAKE_C_COMPILER ${CC_PATH} CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER ${CC_PATH} CACHE INTERNAL "")

# Assembler and other binutils
find_program(NASM_PATH nasm)
set(CMAKE_ASM_COMPILER ${NASM_PATH} CACHE INTERNAL "")
find_program(AR_PATH x86_64-vmm-elf-ar)
set(CMAKE_AR ${AR_PATH} CACHE INTERNAL "")
find_program(RANLIB_PATH x86_64-vmm-elf-ranlib)
set(CMAKE_RANLIB ${RANLIB_PATH} CACHE INTERNAL "")
find_program(OBJCOPY_PATH x86_64-vmm-elf-objcopy)
set(CMAKE_OBJCOPY ${OBJCOPY_PATH} CACHE INTERNAL "")

# Custom compiler flags for compiler_wrapper.sh
execute_process(COMMAND uname -o OUTPUT_VARIABLE UNAME OUTPUT_STRIP_TRAILING_WHITESPACE)
if(UNAME STREQUAL "Cygwin" OR WIN32)
    set(OSTYPE "WIN64" CACHE INTERNAL "")
    set(ABITYPE "MS64" CACHE INTERNAL "")
    set(WIN64 ON)
else()
    set(OSTYPE "UNIX" CACHE INTERNAL "")
    set(ABITYPE "SYSV" CACHE INTERNAL "")
endif()

# Toolchain specific compile and link flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c11 -DVMM -D${OSTYPE} -D${ABITYPE}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -x c++ -std=c++1z -DVMM -D${OSTYPE} -D${ABITYPE}")

set(COMMON_FLAGS "-fpic")
set(COMMON_FLAGS "${COMMON_FLAGS} -msse")
set(COMMON_FLAGS "${COMMON_FLAGS} -msse2")
set(COMMON_FLAGS "${COMMON_FLAGS} -msse3")
set(COMMON_FLAGS "${COMMON_FLAGS} -mno-red-zone")
set(COMMON_FLAGS "${COMMON_FLAGS} -mstackrealign")
set(COMMON_FLAGS "${COMMON_FLAGS} -fstack-protector-strong")
set(COMMON_FLAGS "${COMMON_FLAGS} -DMALLOC_PROVIDED")
set(COMMON_FLAGS "${COMMON_FLAGS} -DGSL_THROW_ON_CONTRACT_VIOLATION")

if(NOT DISABLE_VISIBILITY_HIDDEN)
    set(COMMON_FLAGS "${COMMON_FLAGS} -fvisibility=hidden")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility-inlines-hidden")
endif()

if(NOT DISABLE_WARNINGS)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wextra")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wpedantic")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wshadow")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wcast-align")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wconversion")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wsign-conversion")

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wextra")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wpedantic")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wctor-dtor-privacy")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wshadow")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wnon-virtual-dtor")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wold-style-cast")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wcast-align")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Woverloaded-virtual")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wconversion")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wsign-conversion")
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${COMMON_FLAGS}" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${COMMON_FLAGS}" CACHE INTERNAL "")
