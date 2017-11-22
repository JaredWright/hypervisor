set(JSON_INTERM_INSTALL_DIR ${BF_BUILD_DEPENDS_DIR}/src/json-install)

list(APPEND JSON_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${JSON_INTERM_INSTALL_DIR}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_JSON}
    -DCMAKE_INSTALL_MESSAGE=LAZY
)

ExternalProject_Add(
    json
    GIT_REPOSITORY      https://github.com/Bareflank/json.git
    GIT_TAG             v1.2
    GIT_SHALLOW         1
    CMAKE_ARGS          ${JSON_CMAKE_ARGS}
) 

if(NOT EXISTS ${BUILD_SYSROOT_OS}/include/nlohmann/json.hpp)
    ExternalProject_Add_Step(
        json
        json_os_sysroot_install
        COMMAND	${CMAKE_COMMAND} -E copy_directory ${JSON_INTERM_INSTALL_DIR}/include ${BUILD_SYSROOT_OS}/include
        DEPENDEES install
    )
endif()

if(NOT EXISTS ${BUILD_SYSROOT_VMM}/include/nlohmann/json.hpp AND ${BUILD_VMM})
    ExternalProject_Add_Step(
        json
        json_vmm_sysroot_install
        COMMAND	${CMAKE_COMMAND} -E copy_directory ${JSON_INTERM_INSTALL_DIR}/include ${BUILD_SYSROOT_VMM}/include
        DEPENDEES install
    )
endif()
