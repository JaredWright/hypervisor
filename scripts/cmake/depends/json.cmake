set(JSON_INTERM_INSTALL_DIR ${BF_BUILD_DEPENDS_DIR}/src/json-install)

list(APPEND JSON_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${JSON_INTERM_INSTALL_DIR}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_JSON}
)

ExternalProject_Add(
    json
    GIT_REPOSITORY      https://github.com/Bareflank/json.git
    GIT_TAG             v1.2
    GIT_SHALLOW         1
    CMAKE_ARGS          ${JSON_CMAKE_ARGS}
    DEPENDS             bfsdk binutils
)

ExternalProject_Add_Step(
    json
    sysroot_install
    COMMAND 			${CMAKE_COMMAND} -E copy_directory ${JSON_INTERM_INSTALL_DIR}/include ${BF_BUILD_INSTALL_DIR}/include
    DEPENDEES          	install
)
