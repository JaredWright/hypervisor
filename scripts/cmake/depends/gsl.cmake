list(APPEND GSL_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${BF_BUILD_INSTALL_DIR}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_GSL}
)

ExternalProject_Add(
    gsl
    GIT_REPOSITORY      https://github.com/Bareflank/GSL.git
    GIT_TAG             v1.2
    GIT_SHALLOW         1
    CMAKE_ARGS          ${GSL_CMAKE_ARGS}
    # PREFIX              ${BF_BUILD_DEPENDS_DIR}/gsl
	# TMP_DIR             ${GSL_DIR}/tmp
	# STAMP_DIR           ${GSL_DIR}/tmp
	# SOURCE_DIR          ${GSL_DIR}/src
	# BINARY_DIR          ${GSL_DIR}/build
	# INSTALL_DIR         ${GSL_DIR}/install
)

# TODO: Install to the appropirate sysroot in the build tree
# ExternalProject_Add_Step(
#     gsl
#     sysroot_install
#     COMMAND 			${CMAKE_COMMAND} -E copy_directory /path/to/build/artifacts /path/to/appropriate/sysroot
#     DEPENDEES          	install
#     )
