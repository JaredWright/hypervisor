set(CATCH_INTERM_INSTALL_DIR ${BF_BUILD_DEPENDS_DIR}/src/catch-install)

list(APPEND CATCH_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${CATCH_INTERM_INSTALL_DIR}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_CATCH}
)

ExternalProject_Add(
	catch
	GIT_REPOSITORY      https://github.com/Bareflank/Catch.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
	CMAKE_ARGS          ${CATCH_CMAKE_ARGS}
)

ExternalProject_Add_Step(
    catch
    sysroot_install
    COMMAND 			${CMAKE_COMMAND} -E copy_directory ${CATCH_INTERM_INSTALL_DIR}/include ${BUILD_SYSROOT_TEST}/include
    DEPENDEES          	install
)
