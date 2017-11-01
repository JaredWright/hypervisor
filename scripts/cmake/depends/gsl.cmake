list(APPEND GSL_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${BUILD_SYSROOT_VMM}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_GSL}
)

ExternalProject_Add(
    gsl
    GIT_REPOSITORY      https://github.com/Bareflank/GSL.git
    GIT_TAG             v1.2
    GIT_SHALLOW         1
    CMAKE_ARGS          ${GSL_CMAKE_ARGS}
    DEPENDS             bfsdk binutils
)
