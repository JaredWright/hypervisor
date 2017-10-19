# ------------------------------------------------------------------------------
# Driver
# ------------------------------------------------------------------------------

list(APPEND BFDRIVER_CMAKE_ARGS
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
    -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
    -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS}
)

ExternalProject_Add(
    bfdriver
    CMAKE_ARGS          ${BFDRIVER_CMAKE_ARGS}
    PREFIX              ${CMAKE_BINARY_DIR}/bfdriver/prefix
    TMP_DIR             ${CMAKE_BINARY_DIR}/bfdriver/tmp
    STAMP_DIR           ${CMAKE_BINARY_DIR}/bfdriver/stamp
    DOWNLOAD_DIR        ${CMAKE_BINARY_DIR}/bfdriver/download
    SOURCE_DIR          ${CMAKE_SOURCE_DIR}/bfdriver
    BINARY_DIR          ${CMAKE_BINARY_DIR}/bfdriver/build
    UPDATE_DISCONNECTED 0
    UPDATE_COMMAND      ""
    INSTALL_COMMAND     ""
    DEPENDS             bfelf_loader
)

if(ENABLE_UNITTESTING AND NOT WIN32)
    add_dependencies(bfdriver bfsysroot)
endif()

