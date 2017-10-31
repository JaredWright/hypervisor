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

list(APPEND COMMON_FLAGS_VMM 
    "-fpic"
    "-msse"
    "-msse2"
    "-msse3"
    "-mno-red-zone"
    "-mstackrealign"
    "-fstack-protector-strong"
    "-DVMM"
    "-D${OSTYPE}"
    "-D${ABITYPE}"
    "-DNOSTDINC_C"
    "-DMALLOC_PROVIDED"
    "-DGSL_THROW_ON_CONTRACT_VIOLATION"
    "-D_HAVE_LONG_DOUBLE"
    "-D_LDBL_EQ_DBL"
    "-D_POSIX_TIMERS"
    "-D_POSIX_PRIORITY_SCHEDULING"
    "-U__STRICT_ANSI__"
    "-DCLOCK_MONOTONIC"
)

list(APPEND DEFAULT_C_FLAGS_VMM 
    "-std=c11"
    ${COMMON_FLAGS_VMM}
)

list(APPEND DEFAULT_CXX_FLAGS_VMM 
    "-x c++"
    "-std=c++1z"
    "-DNOSTDINC_CXX"
    ${COMMON_FLAGS_VMM}
)

string(REPLACE ";" " " DEFAULT_C_FLAGS_VMM "${DEFAULT_C_FLAGS_VMM}")
string(REPLACE ";" " " DEFAULT_CXX_FLAGS_VMM "${DEFAULT_CXX_FLAGS_VMM}")
