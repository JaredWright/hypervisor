ExternalProject_Add(
	llvm
	GIT_REPOSITORY      https://github.com/Bareflank/llvm.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
    CONFIGURE_COMMAND   ""
    BUILD_COMMAND       ""
    INSTALL_COMMAND     ""
)
