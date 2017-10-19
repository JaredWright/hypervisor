# ------------------------------------------------------------------------------
# ELF Loader
# ------------------------------------------------------------------------------

list(APPEND BFELF_LOADER_CMAKE_ARGS
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
    bfelf_loader
    CMAKE_ARGS          ${BFELF_LOADER_CMAKE_ARGS}
    PREFIX              ${CMAKE_BINARY_DIR}/bfelf_loader/prefix
    TMP_DIR             ${CMAKE_BINARY_DIR}/bfelf_loader/tmp
    STAMP_DIR           ${CMAKE_BINARY_DIR}/bfelf_loader/stamp
    DOWNLOAD_DIR        ${CMAKE_BINARY_DIR}/bfelf_loader/download
    SOURCE_DIR          ${CMAKE_SOURCE_DIR}/bfelf_loader
    BINARY_DIR          ${CMAKE_BINARY_DIR}/bfelf_loader/build
    UPDATE_DISCONNECTED 0
    UPDATE_COMMAND      ""
    BUILD_COMMAND       ""
    DEPENDS             bfsdk
)

if(ENABLE_UNITTESTING AND NOT WIN32)
    add_dependencies(bfelf_loader bfsysroot)
endif()
