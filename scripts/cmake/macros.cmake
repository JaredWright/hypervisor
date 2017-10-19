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
macro(check_program_installed path name)
    find_program(${path} ${name})
    if(${path} MATCHES "-NOTFOUND$")
        message(FATAL_ERROR "Unable to find ${name}, or ${name} is not installed")
    endif()
endmacro(check_program_installed)

# Add a subdirectory to be built with a new toolchain
macro(cross_compile_project path target toolchain depends)
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

    ExternalProject_Add(
        ${target}
        CMAKE_ARGS      ${_PROJECT_CMAKE_ARGS}
        SOURCE_DIR      ${path}
        UPDATE_DISCONNECTED 0
        UPDATE_COMMAND      ""
        DEPENDS         ${depends}
    )
endmacro(cross_compile_project)
