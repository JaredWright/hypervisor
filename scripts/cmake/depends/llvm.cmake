ExternalProject_Add(
	llvm
	GIT_REPOSITORY      https://github.com/Bareflank/llvm.git
	GIT_TAG             v1.2
	GIT_SHALLOW         1
	# PREFIX              ${LLVM_DIR}
	# TMP_DIR             ${LLVM_DIR}/tmp
	# STAMP_DIR           ${LLVM_DIR}/tmp
	# SOURCE_DIR          ${LLVM_DIR}/src
	# CONFIGURE_COMMAND   ""
	# BUILD_COMMAND       ""
	# INSTALL_COMMAND     ""
	)
