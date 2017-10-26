# Platform independent symbolic link creation
macro(install_symlink filepath sympath)
    if(WIN32)
        install(CODE "execute_process(COMMAND mklink ${sympath} ${filepath})")
        install(CODE "message(STATUS \"Created symlink: ${sympath} -> ${filepath}\")")
    else()
        install(CODE "execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${filepath} ${sympath})")
        install(CODE "message(STATUS \"Created symlink: ${sympath} -> ${filepath}\")")
    endif()
endmacro(install_symlink)

# Convenience wrapper around cmake's built-in find_program()
# @arg path: Will hold the path to the program given by "name" on success
# @arg name: The program to be searched for.
# If the program given by "name" is not found, cmake exits with an error
macro(check_program_installed path name)
    find_program(${path} ${name})
    if(${path} MATCHES "-NOTFOUND$")
        message(FATAL_ERROR "Unable to find ${name}, or ${name} is not installed")
    endif()
endmacro(check_program_installed)

# Add a project directory to be built with a new toolchain
# @arg path: Path to a directory to be built with cmake
# @arg target: The name of the cmake target to be created for this project
# @arg toolchain: Path to a cmake toolchain file to use for compiling "project"
# @arg depends: A list of other targets this project depends on
macro(add_subproject path target toolchain depends)
    if(NOT EXISTS ${path})
        message(FATAL_ERROR "Unable to find project at path ${path}")
    endif()

    if(NOT EXISTS ${toolchain})
        message(FATAL_ERROR "Unable to find toolchain file ${toolchain}")
    endif()
    list(APPEND _PROJECT_CMAKE_ARGS
        -DCMAKE_TOOLCHAIN_FILE=${toolchain}
    )

    # Copy all non-built-in cmake cache variables to the new project scope
    get_cmake_property(_vars CACHE_VARIABLES)
    foreach (_var ${_vars})
        STRING(REGEX MATCH "^CMAKE" is_cmake_var ${_var})
        if(NOT is_cmake_var)
            list(APPEND _PROJECT_CMAKE_ARGS -D${_var}=${${_var}})
        endif()
    endforeach()

    string(REPLACE " " ";" depends_list ${depends})
    ExternalProject_Add(
        ${target}
        CMAKE_ARGS ${_PROJECT_CMAKE_ARGS}
        SOURCE_DIR ${path}
        PREFIX ${BF_BUILD_DIR}/${target}
        UPDATE_DISCONNECTED 0
        UPDATE_COMMAND ""
        DEPENDS ${depends_list}
    )
endmacro(add_subproject)

