list(APPEND LIBCXX_CMAKE_ARGS
	-DLLVM_PATH=${BF_BUILD_DEPENDS_DIR}/llvm/src
	-DLIBCXX_CXX_ABI=libcxxabi
	-DLIBCXX_CXX_ABI_INCLUDE_PATHS=${BF_DEPENDS_BUILD_DIR}/libcxxabi/src/include/
	-DLIBCXX_HAS_PTHREAD_API=ON
	-DLIBCXX_ENABLE_EXPERIMENTAL_LIBRARY=OFF
    # -DCMAKE_INSTALL_PREFIX=${BF_BUILD_INSTALL_DIR}
	-DCMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_LIBCXX}
	-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
	"-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DNOSTDINC_CXX -std=c++11"
	)

# if(BUILD_SHARED_LIBS)
#     list(APPEND LIBCXX_CMAKE_ARGS -DLIBCXX_ENABLE_SHARED=ON -DLIBCXX_ENABLE_STATIC=OFF)
# endif()
#
# if(BUILD_STATIC_LIBS)
#     list(APPEND LIBCXX_CMAKE_ARGS -DLIBCXX_ENABLE_STATIC=ON -DLIBCXX_ENABLE_SHARED=OFF)
# endif()

ExternalProject_Add(
	libcxx
	GIT_REPOSITORY      https://github.com/Bareflank/libcxx.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
	CMAKE_ARGS      	${LIBCXX_CMAKE_ARGS}
	# PREFIX          	${LIBCXX_DIR}
	# TMP_DIR         	${LIBCXX_DIR}/tmp
	# STAMP_DIR       	${LIBCXX_DIR}/tmp
	# SOURCE_DIR      	${LIBCXX_DIR}/src
	# BINARY_DIR      	${LIBCXX_DIR}/build
	# INSTALL_DIR         ${LIBCXX_DIR}/install
	DEPENDS         	bfunwind libcxxabi
	)

# TODO: Install to the appropirate sysroot in the build tree
# ExternalProject_Add_Step(
#     libcxx
#     sysroot_install
#     COMMAND 			${CMAKE_COMMAND} -E copy_directory /path/to/build/artifacts /path/to/appropriate/sysroot
#     DEPENDEES          	install
#     )
