list(APPEND BFFLAGS_WARNING_C
    "-Wall"
    "-Wextra"
    "-Wpedantic"
    "-Wshadow"
    "-Wcast-align"
    "-Wconversion"
    "-Wsign-conversion"
)

list(APPEND BFFLAGS_WARNING_CXX 
    ${BFFLAGS_WARNING_C}
    "-Wctor-dtor-privacy"
    "-Wnon-virtual-dtor"
    "-Wold-style-cast"
    "-Woverloaded-virtual"
)
