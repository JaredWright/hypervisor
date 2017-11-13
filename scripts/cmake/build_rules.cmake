# ------------------------------------------------------------------------------
# Developer feature build rules
# ------------------------------------------------------------------------------
add_build_rule(
    FAIL_ON ${BUILD_VMM_SHARED} AND ${BUILD_VMM_STATIC}
    FAIL_MSG "Cannot build VMM components as both static and shared in the same build"
)

add_build_rule(
    FAIL_ON NOT ${BUILD_VMM_SHARED} AND NOT ${BUILD_VMM_STATIC} AND ${ENABLE_EXTENDED_APIS}
    FAIL_MSG "Cannot build the Bareflank Extended APIs without building VMM components"
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
    FAIL_ON  ${_ON_WINDOWS} AND ${BUILD_VMM_SHARED} OR ${_ON_WINDOWS} AND ${BUILD_VMM_STATIC} 
    FAIL_MSG "Building VMM components from Windows is not supported. Please disable all BUILD_VMM_* configurations, or build from Cygwin"
)

add_build_rule(
    FAIL_ON  ${_ON_WINDOWS} AND ${ENABLE_COVERITY}
    FAIL_MSG "Coverity is not supported on Windows"
)

add_build_rule(
    FAIL_ON  ${_ON_WINDOWS} AND ${ENABLE_TIDY}
    FAIL_MSG "Clang-tidy is not supported on Windows"
)
