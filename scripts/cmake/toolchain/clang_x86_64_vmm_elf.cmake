# TODO: This toolchain uses the legacy "compiler_wrapper.sh" script, along
# with a version of binutils built from source to emulate
# a new clang compiler and binutils for bare-metal x86_64 targets. 
# This toolchain works, but is extremely complex. It would be preferable to
# replace this toolchain with clang_x86_64_none_elf.cmake in the future

set(CMAKE_SYSTEM_NAME Linux)

# Hack to allow toolchain files to access cmake cache variables
if(BUILD_SYSROOT_VMM)
    set(ENV{_BUILD_SYSROOT_VMM} "${BUILD_SYSROOT_VMM}")
else()
    set(BUILD_SYSROOT_VMM "$ENV{_BUILD_SYSROOT_VMM}")
endif()

# C and C++ compiler
find_program(CC_PATH x86_64-vmm-clang "${BUILD_SYSROOT_VMM}/bin")
set(CMAKE_C_COMPILER ${CC_PATH} CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER ${CC_PATH} CACHE INTERNAL "")

# Assembler and other binutils
find_program(NASM_PATH nasm)
set(CMAKE_ASM_COMPILER ${NASM_PATH} CACHE INTERNAL "")
find_program(AR_PATH x86_64-vmm-elf-ar "${BUILD_SYSROOT_VMM}/bin")
set(CMAKE_AR ${AR_PATH} CACHE INTERNAL "")
find_program(RANLIB_PATH x86_64-vmm-elf-ranlib "${BUILD_SYSROOT_VMM}/bin")
set(CMAKE_RANLIB ${RANLIB_PATH} CACHE INTERNAL "")
find_program(OBJCOPY_PATH x86_64-vmm-elf-objcopy "${BUILD_SYSROOT_VMM}/bin")
set(CMAKE_OBJCOPY ${OBJCOPY_PATH} CACHE INTERNAL "")
