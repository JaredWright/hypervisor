# libcxx and libcxxabi both depend on each other's source code to build, so the
# download step for both are declared seperately to avoid a circular dependency

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
    DEPENDS bfsdk
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
    DEPENDS bfsdk
)
