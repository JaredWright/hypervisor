set(NEWLIB_DIR ${BF_BUILD_DEPENDS_DIR}/src/newlib)
set(NEWLIB_INTERM_INSTALL_DIR ${BF_BUILD_DEPENDS_DIR}/src/newlib-install)

set(NEWLIB_CFLAGS
	"-DNOSTDINC_C"
)

if(CMAKE_BUILD_TYPE STREQUAL "Release")
	set(NEWLIB_CFLAGS
		"${NEWLILB_CFLAGS} -O3 -DNDEBUG"
	)
endif()

set(NEWLIB_TARGET "${BUILD_TARGET_ARCH}-vmm-elf")

list(APPEND NEWLIB_ARGS
	"--disable-libgloss"
	"--disable-multilib"
	"--disable-newlib-supplied-syscalls"
	"--enable-newlib-multithread"
	"--enable-newlib-iconv"
	"--prefix=${NEWLIB_INTERM_INSTALL_DIR}"
	"--target=${NEWLIB_TARGET}"
    "CC_FOR_TARGET=${TOOLCHAIN_NEWLIB_CC}"
    "AS_FOR_TARGET=${TOOLCHAIN_NEWLIB_AS}"
	"AR_FOR_TARGET=${TOOLCHAIN_NEWLIB_AR}"
    "RANLIB_FOR_TARGET=${TOOLCHAIN_NEWLIB_RANLIB}"
)

ExternalProject_Add(
	newlib
	GIT_REPOSITORY      https://github.com/Bareflank/newlib.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
	CONFIGURE_COMMAND   ${NEWLIB_DIR}/configure "${NEWLIB_ARGS}" CFLAGS_FOR_TARGET=${NEWLIB_CFLAGS}
	BUILD_COMMAND       make
	INSTALL_COMMAND		make install
    DEPENDS             bfsdk binutils
)

ExternalProject_Add_Step(
    newlib
    sysroot_install
    COMMAND 			${CMAKE_COMMAND} -E copy_directory ${NEWLIB_INTERM_INSTALL_DIR}/${NEWLIB_TARGET}/ ${BF_BUILD_INSTALL_DIR}
    DEPENDEES          	install
)

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
