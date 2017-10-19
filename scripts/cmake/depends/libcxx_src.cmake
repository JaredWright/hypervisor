ExternalProject_Add(
    libcxxabi_download
    GIT_REPOSITORY      https://github.com/Bareflank/libcxxabi.git
    GIT_TAG             v1.2
    GIT_SHALLOW         1
    TMP_DIR ${BF_BUILD_DEPENDS_DIR}/tmp
    STAMP_DIR ${BF_BUILD_DEPENDS_DIR}/src/libcxxabi-stamp
    DOWNLOAD_DIR ${BF_BUILD_DEPENDS_DIR}/src
    SOURCE_DIR ${BF_BUILD_DEPENDS_DIR}/src/libcxxabi
    BINARY_DIR ${BF_BUILD_DEPENDS_DIR}/src/libcxxabi-build
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
)

ExternalProject_Add(
    libcxx_download
	GIT_REPOSITORY      https://github.com/Bareflank/libcxx.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
    TMP_DIR ${BF_BUILD_DEPENDS_DIR}/tmp
    STAMP_DIR ${BF_BUILD_DEPENDS_DIR}/src/libcxx-stamp
    DOWNLOAD_DIR ${BF_BUILD_DEPENDS_DIR}/src
    SOURCE_DIR ${BF_BUILD_DEPENDS_DIR}/src/libcxx
    BINARY_DIR ${BF_BUILD_DEPENDS_DIR}/src/libcxx-build
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
)

list(APPEND LIBCXXABI_CMAKE_ARGS
	-DLLVM_PATH=${BF_BUILD_DEPENDS_DIR}/src/llvm
	-DLLVM_ENABLE_LIBCXX=ON
    -DLIBCXXABI_LIBCXX_PATH=${BF_BUILD_DEPENDS_DIR}/src/libcxx
	-DLIBCXXABI_HAS_PTHREAD_API=ON
    -DCMAKE_INSTALL_PREFIX=${BF_BUILD_INSTALL_DIR}
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    # -DCMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_LIBCXXABI}
    -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
    # "-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -std=c++11"
    -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
)

ExternalProject_Add(
    libcxxabi
    GIT_REPOSITORY      https://github.com/Bareflank/libcxxabi.git
    GIT_TAG             v1.2
    GIT_SHALLOW         1
    SOURCE_DIR      	${BF_BUILD_DEPENDS_DIR}/src/libcxxabi
	CMAKE_ARGS      	${LIBCXXABI_CMAKE_ARGS}
    UPDATE_DISCONNECTED 0
    UPDATE_COMMAND      ""
    DEPENDS libcxx_download libcxxabi_download llvm bfunwind
)

MESSAGE(STATUS "********** Libcxx sysroot: " ${BF_BUILD_INSTALL_DIR})
MESSAGE(STATUS "********** C flags: " ${CMAKE_C_FLAGS})
MESSAGE(STATUS "********** CXX flags: " ${CMAKE_CXX_FLAGS})
list(APPEND LIBCXX_CMAKE_ARGS
	-DLLVM_PATH=${BF_BUILD_DEPENDS_DIR}/src/llvm
    -DLIBCXX_CXX_ABI=libcxxabi
    -DLIBCXX_CXX_ABI_INCLUDE_PATHS=${BF_BUILD_DEPENDS_DIR}/src/libcxxabi/include/
    -DLIBCXX_SYSROOT=${BF_BUILD_INSTALL_DIR}
	-DLIBCXX_HAS_PTHREAD_API=ON
	-DLIBCXX_ENABLE_EXPERIMENTAL_LIBRARY=OFF
    -DCMAKE_INSTALL_PREFIX=${BF_BUILD_INSTALL_DIR}
	-DCMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_PATH_LIBCXX}
	-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
	"-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DNOSTDINC_CXX -std=c++11"
)

ExternalProject_Add(
    libcxx
	GIT_REPOSITORY      https://github.com/Bareflank/libcxx.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
    UPDATE_DISCONNECTED 0
    UPDATE_COMMAND      ""
    SOURCE_DIR      	${BF_BUILD_DEPENDS_DIR}/src/libcxx
	CMAKE_ARGS      	${LIBCXX_CMAKE_ARGS}
    DEPENDS libcxx_download libcxxabi_download llvm bfunwind
)
