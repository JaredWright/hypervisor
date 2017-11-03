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

list(APPEND BFFLAGS_VMM 
    "-fpic"
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

list(APPEND BFFLAGS_VMM_C
    "-std=c11"
)

list(APPEND BFFLAGS_VMM_CXX
    "-x c++"
    "-std=c++1z"
    "-DNOSTDINC_CXX"
)

list(APPEND BFFLAGS_VMM_X86_64
    "-msse"
    "-msse2"
    "-msse3"
)

list(APPEND BFFLAGS_VMM_AARCH64
    ""
)

