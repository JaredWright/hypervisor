list(APPEND DEFAULT_C_FLAGS_WARNING 
    "-Wall"
    "-Wextra"
    "-Wpedantic"
    "-Wshadow"
    "-Wcast-align"
    "-Wconversion"
    "-Wsign-conversion"
)

list(APPEND DEFAULT_CXX_FLAGS_WARNING 
    "-Wall"
    "-Wextra"
    "-Wpedantic"
    "-Wctor-dtor-privacy"
    "-Wshadow"
    "-Wnon-virtual-dtor"
    "-Wold-style-cast"
    "-Wcast-align"
    "-Woverloaded-virtual"
    "-Wconversion"
    "-Wsign-conversion"
)

string(REPLACE ";" " " DEFAULT_C_FLAGS_WARNING "${DEFAULT_C_FLAGS_WARNING}")
string(REPLACE ";" " " DEFAULT_CXX_FLAGS_WARNING "${DEFAULT_CXX_FLAGS_WARNING}")
