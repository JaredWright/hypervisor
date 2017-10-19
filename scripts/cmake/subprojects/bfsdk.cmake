# ------------------------------------------------------------------------------
# SDK
# ------------------------------------------------------------------------------

list(APPEND BFSDK_CMAKE_ARGS
    -DBAREFLANK_SOURCE_DIR=${CMAKE_SOURCE_DIR}
    -DBAREFLANK_BINARY_DIR=${CMAKE_BINARY_DIR}
    -DCMAKE_INSTALL_PREFIX=${BF_BUILD_INSTALL_DIR}
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DENABLE_COVERAGE=${ENABLE_COVERAGE}
    -DENABLE_DYNAMIC_ASAN=${ENABLE_DYNAMIC_ASAN}
    -DENABLE_DYNAMIC_USAN=${ENABLE_DYNAMIC_USAN}
    -DENABLE_TIDY=${ENABLE_TIDY}
    -DENABLE_ASTYLE=${ENABLE_ASTYLE}
    -DENABLE_UNITTESTING=${ENABLE_UNITTESTING}
)

ExternalProject_Add(
    bfsdk
    CMAKE_ARGS          ${BFSDK_CMAKE_ARGS}
    PREFIX              ${CMAKE_BINARY_DIR}/bfsdk/prefix
    TMP_DIR             ${CMAKE_BINARY_DIR}/bfsdk/tmp
    STAMP_DIR           ${CMAKE_BINARY_DIR}/bfsdk/stamp
    DOWNLOAD_DIR        ${CMAKE_BINARY_DIR}/bfsdk/download
    SOURCE_DIR          ${CMAKE_SOURCE_DIR}/bfsdk
    BINARY_DIR          ${CMAKE_BINARY_DIR}/bfsdk/build
    UPDATE_DISCONNECTED 0
    UPDATE_COMMAND      ""
    BUILD_COMMAND       ""
)

if(ENABLE_UNITTESTING)

    if(WIN32)

        file(TO_NATIVE_PATH ${BF_BUILD_INSTALL_DIR} WINDOWS_INSTALL_PREFIX)
        file(TO_NATIVE_PATH ${BAREFLANK_INSTALL_TEST_PREFIX} WINDOWS_INSTALL_TEST_PREFIX)

        ExternalProject_Add_Step(
            bfsdk
            test_prefix_install
            COMMAND ${CMAKE_COMMAND} -E make_directory ${BAREFLANK_INSTALL_TEST_PREFIX}
            COMMAND mklink /d ${WINDOWS_INSTALL_TEST_PREFIX}\\bin ${WINDOWS_INSTALL_PREFIX}\\bin
            COMMAND mklink /d ${WINDOWS_INSTALL_TEST_PREFIX}\\cmake ${WINDOWS_INSTALL_PREFIX}\\cmake
            COMMAND mklink /d ${WINDOWS_INSTALL_TEST_PREFIX}\\include ${WINDOWS_INSTALL_PREFIX}\\include
            COMMAND mklink /d ${WINDOWS_INSTALL_TEST_PREFIX}\\sdk_lib ${WINDOWS_INSTALL_PREFIX}\\lib
            DEPENDEES install
        )

    else()

        ExternalProject_Add_Step(
            bfsdk
            test_prefix_install
            COMMAND ${CMAKE_COMMAND} -E make_directory ${BAREFLANK_INSTALL_TEST_PREFIX}
            COMMAND ${CMAKE_COMMAND} -E create_symlink ${BF_BUILD_INSTALL_DIR}/bin ${BAREFLANK_INSTALL_TEST_PREFIX}/bin
            COMMAND ${CMAKE_COMMAND} -E create_symlink ${BF_BUILD_INSTALL_DIR}/cmake ${BAREFLANK_INSTALL_TEST_PREFIX}/cmake
            COMMAND ${CMAKE_COMMAND} -E create_symlink ${BF_BUILD_INSTALL_DIR}/include ${BAREFLANK_INSTALL_TEST_PREFIX}/include
            COMMAND ${CMAKE_COMMAND} -E create_symlink ${BF_BUILD_INSTALL_DIR}/lib ${BAREFLANK_INSTALL_TEST_PREFIX}/sdk_lib
            DEPENDEES install
        )

    endif()

endif()
