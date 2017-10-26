set(ASTYLE_INTERM_INSTALL_DIR ${BF_BUILD_DEPENDS_DIR}/src/astyle-install)

list(APPEND ASTYLE_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${ASTYLE_INTERM_INSTALL_DIR}
	-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_ASTYLE}
)

ExternalProject_Add(
    astyle
	GIT_REPOSITORY      https://github.com/Bareflank/astyle.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
	CMAKE_ARGS          ${ASTYLE_CMAKE_ARGS}
    DEPENDS             bfsdk binutils
)

# TODO: Install to the appropirate sysroot in the build tree
# ExternalProject_Add_Step(
#     astyle
#     sysroot_install
#     COMMAND 			${CMAKE_COMMAND} -E copy_directory /path/to/build/artifacts /path/to/appropriate/sysroot
#     DEPENDEES          	install
#     )
