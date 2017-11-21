# ------------------------------------------------------------------------------
# General build rules
# ------------------------------------------------------------------------------
# add_build_rule(
#     FAIL_ON ${BUILD_VMM_SHARED} AND ${BUILD_VMM_STATIC}
#     FAIL_MSG "Cannot build VMM components as both static and shared in the same build"
# )

add_build_rule(
    FAIL_ON ${BUILD_VMM} AND NOT ${BUILD_VMM_SHARED} AND NOT ${BUILD_VMM_STATIC}
    FAIL_MSG "Must enable either BUILD_VMM_SHARED or BUILD_VMM_STATIC when building VMM components"
)

add_build_rule(
    FAIL_ON ${BUILD_BFDRIVER} AND NOT ${BUILD_BFELF_LOADER}
    FAIL_MSG "Cannot build the Bareflank driver without building the Bareflank elf loader, enable BUILD_BFELF_LOADER"
)

add_build_rule(
    FAIL_ON ${BUILD_BFM} AND NOT ${BUILD_BFELF_LOADER}
    FAIL_MSG "Cannot build bfm without building the Bareflank elf loader, enable BUILD_BFELF_LOADER"
)

add_build_rule(
    FAIL_ON NOT ${BUILD_VMM} AND ${BUILD_EXTENDED_APIS}
    FAIL_MSG "Cannot build the Bareflank Extended APIs without building VMM components, enable BUILD_VMM"
)

# ------------------------------------------------------------------------------
# Unit testing build rules
# ------------------------------------------------------------------------------
add_build_rule(
    FAIL_ON ${UNITTEST_VMM} AND NOT ${BUILD_VMM_STATIC}
    FAIL_MSG "Must enable BUILD_VMM_STATIC when building unit tests for VMM components"
)

add_build_rule(
    FAIL_ON ${UNITTEST_VMM} AND NOT ${BUILD_VMM_STATIC}
    FAIL_MSG "VMM unit testing is not supported for VMM shared library builds, disable BUILD_VMM_SHARED"
)

add_build_rule(
    FAIL_ON ${UNITTEST_BFDRIVER} AND NOT ${BUILD_VMM}
    FAIL_MSG "Shared library VMM components are required for driver unit tests, please enable BUILD_VMM and BUILD_VMM_SHARED"
)

add_build_rule(
    FAIL_ON ${UNITTEST_BFDRIVER} AND NOT ${BUILD_VMM_SHARED}
    FAIL_MSG "Shared library VMM components are required for driver unit tests, please enable BUILD_VMM and BUILD_VMM_SHARED"
)

add_build_rule(
    FAIL_ON ${UNITTEST_BFDRIVER} AND NOT ${BUILD_BFELF_LOADER}
    FAIL_MSG "The Bareflank elf loader is required for driver unit tests, please enable BUILD_BFELF_LOADER"
)

add_build_rule(
    FAIL_ON ${UNITTEST_BFELF_LOADER} AND NOT ${BUILD_VMM}
    FAIL_MSG "Shared library VMM components are required for elf loader unit tests, please enable BUILD_VMM and BUILD_VMM_SHARED"
)

add_build_rule(
    FAIL_ON ${UNITTEST_BFELF_LOADER} AND NOT ${BUILD_VMM_SHARED}
    FAIL_MSG "Shared library VMM components are required for elf loader unit tests, please enable BUILD_VMM and BUILD_VMM_SHARED"
)

add_build_rule(
    FAIL_ON ${UNITTEST_EXTENDED_APIS} AND NOT ${UNITTEST_VMM}
    FAIL_MSG "Extended APIs unit tests require VMM unit tests, please enable UNITTEST_VMM"
)

# ------------------------------------------------------------------------------
# Windows build rules
# ------------------------------------------------------------------------------
set(_ON_WINDOWS ${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows" CACHE INTERNAL "")
add_build_rule(
    FAIL_ON  ${_ON_WINDOWS} AND ${ENABLE_UNITTESTING}
    FAIL_MSG "Unit testing is not supported on Windows"
)

add_build_rule(
    FAIL_ON  ${_ON_WINDOWS} AND ${BUILD_VMM}
    FAIL_MSG "Building VMM components from Windows is not supported"
)

add_build_rule(
    FAIL_ON  ${_ON_WINDOWS} AND ${ENABLE_CODECOV}
    FAIL_MSG "Code coverage is not supported on Windows"
)

add_build_rule(
    FAIL_ON  ${_ON_WINDOWS} AND ${ENABLE_TIDY}
    FAIL_MSG "Clang-tidy is not supported on Windows"
)

# ------------------------------------------------------------------------------
# Linux build rules
# ------------------------------------------------------------------------------
set(_ON_LINUX ${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Linux" CACHE INTERNAL "")
add_build_rule(
    FAIL_ON  ${_ON_LINUX} AND ${BUILD_TARGET_OS} STREQUAL "Windows"
    FAIL_MSG "Building Windows components from Linux is not supported, please set BUILD_TARGET_OS to Linux"
)

