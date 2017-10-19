# ------------------------------------------------------------------------------
# Extended APIs
# ------------------------------------------------------------------------------

if(EXTENDED_APIS_PATH)
    set(ENABLE_EXTENDED_APIS ON)
endif()

if(ENABLE_EXTENDED_APIS)

    if(NOT EXTENDED_APIS_PATH)
        set(EXTENDED_APIS_URL "https://github.com/bareflank/extended_apis.git" CACHE STRING "")
        set(EXTENDED_APIS_TAG "master" CACHE STRING "")
        set(EXTENDED_APIS_PATH ${CMAKE_BINARY_DIR}/extended_apis/src CACHE PATH "")
    else()
        if(NOT EXISTS ${EXTENDED_APIS_PATH})
            message(FATAL_ERROR "extended apis path does not exist: ${EXTENDED_APIS_PATH}")
        endif()
    endif()

    message(STATUS "EXTENDED_APIS_PATH: ${EXTENDED_APIS_PATH}")
    if(EXTENDED_APIS_URL OR EXTENDED_APIS_TAG)
        message(STATUS "EXTENDED_APIS_URL: ${EXTENDED_APIS_URL}")
        message(STATUS "EXTENDED_APIS_TAG: ${EXTENDED_APIS_TAG}")
    endif()

    if(NOT WIN32)

        list(APPEND EXTENDED_APIS_CMAKE_ARGS
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
            -DENABLE_UNITTESTING=${ENABLE_UNITTESTING}
            -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
            -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS}
        )

        ExternalProject_Add(
            extended_apis
            GIT_REPOSITORY      ${EXTENDED_APIS_URL}
            GIT_TAG             ${EXTENDED_APIS_TAG}
            GIT_SHALLOW         1
            CMAKE_ARGS          ${EXTENDED_APIS_CMAKE_ARGS}
            PREFIX              ${CMAKE_BINARY_DIR}/extended_apis/prefix
            TMP_DIR             ${CMAKE_BINARY_DIR}/extended_apis/tmp
            STAMP_DIR           ${CMAKE_BINARY_DIR}/extended_apis/stamp
            DOWNLOAD_DIR        ${CMAKE_BINARY_DIR}/extended_apis/download
            SOURCE_DIR          ${EXTENDED_APIS_PATH}
            BINARY_DIR          ${CMAKE_BINARY_DIR}/extended_apis/build
            UPDATE_DISCONNECTED 0
            UPDATE_COMMAND      ""
            BUILD_COMMAND       ""
            DEPENDS             bfvmm
        )

    endif()

    if(ENABLE_UNITTESTING)

        list(APPEND TEST_EXTENDED_APIS_CMAKE_ARGS
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
            -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
            -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS}
        )

        ExternalProject_Add(
            test_extended_apis
            CMAKE_ARGS          ${TEST_EXTENDED_APIS_CMAKE_ARGS}
            PREFIX              ${CMAKE_BINARY_DIR}/test_extended_apis/prefix
            TMP_DIR             ${CMAKE_BINARY_DIR}/test_extended_apis/tmp
            STAMP_DIR           ${CMAKE_BINARY_DIR}/test_extended_apis/stamp
            DOWNLOAD_DIR        ${CMAKE_BINARY_DIR}/test_extended_apis/download
            SOURCE_DIR          ${EXTENDED_APIS_PATH}
            BINARY_DIR          ${CMAKE_BINARY_DIR}/test_extended_apis/build
            UPDATE_DISCONNECTED 0
            UPDATE_COMMAND      ""
            BUILD_COMMAND       ""
            DEPENDS             test_bfvmm
        )

    endif()

endif()
