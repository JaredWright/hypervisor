list(APPEND JSON_CMAKE_ARGS
    # -DCMAKE_INSTALL_PREFIX=${BF_BUILD_INSTALL_DIR}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_JSON}
)

ExternalProject_Add(
    json
    GIT_REPOSITORY      https://github.com/Bareflank/json.git
    GIT_TAG             v1.2
    GIT_SHALLOW         1
    CMAKE_ARGS          ${JSON_CMAKE_ARGS}
	# PREFIX              ${JSON_DIR}
	# TMP_DIR             ${JSON_DIR}/tmp
	# STAMP_DIR           ${JSON_DIR}/tmp
	# SOURCE_DIR          ${JSON_DIR}/src
	# BINARY_DIR          ${JSON_DIR}/build
	# INSTALL_DIR         ${JSON_DIR}/install
)

# TODO: Install to the appropirate sysroot in the build tree
# ExternalProject_Add_Step(
#     json
#     sysroot_install
#     COMMAND 			${CMAKE_COMMAND} -E copy_directory /path/to/build/artifacts /path/to/appropriate/sysroot
#     DEPENDEES          	install
#     )
