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

list(APPEND BFFLAGS_USERSPACE 
    "-fpic"
    "-fstack-protector-strong"
    "-Wl,--no-undefined"
    "-fvisibility=hidden"
    "-DGSL_THROW_ON_CONTRACT_VIOLATION"
    "-DNATIVE"
    "-D${OSTYPE}"
    "-D${ABITYPE}"
)

list(APPEND BFFLAGS_USERSPACE_C 
    "-std=c11"
)

list(APPEND BFFLAGS_USERSPACE_CXX 
    "-std=gnu++14"
    "-fvisibility-inlines-hidden"
)

list(APPEND BFFLAGS_USERSPACE_X86_64
    "-msse"
    "-msse2"
    "-msse3"
)

list(APPEND BFFLAGS_USERSPACE_AARCH64
    ""
)
