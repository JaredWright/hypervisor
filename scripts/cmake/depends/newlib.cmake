set(NEWLIB_DIR ${BF_BUILD_DEPENDS_DIR}/src/newlib)
set(NEWLIB_BUILD_DIR ${BF_BUILD_DEPENDS_DIR}/src/newlib-build)
set(NEWLIB_INTERM_INSTALL_DIR ${BF_BUILD_DEPENDS_DIR}/src/newlib-install)
set(NEWLIB_TARGET "${BUILD_TARGET_ARCH}-vmm-elf")

if(BUILD_TYPE STREQUAL "Release")
    list(APPEND NEWLIB_C_FLAGS
		"-O3"
        "-DNDEBUG"
	)
endif()

generate_flags(
    VMM
    ADD_C_FLAGS ${NEWLIB_C_FLAGS}
    C_FLAGS_OUT NEWLIB_C_FLAGS
    CXX_FLAGS_OUT NEWLIB_CXX_FLAGS
    SILENT
)

list(APPEND NEWLIB_ARGS
	"--disable-libgloss"
	"--disable-multilib"
	"--disable-newlib-supplied-syscalls"
	"--enable-newlib-multithread"
	"--enable-newlib-iconv"
	"--prefix=${NEWLIB_INTERM_INSTALL_DIR}"
	"--target=${NEWLIB_TARGET}"
    "CC_FOR_TARGET=${TOOLCHAIN_NEWLIB_CC}"
    "CXX_FOR_TARGET=${TOOLCHAIN_NEWLIB_CC}"
    "AS_FOR_TARGET=${TOOLCHAIN_NEWLIB_AS}"
    "AR_FOR_TARGET=${TOOLCHAIN_NEWLIB_AR}"
    "RANLIB_FOR_TARGET=${TOOLCHAIN_NEWLIB_RANLIB}"
    "CFLAGS_FOR_TARGET=${NEWLIB_C_FLAGS}"
)

ExternalProject_Add(
	newlib
	GIT_REPOSITORY      https://github.com/Bareflank/newlib.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
	CONFIGURE_COMMAND   ${NEWLIB_DIR}/configure ${NEWLIB_ARGS}
	BUILD_COMMAND       make
	INSTALL_COMMAND		make install
    DEPENDS             bfsdk binutils
)

if(BUILD_VMM_SHARED)
    ExternalProject_Add_Step(
        newlib
        build_shared_lib
        COMMAND cd ${NEWLIB_BUILD_DIR}/${NEWLIB_TARGET}/newlib && ${TOOLCHAIN_NEWLIB_AR} x libc.a
        COMMAND cd ${NEWLIB_BUILD_DIR}/${NEWLIB_TARGET}/newlib && ${TOOLCHAIN_NEWLIB_CC} -shared *.o -o ${NEWLIB_INTERM_INSTALL_DIR}/${NEWLIB_TARGET}/lib/libc.so
        DEPENDEES install
        )
    list(APPEND NEWLIB_INSTALL_DEPENDEES build_shared_lib)
endif()

list(APPEND NEWLIB_INSTALL_DEPENDEES install)
ExternalProject_Add_Step(
    newlib
    sysroot_install
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${NEWLIB_INTERM_INSTALL_DIR}/${NEWLIB_TARGET}/ ${BUILD_SYSROOT_VMM}
    DEPENDEES "${NEWLIB_INSTALL_DEPENDEES}"
)
