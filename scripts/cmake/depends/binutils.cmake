# TODO: This file currently only builds binutils for whatever host architecture
# cmake is currently running on. Update to build against the
# ${BUILD_TARGET_ARCH} build configuration.

set(BINUTILS_INTERM_INSTALL_DIR ${BF_BUILD_DEPENDS_DIR}/src/binutils-install)

list(APPEND BINUTILS_ARGS
    --prefix=${BINUTILS_INTERM_INSTALL_DIR}
    --target=${BUILD_TARGET_ARCH}-vmm-elf
    --disable-nls
    --disable-werror
    --with-sysroot
)

ExternalProject_Add(
    binutils
    URL                 http://ftp.gnu.org/gnu/binutils/binutils-2.28.tar.gz
    URL_MD5             d5d270fd0b698ed59ca5ade8e1b5059c
    CONFIGURE_COMMAND   ${BF_BUILD_DEPENDS_DIR}/src/binutils/configure ${BINUTILS_ARGS}
    UPDATE_DISCONNECTED 0
    UPDATE_COMMAND      ""
    BUILD_COMMAND       make
    INSTALL_COMMAND     make install
)

ExternalProject_Add_Step(
    binutils
    sysroot_install
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${BINUTILS_INTERM_INSTALL_DIR}/bin ${BUILD_SYSROOT_VMM}/bin
    DEPENDEES install
)
