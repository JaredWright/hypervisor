list(APPEND HIPPOMOCKS_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${BF_BUILD_INSTALL_DIR}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_HIPPOMOCKS}
)

ExternalProject_Add(
	hippomocks
	GIT_REPOSITORY      https://github.com/Bareflank/hippomocks.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
	CMAKE_ARGS          ${HIPPOMOCKS_CMAKE_ARGS}
    # PREFIX              ${BF_BUILD_DEPENDS_DIR}/hippomocks
	# TMP_DIR             ${HIPPOMOCKS_DIR}/tmp
	# STAMP_DIR           ${HIPPOMOCKS_DIR}/tmp
	# SOURCE_DIR          ${HIPPOMOCKS_DIR}/src
	# BINARY_DIR          ${HIPPOMOCKS_DIR}/build
	# INSTALL_DIR         ${HIPPOMOCKS_DIR}/install
)

# TODO: Install to the appropirate sysroot in the build tree
# ExternalProject_Add_Step(
#     hippomocks
#     sysroot_install
#     COMMAND 			${CMAKE_COMMAND} -E copy_directory /path/to/build/artifacts /path/to/appropriate/sysroot
#     DEPENDEES          	install
#     )
