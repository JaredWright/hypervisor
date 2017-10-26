# TODO: Toolchain for detecting a currently installed clang/binutils toolchain
# on the environment cmake is running on

# set(CMAKE_SYSTEM_NAME Generic CACHE INTERNAL "")
# set(CMAKE_SYSTEM_PROCESSOR ARM CACHE INTERNAL "")
set(TOOLCHAIN_TRIPLE "" CACHE INTERNAL "")

# C compiler and target architecture
set(CMAKE_C_COMPILER "clang" CACHE INTERNAL "")
# set(CMAKE_C_COMPILER_TARGET "arm64-none-eabi" CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER "clang" CACHE INTERNAL "")
# set(CMAKE_CXX_COMPILER_TARGET "arm64-none-eabi" CACHE INTERNAL "")

# Assembler
set(CMAKE_ASM_COMPILER "${TOOLCHAIN_TRIPLE}as" CACHE INTERNAL "")

# Linker
# Cmake doens't provide a CMAKE_LINKER option, so specify the linker like this:
set(CMAKE_C_LINK_EXECUTABLE
	"${TOOLCHAIN_TRIPLE}ld \
	<CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>"
    CACHE INTERNAL ""
)
set(CMAKE_CXX_LINK_EXECUTABLE
	"${TOOLCHAIN_TRIPLE}ld \
	<CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>"
    CACHE INTERNAL ""
)

# Other binutils for this toolchain
set(CMAKE_AR "${TOOLCHAIN_TRIPLE}ar" CACHE INTERNAL "")
set(CMAKE_RANLIB "${TOOLCHAIN_TRIPLE}ranlib" CACHE INTERNAL "")
set(CMAKE_OBJCOPY "${TOOLCHAIN_TRIPLE}objcopy" CACHE INTERNAL "")
# .. etc

# Disable cmake compiler and linker tests
# This allows aarch64-linux-gnu-ld to link for baremetal targets without
# having to pass the built-in cmake linker test (which fails for baremetal)
set(CMAKE_C_COMPILER_WORKS 1 CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER_WORKS 1 CACHE INTERNAL "")

# Toolchain specific compile flags can be added here like this:
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}" CACHE INTERNAL "")
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -target arm64-none-eabi")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}" CACHE INTERNAL "")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -target arm64-none-eabi")

# Toolchain specific link flags can be added here like this:
set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS}" CACHE INTERNAL "")
set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS} -nostdlib")
set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS} -nostartfiles")

