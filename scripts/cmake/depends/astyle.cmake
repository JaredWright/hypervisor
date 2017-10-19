list(APPEND ASTYLE_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${BF_BUILD_INSTALL_DIR}
	-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_ASTYLE}
)

ExternalProject_Add(
    astyle
	GIT_REPOSITORY      https://github.com/Bareflank/astyle.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
	CMAKE_ARGS          ${ASTYLE_CMAKE_ARGS}
    # PREFIX              ${BF_BUILD_DEPENDS_DIR}/astyle
	# TMP_DIR             ${ASTYLE_DIR}/tmp
	# STAMP_DIR           ${ASTYLE_DIR}/tmp
	# SOURCE_DIR          ${ASTYLE_DIR}/src
	# BINARY_DIR          ${ASTYLE_DIR}/build
	# INSTALL_DIR         ${ASTYLE_DIR}/install
)

# TODO: Install to the appropirate sysroot in the build tree
# ExternalProject_Add_Step(
#     astyle
#     sysroot_install
#     COMMAND 			${CMAKE_COMMAND} -E copy_directory /path/to/build/artifacts /path/to/appropriate/sysroot
#     DEPENDEES          	install
#     )
