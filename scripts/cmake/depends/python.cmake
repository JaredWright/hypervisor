find_program(PYTHON_BIN python)
set(PYTHON_BIN ${PYTHON_BIN} CACHE INTERNAL "")
if(PYTHON_BIN STREQUAL "PYTHON_BIN-NOTFOUND")
    message(FATAL_ERROR "Unable to find python, or python is not installed")
endif()

