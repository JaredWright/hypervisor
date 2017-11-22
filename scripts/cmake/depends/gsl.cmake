set(GSL_INTERM_INSTALL_DIR ${BF_BUILD_DEPENDS_DIR}/src/gsl-install)

list(APPEND GSL_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${GSL_INTERM_INSTALL_DIR}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_GSL}
    -DCMAKE_INSTALL_MESSAGE=LAZY
)

ExternalProject_Add(
    gsl
    GIT_REPOSITORY      https://github.com/Bareflank/GSL.git
    GIT_TAG             v1.2
    GIT_SHALLOW         1
    CMAKE_ARGS          ${GSL_CMAKE_ARGS}
)

if(NOT EXISTS ${BUILD_SYSROOT_OS}/include/gsl)
    ExternalProject_Add_Step(
        gsl
        gsl_os_sysroot_install
        COMMAND 			${CMAKE_COMMAND} -E copy_directory ${GSL_INTERM_INSTALL_DIR}/include ${BUILD_SYSROOT_OS}/include
        DEPENDEES install
    )
endif()

if(NOT EXISTS ${BUILD_SYSROOT_VMM}/include/gsl AND ${BUILD_VMM})
    ExternalProject_Add_Step(
        gsl
        gsl_vmm_sysroot_install
        COMMAND 			${CMAKE_COMMAND} -E copy_directory ${GSL_INTERM_INSTALL_DIR}/include ${BUILD_SYSROOT_VMM}/include
        DEPENDEES install
    )
endif()
