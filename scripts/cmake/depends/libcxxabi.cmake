list(APPEND LIBCXXABI_CMAKE_ARGS
	-DLLVM_PATH=/vagrant/bfbuild_sandbox/build/llvm/src
	-DLLVM_ENABLE_LIBCXX=ON
	-DLIBCXXABI_LIBCXX_PATH=${BF_DEPENDS_BUILD_DIR}/libcxx/src
	-DLIBCXXABI_HAS_PTHREAD_API=ON
    # -DCMAKE_INSTALL_PREFIX=${BF_BUILD_INSTALL_DIR}
	# -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
	-DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_LIBCXXABI}
	-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
	"-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DNOSTDINC_CXX -std=c++11"
	)

# if(BUILD_SHARED_LIBS)
#     list(APPEND LIBCXXABI_CMAKE_ARGS -DLIBCXXABI_ENABLE_SHARED=ON -DLIBCXXABI_ENABLE_STATIC=OFF)
# endif()
#
# if(BUILD_STATIC_LIBS)
#     list(APPEND LIBCXXABI_CMAKE_ARGS -DLIBCXXABI_ENABLE_STATIC=ON -DLIBCXXABI_ENABLE_SHARED=OFF)
# endif()

ExternalProject_Add(
	libcxxabi
	GIT_REPOSITORY      https://github.com/Bareflank/libcxxabi.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
	CMAKE_ARGS      	${LIBCXXABI_CMAKE_ARGS}
	# PREFIX          	${LIBCXXABI_DIR}
	# TMP_DIR         	${LIBCXXABI_DIR}/tmp
	# STAMP_DIR       	${LIBCXXABI_DIR}/tmp
	# SOURCE_DIR      	${LIBCXXABI_DIR}/src
	# BINARY_DIR      	${LIBCXXABI_DIR}/build
	# INSTALL_DIR         ${LIBCXXABI_DIR}/install
	DEPENDS         	bfunwind llvm
	)

# TODO: Install to the appropirate sysroot in the build tree
# ExternalProject_Add_Step(
#     libcxxabi
#     sysroot_install
#     COMMAND 			${CMAKE_COMMAND} -E copy_directory /path/to/build/artifacts /path/to/appropriate/sysroot
#     DEPENDEES          	install
#     )
