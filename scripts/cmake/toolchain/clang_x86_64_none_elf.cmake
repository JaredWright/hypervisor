set(CMAKE_SYSTEM_NAME Generic CACHE INTERNAL "")
set(CMAKE_SYSTEM_PROCESSOR x86_64 CACHE INTERNAL "")
set(TOOLCHAIN_TRIPLE "x86_64-linux-gnu" CACHE INTERNAL "")
SET(CMAKE_CROSSCOMPILING ON CACHE INTERNAL "")

# C and C++ compiler
set(CMAKE_C_COMPILER "clang" CACHE INTERNAL "")
set(CMAKE_C_COMPILER_TARGET "x86_64-elf" CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER "clang" CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER_TARGET "x86_64-elf" CACHE INTERNAL "")

# Assembler and other binutils
set(CMAKE_ASM_COMPILER "${TOOLCHAIN_TRIPLE}-as" CACHE INTERNAL "")
set(CMAKE_AR "${TOOLCHAIN_TRIPLE}-ar" CACHE INTERNAL "")
set(CMAKE_RANLIB "${TOOLCHAIN_TRIPLE}-ranlib" CACHE INTERNAL "")
set(CMAKE_OBJCOPY "${TOOLCHAIN_TRIPLE}-objcopy" CACHE INTERNAL "")

# Linker
# Cmake doens't provide a CMAKE_LINKER option, so specify the linker like this:
set(CMAKE_C_LINK_EXECUTABLE
    "${TOOLCHAIN_TRIPLE}-ld \
    <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>"
    CACHE INTERNAL ""
)
set(CMAKE_CXX_LINK_EXECUTABLE
    "${TOOLCHAIN_TRIPLE}-ld \
    <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>"
    CACHE INTERNAL ""
)

# Disable cmake compiler and linker tests
# This allows aarch64-linux-gnu-ld to link for baremetal targets without
# having to pass the built-in cmake linker test (which fails for baremetal)
set(CMAKE_C_COMPILER_WORKS 1 CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER_WORKS 1 CACHE INTERNAL "")
