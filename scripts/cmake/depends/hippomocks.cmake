set(HIPPOMOCKS_INTERM_INSTALL_DIR ${BF_BUILD_DEPENDS_DIR}/src/hippomocks-install)

list(APPEND HIPPOMOCKS_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${HIPPOMOCKS_INTERM_INSTALL_DIR}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_HIPPOMOCKS}
)

ExternalProject_Add(
	hippomocks
	GIT_REPOSITORY      https://github.com/Bareflank/hippomocks.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
	CMAKE_ARGS          ${HIPPOMOCKS_CMAKE_ARGS}
)

ExternalProject_Add_Step(
    hippomocks
    sysroot_install
    COMMAND 			${CMAKE_COMMAND} -E copy_directory ${HIPPOMOCKS_INTERM_INSTALL_DIR}/include ${BUILD_SYSROOT_TEST}/include
    DEPENDEES          	install
)
