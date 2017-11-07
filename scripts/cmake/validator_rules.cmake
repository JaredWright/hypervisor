add_build_rule(
    EXPRESSION ${BUILD_SHARED_LIBS} AND ${BUILD_STATIC_LIBS}
    FAIL_MSG "Cannot build both static and shared libraries in the same build"
)

add_build_rule(
    EXPRESSION NOT ${BUILD_SHARED_LIBS} AND NOT ${BUILD_STATIC_LIBS}
    FAIL_MSG "Must specify either static or shared libraries"
)

add_build_rule(
    EXPRESSION NOT EXISTS ${TOOLCHAIN_PATH_USERSPACE}
    FAIL_MSG "Could not find userspace toolchain file at path ${TOOLCHAIN_PATH_USERSPACE}"
)

add_build_rule(
    EXPRESSION NOT EXISTS ${TOOLCHAIN_PATH_VMM}
    FAIL_MSG "Could not find VMM toolchain file at path ${TOOLCHAIN_PATH_VMM}"
)
