set(GSL_INTERM_INSTALL_DIR ${BF_BUILD_DEPENDS_DIR}/src/gsl-install)

list(APPEND GSL_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${GSL_INTERM_INSTALL_DIR}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_GSL}
)

ExternalProject_Add(
    gsl
    GIT_REPOSITORY      https://github.com/Bareflank/GSL.git
    GIT_TAG             v1.2
    GIT_SHALLOW         1
    CMAKE_ARGS          ${GSL_CMAKE_ARGS}
)

ExternalProject_Add_Step(
    gsl
    sysroot_install
    COMMAND 			${CMAKE_COMMAND} -E copy_directory ${GSL_INTERM_INSTALL_DIR}/include ${BUILD_SYSROOT_OS}/include
    COMMAND 			${CMAKE_COMMAND} -E copy_directory ${GSL_INTERM_INSTALL_DIR}/include ${BUILD_SYSROOT_VMM}/include
    DEPENDEES          	install
)
