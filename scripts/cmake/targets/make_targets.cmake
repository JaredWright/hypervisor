# ------------------------------------------------------------------------------
# Clean
# ------------------------------------------------------------------------------

add_custom_target(distclean
    COMMAND ${CMAKE_COMMAND} --build . --target clean
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR}/bfdriver/build --target clean
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR}/bfelf_loader/build --target clean
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR}/bfm/build --target clean
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR}/bfsdk/build --target clean

    COMMAND ${CMAKE_COMMAND} -E remove_directory ${BF_BUILD_INSTALL_DIR}/include
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${BF_BUILD_INSTALL_DIR}/lib
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${BF_BUILD_INSTALL_DIR}/sysroots

    COMMAND ${CMAKE_COMMAND} -E remove_directory ${BAREFLANK_INSTALL_TEST_PREFIX}/include
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${BAREFLANK_INSTALL_TEST_PREFIX}/lib
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${BAREFLANK_INSTALL_TEST_PREFIX}/sysroots
)

if(NOT WIN32)
    add_custom_command(TARGET distclean COMMAND ${CMAKE_COMMAND} --build . --target driver_clean)
    add_custom_command(TARGET distclean COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfsysroot/build --target distclean)
    add_custom_command(TARGET distclean COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfvmm/build --target clean)
endif()

if(ENABLE_UNITTESTING)
    add_custom_command(TARGET distclean COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/test_bfsysroot/build --target distclean)
    add_custom_command(TARGET distclean COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/test_bfvmm/build --target clean)
endif()

if(ENABLE_EXTENDED_APIS)

    if(NOT WIN32)
        add_custom_command(TARGET distclean COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/extended_apis/build --target clean)
    endif()

    if(ENABLE_UNITTESTING)
        add_custom_command(TARGET distclean COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/test_extended_apis/build --target clean)
    endif()

endif()


# ------------------------------------------------------------------------------
# Tidy
# ------------------------------------------------------------------------------

# if(ENABLE_TIDY AND NOT WIN32)
#
#     add_custom_target(tidy
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfdriver/build --target tidy
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfm/build --target tidy
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfsdk/build --target tidy
#     )
#
#     add_custom_target(tidy-all
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfdriver/build --target tidy-all
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfm/build --target tidy-all
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfsdk/build --target tidy-all
#     )
#
#     if(BUILD_VMM_SHARED)
#         add_custom_command(TARGET tidy COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfelf_loader/build --target tidy)
#         add_custom_command(TARGET tidy-all COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfelf_loader/build --target tidy-all)
#     endif()
#
#     add_custom_command(TARGET tidy COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfvmm/build --target tidy)
#     add_custom_command(TARGET tidy COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfsysroot/build --target tidy)
#     add_custom_command(TARGET tidy-all COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfvmm/build --target tidy-all)
#     add_custom_command(TARGET tidy-all COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfsysroot/build --target tidy-all)
#
#     if(ENABLE_EXTENDED_APIS)
#         add_custom_command(TARGET tidy COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/extended_apis/build --target tidy)
#         add_custom_command(TARGET tidy-all COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/extended_apis/build --target tidy-all)
#     endif()
#
# endif()

# ------------------------------------------------------------------------------
# Astyle
# ------------------------------------------------------------------------------

# if(ENABLE_ASTYLE AND NOT WIN32)
#
#     add_custom_target(format
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfdriver/build --target format
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfelf_loader/build --target format
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfm/build --target format
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfsdk/build --target format
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfsysroot/build --target format
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfvmm/build --target format
#     )
#
#     add_custom_target(format-all
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfdriver/build --target format-all
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfelf_loader/build --target format-all
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfm/build --target format-all
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfsdk/build --target format-all
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfsysroot/build --target format-all
#         COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfvmm/build --target format-all
#     )
#
#     if(ENABLE_EXTENDED_APIS)
#         add_custom_command(TARGET format COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/extended_apis/build --target format)
#         add_custom_command(TARGET format-all COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/extended_apis/build --target format-all)
#     endif()
#
# ENDIF()

# ------------------------------------------------------------------------------
# BFM
# ------------------------------------------------------------------------------
add_custom_target(
    quick
    COMMAND ${SUDO} ${BUILD_SYSROOT_OS}/bin/bfm quick
    COMMENT "Stopping, unloading, loading, and starting the VMM"
)

add_custom_target(
    stop
    COMMAND ${SUDO} ${BUILD_SYSROOT_OS}/bin/bfm stop
    COMMENT "Stopping the currently loaded VMM"
)

add_custom_target(
    unload
    COMMAND ${SUDO} ${BUILD_SYSROOT_OS}/bin/bfm unload
    COMMENT "Unloading the currently loaded VMM"
)

add_custom_target(
    dump
    COMMAND ${SUDO} ${BUILD_SYSROOT_OS}/bin/bfm dump
    COMMENT "Dumping debug output from the VMM"
)

add_custom_target(
    status
    COMMAND ${SUDO} ${BUILD_SYSROOT_OS}/bin/bfm status
    COMMENT "Displaying status of the current VMM"
)

# ------------------------------------------------------------------------------
# Driver
# ------------------------------------------------------------------------------
add_custom_target(
    driver_quick
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFDRIVER} --target bfdriver_quick
    DEPENDS bfdriver
    COMMENT "Unloading, cleaning, building, and reloading bfdriver"
)

add_custom_target(
    driver_load
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFDRIVER} --target bfdriver_load
    DEPENDS bfdriver
    COMMENT "Loading bfdriver to the local OS"
)

add_custom_target(
    driver_unload
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFDRIVER} --target bfdriver_unload
    DEPENDS bfdriver
    COMMENT "Unloading bfdriver from the local OS"
)

# ------------------------------------------------------------------------------
# Test
# ------------------------------------------------------------------------------
if(ENABLE_UNITTESTING)
    if(POLICY CMP0037)
        cmake_policy(SET CMP0037 OLD)
    endif()

    add_custom_target(
        test
        COMMAND ${CMAKE_COMMAND} -E chdir ${BF_BUILD_DIR_BFDRIVER} ctest
        COMMAND ${CMAKE_COMMAND} -E chdir ${BF_BUILD_DIR_BFELF_LOADER} ctest
        COMMAND ${CMAKE_COMMAND} -E chdir ${BF_BUILD_DIR_BFM} ctest
        COMMAND ${CMAKE_COMMAND} -E chdir ${BF_BUILD_DIR_BFSDK} ctest
        COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFSUPPORT_TEST} --target test
        # COMMAND ${CMAKE_COMMAND} -E chdir ${BF_BUILD_DIR_BFVMM_TEST} ctest
        COMMENT "Running unit tests"
    )

    if(ENABLE_EXTENDED_APIS)
        add_custom_command(
            TARGET test
            COMMAND ${CMAKE_COMMAND} -E chdir ${BF_BUILD_DIR_EXTENDED_APIS} ctest
        )
    endif()
endif()
