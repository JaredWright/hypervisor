# ------------------------------------------------------------------------------
# Sysroot
# ------------------------------------------------------------------------------

if(NOT WIN32)

    list(APPEND BFSYSROOT_CMAKE_ARGS
        -DBAREFLANK_SOURCE_DIR=${CMAKE_SOURCE_DIR}
        -DBAREFLANK_BINARY_DIR=${CMAKE_BINARY_DIR}
        -DCMAKE_INSTALL_PREFIX=${BF_BUILD_INSTALL_DIR}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_TOOLCHAIN_FILE=${VMM_TOOLCHAIN_FILE}
        -DENABLE_COVERAGE=${ENABLE_COVERAGE}
        -DENABLE_DYNAMIC_ASAN=${ENABLE_DYNAMIC_ASAN}
        -DENABLE_DYNAMIC_USAN=${ENABLE_DYNAMIC_USAN}
        -DENABLE_TIDY=${ENABLE_TIDY}
        -DENABLE_ASTYLE=${ENABLE_ASTYLE}
        -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
        -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS}
    )

    ExternalProject_Add(
        bfsysroot
        CMAKE_ARGS          ${BFSYSROOT_CMAKE_ARGS}
        # PREFIX              ${BF_BUILD_DEPENDS_DIR}/bfsysroot
        SOURCE_DIR          ${CMAKE_SOURCE_DIR}/bfsysroot
        # BINARY_DIR          ${CMAKE_BINARY_DIR}/bfsysroot/build
        INSTALL_COMMAND     ""
        UPDATE_DISCONNECTED 0
        UPDATE_COMMAND      ""
        # DEPENDS             bfsdk newlib llvm libcxx libcxxabi binutils
        DEPENDS             bfsdk
    )

endif()

if(ENABLE_UNITTESTING)

    list(APPEND TEST_BFSYSROOT_CMAKE_ARGS
        -DBAREFLANK_SOURCE_DIR=${CMAKE_SOURCE_DIR}
        -DBAREFLANK_BINARY_DIR=${CMAKE_BINARY_DIR}
        -DCMAKE_INSTALL_PREFIX=${BAREFLANK_INSTALL_TEST_PREFIX}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DENABLE_COVERAGE=${ENABLE_COVERAGE}
        -DENABLE_DYNAMIC_ASAN=${ENABLE_DYNAMIC_ASAN}
        -DENABLE_DYNAMIC_USAN=${ENABLE_DYNAMIC_USAN}
        -DENABLE_TIDY=${ENABLE_TIDY}
        -DENABLE_ASTYLE=${ENABLE_ASTYLE}
        -DENABLE_UNITTESTING=${ENABLE_UNITTESTING}
        -DBUILD_STATIC_LIBS=ON
    )

    ExternalProject_Add(
        test_bfsysroot
        CMAKE_ARGS          ${TEST_BFSYSROOT_CMAKE_ARGS}
        # PREFIX              ${CMAKE_BINARY_DIR}/test_bfsysroot/prefix
        # TMP_DIR             ${CMAKE_BINARY_DIR}/test_bfsysroot/tmp
        # STAMP_DIR           ${CMAKE_BINARY_DIR}/test_bfsysroot/stamp
        # DOWNLOAD_DIR        ${CMAKE_BINARY_DIR}/test_bfsysroot/download
        SOURCE_DIR          ${CMAKE_SOURCE_DIR}/bfsysroot
        BINARY_DIR          ${CMAKE_BINARY_DIR}/test_bfsysroot/build
        INSTALL_COMMAND     ""
        UPDATE_DISCONNECTED 0
        UPDATE_COMMAND      ""
        DEPENDS             bfsdk
    )

endif()
