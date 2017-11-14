# ------------------------------------------------------------------------------
# Clean
# ------------------------------------------------------------------------------

add_custom_target(
    distclean
    COMMAND ${CMAKE_COMMAND} --build . --target clean
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFDRIVER} --target clean
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFELF_LOADER} --target clean
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFM} --target clean
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFSDK} --target clean
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFSUPPORT} --target clean
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFUNWIND} --target clean
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFVMM} --target clean
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${BF_BUILD_INSTALL_DIR}
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${BF_BUILD_DEPENDS_DIR}
    COMMENT "Cleaning build tree, removing all dependencies, and removing all build artifacts"
)

if(ENABLE_UNITTESTING)
    add_custom_command(TARGET distclean COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFSUPPORT_TEST} --target clean)
    add_custom_command(TARGET distclean COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_VMM_TEST} --target clean)
endif()

if(ENABLE_EXTENDED_APIS)
    add_custom_command(TARGET distclean COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_EXTENDED_APIS} --target clean)
    if(ENABLE_UNITTESTING)
        add_custom_command(TARGET distclean COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_EXTENDED_APIS_TEST})
    endif()
endif()

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
    COMMENT "Unloading, cleaning, building, and reloading bfdriver"
)

add_custom_target(
    driver_load
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFDRIVER} --target bfdriver_load
    COMMENT "Loading bfdriver to the local OS"
)

add_custom_target(
    driver_unload
    COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFDRIVER} --target bfdriver_unload
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

# ------------------------------------------------------------------------------
# Clang Tidy
# ------------------------------------------------------------------------------
if(ENABLE_TIDY)

    set(TIDY_SCRIPT ${BF_SCRIPTS_DIR}/util/bareflank_clang_tidy.sh CACHE INTERNAL "")
    set(TIDY_EXCLUSIONS_BFELF_LOADER ,-cppcoreguidelines-pro-type-const-cast CACHE INTERNAL "") 
    set(TIDY_EXCLUSIONS_BFSUPPORT ,-cert-err34-c,-misc-misplaced-widening-cast,-cppcoreguidelines-no-malloc CACHE INTERNAL "") 
    set(TIDY_EXCLUSIONS_BFUNWIND ,-cppcoreguidelines-pro* CACHE INTERNAL "") 

    add_custom_target(tidy COMMENT "Running clang-tidy static analysis checks")
    add_custom_target(tidy-all COMMENT "Running all clang-tidy static analysis checks")

    if(NOT ${BUILD_TARGET_OS} STREQUAL None)
        add_custom_command(TARGET tidy COMMAND cd ${BF_BUILD_DIR_BFSDK} && ${TIDY_SCRIPT} diff ${BF_SOURCE_DIR}/bfsdk)
        add_custom_command(TARGET tidy-all COMMAND cd ${BF_BUILD_DIR_BFSDK} && ${TIDY_SCRIPT} all ${BF_SOURCE_DIR}/bfsdk)
        add_custom_command(TARGET tidy COMMAND cd ${BF_BUILD_DIR_BFDRIVER} && ${TIDY_SCRIPT} diff ${BF_SOURCE_DIR}/bfdriver)
        add_custom_command(TARGET tidy-all COMMAND cd ${BF_BUILD_DIR_BFDRIVER} && ${TIDY_SCRIPT} all ${BF_SOURCE_DIR}/bfdriver)
        add_custom_command(TARGET tidy COMMAND cd ${BF_BUILD_DIR_BFM} && ${TIDY_SCRIPT} diff ${BF_SOURCE_DIR}/bfm)
        add_custom_command(TARGET tidy-all COMMAND cd ${BF_BUILD_DIR_BFM} && ${TIDY_SCRIPT} all ${BF_SOURCE_DIR}/bfm)
    endif()

    if(${BUILD_VMM_SHARED} OR ${BUILD_VMM_STATIC})
        add_custom_command(TARGET tidy COMMAND cd ${BF_BUILD_DIR_BFSUPPORT} && ${TIDY_SCRIPT} diff ${BF_SOURCE_DIR}/bfsysroot/bfsupport ${TIDY_EXCLUSIONS_BFSUPPORT})
        add_custom_command(TARGET tidy-all COMMAND cd ${BF_BUILD_DIR_BFSUPPORT} && ${TIDY_SCRIPT} all ${BF_SOURCE_DIR}/bfsysroot/bfsupport ${TIDY_EXCLUSIONS_BFSUPPORT})
        add_custom_command(TARGET tidy COMMAND cd ${BF_BUILD_DIR_BFVMM} && ${TIDY_SCRIPT} diff ${BF_SOURCE_DIR}/bfvmm)
        add_custom_command(TARGET tidy-all COMMAND cd ${BF_BUILD_DIR_BFVMM} && ${TIDY_SCRIPT} all ${BF_SOURCE_DIR}/bfvmm)
    endif()

    if(BUILD_VMM_SHARED)
        add_custom_command(TARGET tidy COMMAND cd ${BF_BUILD_DIR_BFELF_LOADER} && ${TIDY_SCRIPT} diff ${BF_SOURCE_DIR}/bfelf_loader ${TIDY_EXCLUSIONS_BFELF_LOADER})
        add_custom_command(TARGET tidy-all COMMAND cd ${BF_BUILD_DIR_BFELF_LOADER} && ${TIDY_SCRIPT} all ${BF_SOURCE_DIR}/bfelf_loader ${TIDY_EXCLUSIONS_BFELF_LOADER})
    endif()

    if(ENABLE_EXTENDED_APIS)
        add_custom_command(TARGET tidy COMMAND cd ${BF_BUILD_DIR_EXTENDED_APIS} && ${TIDY_SCRIPT} diff ${BF_SOURCE_DIR}/extended_apis)
        add_custom_command(TARGET tidy-all COMMAND cd ${BF_BUILD_DIR_EXTENDED_APIS} && ${TIDY_SCRIPT} all ${BF_SOURCE_DIR}/extended_apis)
    endif()

endif()

# ------------------------------------------------------------------------------
# Astyle
# ------------------------------------------------------------------------------

if(ENABLE_ASTYLE)

    set(ASTYLE_SCRIPT ${BF_SCRIPTS_DIR}/util/bareflank_astyle_format.sh CACHE INTERNAL "")

    add_custom_target(
        format
        COMMAND ${ASTYLE_SCRIPT} diff ${BF_SOURCE_DIR}/bfdriver
        COMMAND ${ASTYLE_SCRIPT} diff ${BF_SOURCE_DIR}/bfelf_loader
        COMMAND ${ASTYLE_SCRIPT} diff ${BF_SOURCE_DIR}/bfm
        COMMAND ${ASTYLE_SCRIPT} diff ${BF_SOURCE_DIR}/bfsdk
        COMMAND ${ASTYLE_SCRIPT} diff ${BF_SOURCE_DIR}/bfsysroot
        COMMAND ${ASTYLE_SCRIPT} diff ${BF_SOURCE_DIR}/bfvmm
        COMMENT "Running astyle code format checks"
    )

    add_custom_target(
        format-all
        COMMAND ${ASTYLE_SCRIPT} all ${BF_SOURCE_DIR}/bfdriver
        COMMAND ${ASTYLE_SCRIPT} all ${BF_SOURCE_DIR}/bfelf_loader
        COMMAND ${ASTYLE_SCRIPT} all ${BF_SOURCE_DIR}/bfm
        COMMAND ${ASTYLE_SCRIPT} all ${BF_SOURCE_DIR}/bfsdk
        COMMAND ${ASTYLE_SCRIPT} all ${BF_SOURCE_DIR}/bfsysroot
        COMMAND ${ASTYLE_SCRIPT} all ${BF_SOURCE_DIR}/bfvmm
        COMMENT "Running all astyle code format checks"
    )

    if(ENABLE_EXTENDED_APIS)
        add_custom_command(TARGET format COMMAND ${ASTYLE_SCRIPT} diff ${BF_SOURCE_DIR}/extended_apis)
        add_custom_command(TARGET format-all COMMAND ${ASTYLE_SCRIPT} all ${BF_SOURCE_DIR}/extended_apis)
    endif()

endif()
