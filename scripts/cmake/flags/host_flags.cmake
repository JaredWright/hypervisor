# TODO: Move this to an appropriate place and/or get rid of it
execute_process(COMMAND uname -o OUTPUT_VARIABLE UNAME OUTPUT_STRIP_TRAILING_WHITESPACE)
if(UNAME STREQUAL "Cygwin" OR WIN32)
    set(OSTYPE "WIN64" CACHE INTERNAL "")
    set(ABITYPE "MS64" CACHE INTERNAL "")
    set(WIN64 ON)
else()
    set(OSTYPE "UNIX" CACHE INTERNAL "")
    set(ABITYPE "SYSV" CACHE INTERNAL "")
endif()

list(APPEND COMMON_FLAGS_HOST 
    "-fpic"
    "-msse"
    "-msse2"
    "-msse3"
    "-fstack-protector-strong"
    "-Wl,--no-undefined"
    "-fvisibility=hidden"
    "-DGSL_THROW_ON_CONTRACT_VIOLATION"
    "-DNATIVE"
    "-D${OSTYPE}"
    "-D${ABITYPE}"
)

list(APPEND DEFAULT_C_FLAGS_HOST 
    "-std=c11"
    ${COMMON_FLAGS_HOST}
)

list(APPEND DEFAULT_CXX_FLAGS_HOST 
    "-std=gnu++14"
    "-fvisibility-inlines-hidden"
    ${COMMON_FLAGS_HOST}
)

string(REPLACE ";" " " DEFAULT_C_FLAGS_HOST "${DEFAULT_C_FLAGS_HOST}")
string(REPLACE ";" " " DEFAULT_CXX_FLAGS_HOST "${DEFAULT_CXX_FLAGS_HOST}")
