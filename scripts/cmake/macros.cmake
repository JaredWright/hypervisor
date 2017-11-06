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
# @arg SOURCE_DIR: Path to a source code directory to be built with cmake
# @arg TARGET: The name of the cmake target to be created for this project
# @arg TOOLCHAIN: Path to a cmake toolchain file to use for compiling "project"
# @arg DEPENDS: A list of other targets this project depends on
# @arg VERBOSE: Display debug messages
function(add_subproject)
    set(options VERBOSE)
    set(oneVal SOURCE_DIR TARGET TOOLCHAIN)
    set(multiVal DEPENDS)
    cmake_parse_arguments(ADD_SUBPROJECT "${options}" "${oneVal}" "${multiVal}" ${ARGN})

    if(NOT EXISTS ${ADD_SUBPROJECT_SOURCE_DIR})
        message(FATAL_ERROR "Unable to find project at path ${ADD_SUBPROJECT_SOURCE_DIR}")
    endif()
    if(NOT EXISTS ${ADD_SUBPROJECT_TOOLCHAIN})
        message(FATAL_ERROR "Unable to find toolchain file ${ADD_SUBPROJECT_TOOLCHAIN}")
    endif()
    list(APPEND _PROJECT_CMAKE_ARGS
        -DCMAKE_TOOLCHAIN_FILE=${ADD_SUBPROJECT_TOOLCHAIN}
    )

    if(${ADD_SUBPROJECT_VERBOSE})
        message(STATUS "Adding subproject: ${ADD_SUBPROJECT_TARGET}")
        message(STATUS "\t${ADD_SUBPROJECT_TARGET} source path: ${ADD_SUBPROJECT_SOURCE_DIR}")
        message(STATUS "\t${ADD_SUBPROJECT_TARGET} toolchain file: ${ADD_SUBPROJECT_TOOLCHAIN}")
        message(STATUS "\t${ADD_SUBPROJECT_TARGET} dependencies: ${ADD_SUBPROJECT_DEPENDS}")
    endif()

    # Copy all non-built-in cmake cache variables to the new project scope
    get_cmake_property(_vars CACHE_VARIABLES)
    foreach (_var ${_vars})
        STRING(REGEX MATCH "^CMAKE" is_cmake_var ${_var})
        if(NOT is_cmake_var)
            list(APPEND _PROJECT_CMAKE_ARGS -D${_var}=${${_var}})
        endif()
    endforeach()

    ExternalProject_Add(
        ${ADD_SUBPROJECT_TARGET}
        CMAKE_ARGS ${_PROJECT_CMAKE_ARGS}
        SOURCE_DIR ${ADD_SUBPROJECT_SOURCE_DIR}
        PREFIX ${BF_BUILD_DIR}/${ADD_SUBPROJECT_TARGET}
        UPDATE_DISCONNECTED 0
        UPDATE_COMMAND ""
        DEPENDS ${ADD_SUBPROJECT_DEPENDS}
    )
endfunction(add_subproject)

# Add a build configuration to the build system
# @arg name: The name of the build configuration variable
# @arg default: The default value for the configuration, if the variable 'name'
#       is not already set
# @arg type: A cmake cache variable type, to be used by cmake-gui/ccmake
#       Accepted values: BOOL, PATH, FILEPATH, STRING
# @arg description: A description of this configuration to be displayed in
#       cmake-gui and ccmake
macro(add_config name default type description)
    if(${name})
        set(${name} ${${name}} CACHE ${type} ${description})
    else()
        set(${name} ${default} CACHE ${type} ${description})
    endif()
endmacro(add_config)
