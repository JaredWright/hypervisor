
list(APPEND BINUTILS_ARGS
    # --prefix=${CMAKE_BINARY_DIR}/external/binutils/prefix
    --target=${BAREFLANK_TARGET}
    --disable-nls
    --disable-werror
    --with-sysroot
    )

ExternalProject_Add(
    binutils
    URL                 http://ftp.gnu.org/gnu/binutils/binutils-2.28.tar.gz
    URL_MD5             d5d270fd0b698ed59ca5ade8e1b5059c
    # PREFIX              ${CMAKE_BINARY_DIR}/external/binutils/prefix
    # TMP_DIR             ${CMAKE_BINARY_DIR}/external/binutils/tmp
    # STAMP_DIR           ${CMAKE_BINARY_DIR}/external/binutils/stamp
    # DOWNLOAD_DIR        ${CMAKE_BINARY_DIR}/external/binutils/download
    # SOURCE_DIR          ${CMAKE_BINARY_DIR}/external/binutils/src
    # BINARY_DIR          ${CMAKE_BINARY_DIR}/external/binutils/build
    CONFIGURE_COMMAND   ${CMAKE_BINARY_DIR}/external/binutils/src/configure ${BINUTILS_ARGS}
    UPDATE_DISCONNECTED 0
    UPDATE_COMMAND      ""
    BUILD_COMMAND       make
    INSTALL_COMMAND     make install
    # LOG_DOWNLOAD        1
    # LOG_CONFIGURE       1
    # LOG_BUILD           1
    # LOG_INSTALL         1
    )

# ExternalProject_Add_Step(
#     binutils
#     prefix_install
#     COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_BINARY_DIR}/external/binutils/prefix/bin/ ${BF_BUILD_INSTALL_DIR}/bin/
#     DEPENDEES install
#     )
