# ------------------------------------------------------------------------------
# Developer feature build rules
# ------------------------------------------------------------------------------
add_build_rule(
    FAIL_ON ${BUILD_SHARED_LIBS} AND ${BUILD_STATIC_LIBS}
    FAIL_MSG "Cannot build both static and shared libraries in the same build"
)

add_build_rule(
    FAIL_ON NOT ${BUILD_SHARED_LIBS} AND NOT ${BUILD_STATIC_LIBS}
    FAIL_MSG "Must specify either static or shared libraries"
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
    FAIL_ON  ${_ON_WINDOWS} AND ${ENABLE_COVERITY}
    FAIL_MSG "Coverity is not supported on Windows"
)

add_build_rule(
    FAIL_ON  ${_ON_WINDOWS} AND ${ENABLE_TIDY}
    FAIL_MSG "Clang-tidy is not supported on Windows"
)
