# An example of how to override the default configuration to make a new one

include(${CMAKE_CURRENT_LIST_DIR}/../global_vars.cmake)

set(BUILD_TYPE "Debug")
set(BUILD_TARGET_OS "Linux")
set(BUILD_TARGET_ARCH "aarch64")
set(ENABLE_UNITTESTING ON)
set(ENABLE_ASAN ON)
set(ENABLE_USAN ON)

set(TOOLCHAIN_PATH_USERSPACE "${BF_TOOLCHAIN_DIR}/clang_aarch64_linux_eabi.cmake")
set(TOOLCHAIN_PATH_VMM "${BF_TOOLCHAIN_DIR}/clang_aarch64_none_eabi.cmake")

find_program(_NEWLIB_CC "aarch64-linux-gnu-gcc")
set(_NEWLIB_CC ${_NEWLIB_CC} CACHE INTERNAL "")
set(TOOLCHAIN_NEWLIB_CC ${_NEWLIB_CC})
