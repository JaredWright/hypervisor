set(NEWLIB_DIR ${BF_BUILD_DEPENDS_DIR}/newlib)

set(NEWLIB_CFLAGS
	"-DNOSTDINC_C"
)

if(CMAKE_BUILD_TYPE STREQUAL "Release")
	set(NEWLIB_CFLAGS
		"${NEWLILB_CFLAGS} -O3 -DNDEBUG"
	)
endif()

# Temporary hacks until the build system has a good way to specify
# different toolchains to use for different dependencies
# If you specify 
# if(${CMAKE_C_COMPILER_TARGET} STREQUAL "arm64-none-eabi")
#     set(NEWLIB_CC "aarch64-linux-gnu-gcc")
#     set(NEWLIB_TARGET "aarch64-none-elf")
# else()
#     set(NEWLIB_CC ${CMAKE_C_COMPILER})
#     set(NEWLIB_TARGET "x86_64-none-elf")
# endif()

list(APPEND NEWLIB_ARGS
	"--disable-libgloss"
	"--disable-multilib"
	"--disable-newlib-supplied-syscalls"
	"--enable-newlib-multithread"
	"--enable-newlib-iconv"
	"--prefix=${BF_BUILD_INSTALL_DIR}"
	"--target=${NEWLIB_TARGET}"
	"CC_FOR_TARGET=${NEWLIB_CC}"
	"AS_FOR_TARGET=${CMAKE_ASM_COMPILER}"
	"AR_FOR_TARGET=${CMAKE_AR}"
	"RANLIB_FOR_TARGET=${CMAKE_RANLIB}"
)

ExternalProject_Add(
	newlib
	GIT_REPOSITORY      https://github.com/Bareflank/newlib.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
	# PREFIX              ${NEWLIB_DIR}
	# TMP_DIR             ${NEWLIB_DIR}/tmp
	# STAMP_DIR           ${NEWLIB_DIR}/tmp
	# SOURCE_DIR          ${NEWLIB_DIR}/src
	# BINARY_DIR          ${NEWLIB_DIR}/build
	# INSTALL_DIR         ${NEWLIB_DIR}/install
	CONFIGURE_COMMAND   ${NEWLIB_DIR}/src/configure "${NEWLIB_ARGS}" CFLAGS_FOR_TARGET=${NEWLIB_CFLAGS}
	BUILD_COMMAND       make
	INSTALL_COMMAND		make install
	)

# ExternalProject_Add_Step(
#     newlib
#     sysroot_install
#     COMMAND 			${CMAKE_COMMAND} -E copy_directory ${NEWLIB_DIR}/aarch64-none-elf/ ${BF_DEPENDS_BUILD_DIR}/aarch64-none-eabi/
#     DEPENDEES          	install
#     )

# if(BUILD_SHARED_LIBS)
#     ExternalProject_Add_Step(
#         newlib
#         link
#         COMMAND             ${CMAKE_COMMAND} -E copy ${CMAKE_INSTALL_PREFIX}/sysroots/${BAREFLANK_TARGET}/lib/libc.a libc.a
#         COMMAND             ${CMAKE_AR} x libc.a
#         COMMAND             ${CMAKE_C_COMPILER} -shared *.o -o ${CMAKE_INSTALL_PREFIX}/sysroots/${BAREFLANK_TARGET}/lib/libc.so
#         DEPENDEES           prefix_install
#         )
# endif()
