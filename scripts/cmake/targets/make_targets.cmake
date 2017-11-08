
# ------------------------------------------------------------------------------
# Clean
# ------------------------------------------------------------------------------

add_custom_target(distclean
    COMMAND ${CMAKE_COMMAND} --build . --target clean
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfdriver/build --target clean
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfelf_loader/build --target clean
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfm/build --target clean
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/bfsdk/build --target clean

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
# Test
# ------------------------------------------------------------------------------

if(ENABLE_UNITTESTING)

    if(POLICY CMP0037)
        cmake_policy(SET CMP0037 OLD)
    endif()

    add_custom_target(test
        COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_BINARY_DIR}/bfdriver/build ctest
        COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_BINARY_DIR}/bfelf_loader/build ctest
        COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_BINARY_DIR}/bfm/build ctest
        COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_BINARY_DIR}/bfsdk/build ctest
        COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_BINARY_DIR}/test_bfvmm/build ctest
        COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR}/test_bfsysroot/build --target test
    )

    if(ENABLE_EXTENDED_APIS)
        add_custom_command(TARGET test COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_BINARY_DIR}/test_extended_apis/build ctest)
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
# BFM Shortcuts
# ------------------------------------------------------------------------------

if(NOT WIN32)
    add_custom_target(quick COMMAND ${SUDO} ${BF_BUILD_INSTALL_DIR}/bin/bfm quick)
    add_custom_target(stop COMMAND ${SUDO} ${BF_BUILD_INSTALL_DIR}/bin/bfm stop)
    add_custom_target(unload COMMAND ${SUDO} ${BF_BUILD_INSTALL_DIR}/bin/bfm unload)
    add_custom_target(dump COMMAND ${SUDO} ${BF_BUILD_INSTALL_DIR}/bin/bfm dump)
    add_custom_target(status COMMAND ${SUDO} ${BF_BUILD_INSTALL_DIR}/bin/bfm status)
endif()

# ------------------------------------------------------------------------------
# Driver Shortcuts
# ------------------------------------------------------------------------------

if(NOT WIN32)
    add_custom_target(driver_build COMMAND make driver_build > /dev/null VERBATIM WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/bfdriver/build)
    add_custom_target(driver_load COMMAND make driver_load > /dev/null VERBATIM WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/bfdriver/build)
    add_custom_target(driver_unload COMMAND make driver_unload > /dev/null VERBATIM WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/bfdriver/build)
    add_custom_target(driver_clean COMMAND make driver_clean > /dev/null VERBATIM WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/bfdriver/build)
    # add_custom_target(driver_build COMMAND ${CMAKE_SOURCE_DIR}/scripts/driver_build.sh ${CMAKE_SOURCE_DIR})
    # add_custom_target(driver_clean COMMAND ${CMAKE_SOURCE_DIR}/scripts/driver_clean.sh ${CMAKE_SOURCE_DIR})
    # add_custom_target(driver_load COMMAND ${CMAKE_SOURCE_DIR}/scripts/driver_load.sh ${CMAKE_SOURCE_DIR})
    # add_custom_target(driver_unload COMMAND ${CMAKE_SOURCE_DIR}/scripts/driver_unload.sh ${CMAKE_SOURCE_DIR})

    add_custom_target(driver_quick)
    add_custom_command(TARGET driver_quick COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target driver_unload)
    add_custom_command(TARGET driver_quick COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target driver_clean)
    add_custom_command(TARGET driver_quick COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target driver_build)
    add_custom_command(TARGET driver_quick COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target driver_load)
endif()
