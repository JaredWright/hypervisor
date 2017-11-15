# ------------------------------------------------------------------------------
# General build rules
# ------------------------------------------------------------------------------
add_build_rule(
    FAIL_ON ${BUILD_VMM_SHARED} AND ${BUILD_VMM_STATIC}
    FAIL_MSG "Cannot build VMM components as both static and shared in the same build"
)

add_build_rule(
    FAIL_ON NOT ${BUILD_VMM} AND ${BUILD_EXTENDED_APIS}
    FAIL_MSG "Cannot build the Bareflank Extended APIs without building VMM components, enable BUILD_VMM"
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
