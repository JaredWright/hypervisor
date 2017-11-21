# ------------------------------------------------------------------------------
# Messages
# ------------------------------------------------------------------------------

# add_custom_command(
        # OUTPUT success_message_completed
        # COMMAND touch success_message_completed
        # COMMAND ${CMAKE_COMMAND} -E cmake_echo_color ""
        # COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --magenta --bold "  ___                __ _           _   "
        # COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --magenta --bold " | _ ) __ _ _ _ ___ / _| |__ _ _ _ | |__"
        # COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --magenta --bold " | _ \\/ _` | '_/ -_)  _| / _` | ' \\| / /"
        # COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --magenta --bold " |___/\\__,_|_| \\___|_| |_\\__,_|_||_|_\\_\\"
        # COMMAND ${CMAKE_COMMAND} -E cmake_echo_color ""
        # COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --green --bold --no-newline " Please give us a star on:"
        # COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --white --bold --no-newline " https://github.com/Bareflank/hypervisor"
        # COMMAND ${CMAKE_COMMAND} -E cmake_echo_color ""
        # COMMAND ${CMAKE_COMMAND} -E cmake_echo_color ""
        # COMMAND ${CMAKE_COMMAND} -E cmake_echo_color ""
        # VERBATIM
# )
#
# add_custom_target(complete_once ALL
#     DEPENDS success_message_completed
# )
#
# add_custom_target(complete_always ALL
#     COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --cyan "Compilation was successful!!!"
# )
#
# if(NOT WIN32)
#     add_dependencies(complete_once bfsdk bfsysroot bfelf_loader bfm bfvmm bfdriver)
#     add_dependencies(complete_always bfsdk bfsysroot bfelf_loader bfm bfvmm bfdriver complete_once)
# else()
#     add_dependencies(complete_once bfsdk bfelf_loader bfm bfdriver)
#     add_dependencies(complete_always bfsdk bfelf_loader bfm bfdriver complete_once)
# endif()
#
# if(ENABLE_UNITTESTING)
#     add_dependencies(complete_once test_bfvmm test_bfsysroot)
#     add_dependencies(complete_always test_bfvmm test_bfsysroot)
# endif()

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

if(BUILD_EXTENDED_APIS)
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

    add_custom_target(test COMMENT "Running unit tests")
    add_custom_command(TARGET test COMMAND ${CMAKE_COMMAND} -E chdir ${BF_BUILD_DIR_BFSDK_TEST} ctest)

    if(${UNITTEST_BFSUPPORT})
        add_custom_command(TARGET test COMMAND ${CMAKE_COMMAND} --build ${BF_BUILD_DIR_BFSUPPORT_TEST} --target test)
    endif()
    if(${UNITTEST_BFDRIVER})
        add_custom_command(TARGET test COMMAND ${CMAKE_COMMAND} -E chdir ${BF_BUILD_DIR_BFDRIVER_TEST} ctest)
    endif()
    if(${UNITTEST_BFELF_LOADER})
        add_custom_command(TARGET test COMMAND ${CMAKE_COMMAND} -E chdir ${BF_BUILD_DIR_BFELF_LOADER_TEST} ctest)
    endif()
    if(${UNITTEST_BFM})
        add_custom_command(TARGET test COMMAND ${CMAKE_COMMAND} -E chdir ${BF_BUILD_DIR_BFM_TEST} ctest)
    endif()
    if(${UNITTEST_VMM})
        add_custom_command(TARGET test COMMAND ${CMAKE_COMMAND} -E chdir ${BF_BUILD_DIR_BFVMM_TEST} ctest)
    endif()
    if(${UNITTEST_EXTENDED_APIS})
        add_custom_command(TARGET test COMMAND ${CMAKE_COMMAND} -E chdir ${BF_BUILD_DIR_EXTENDED_APIS_TEST} ctest)
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

    if(${BUILD_BFDRIVER})
        add_custom_command(TARGET tidy COMMAND cd ${BF_BUILD_DIR_BFDRIVER} && ${TIDY_SCRIPT} diff ${BF_SOURCE_DIR}/bfdriver)
        add_custom_command(TARGET tidy-all COMMAND cd ${BF_BUILD_DIR_BFDRIVER} && ${TIDY_SCRIPT} all ${BF_SOURCE_DIR}/bfdriver)
    endif()

    if(${BUILD_BFM})
        add_custom_command(TARGET tidy COMMAND cd ${BF_BUILD_DIR_BFM} && ${TIDY_SCRIPT} diff ${BF_SOURCE_DIR}/bfm)
        add_custom_command(TARGET tidy-all COMMAND cd ${BF_BUILD_DIR_BFM} && ${TIDY_SCRIPT} all ${BF_SOURCE_DIR}/bfm)
    endif()

    if(${BUILD_VMM})
        add_custom_command(TARGET tidy COMMAND cd ${BF_BUILD_DIR_BFSDK} && ${TIDY_SCRIPT} diff ${BF_SOURCE_DIR}/bfsdk)
        add_custom_command(TARGET tidy-all COMMAND cd ${BF_BUILD_DIR_BFSDK} && ${TIDY_SCRIPT} all ${BF_SOURCE_DIR}/bfsdk)
        add_custom_command(TARGET tidy COMMAND cd ${BF_BUILD_DIR_BFSUPPORT} && ${TIDY_SCRIPT} diff ${BF_SOURCE_DIR}/bfsysroot/bfsupport ${TIDY_EXCLUSIONS_BFSUPPORT})
        add_custom_command(TARGET tidy-all COMMAND cd ${BF_BUILD_DIR_BFSUPPORT} && ${TIDY_SCRIPT} all ${BF_SOURCE_DIR}/bfsysroot/bfsupport ${TIDY_EXCLUSIONS_BFSUPPORT})
        add_custom_command(TARGET tidy COMMAND cd ${BF_BUILD_DIR_BFVMM} && ${TIDY_SCRIPT} diff ${BF_SOURCE_DIR}/bfvmm)
        add_custom_command(TARGET tidy-all COMMAND cd ${BF_BUILD_DIR_BFVMM} && ${TIDY_SCRIPT} all ${BF_SOURCE_DIR}/bfvmm)
    endif()

    if(BUILD_VMM_SHARED)
        add_custom_command(TARGET tidy COMMAND cd ${BF_BUILD_DIR_BFELF_LOADER} && ${TIDY_SCRIPT} diff ${BF_SOURCE_DIR}/bfelf_loader ${TIDY_EXCLUSIONS_BFELF_LOADER})
        add_custom_command(TARGET tidy-all COMMAND cd ${BF_BUILD_DIR_BFELF_LOADER} && ${TIDY_SCRIPT} all ${BF_SOURCE_DIR}/bfelf_loader ${TIDY_EXCLUSIONS_BFELF_LOADER})
    endif()

    if(BUILD_EXTENDED_APIS)
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

    if(BUILD_EXTENDED_APIS)
        add_custom_command(TARGET format COMMAND ${ASTYLE_SCRIPT} diff ${BF_SOURCE_DIR}/extended_apis)
        add_custom_command(TARGET format-all COMMAND ${ASTYLE_SCRIPT} all ${BF_SOURCE_DIR}/extended_apis)
    endif()

endif()
