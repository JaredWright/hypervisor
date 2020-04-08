add_executable(intel_hello_world_vmm)

target_sources(intel_hello_world_vmm PRIVATE
    src/intel_hello_world_vmm.cpp
)

target_link_libraries(intel_hello_world_vmm vmm)

install(TARGETS intel_hello_world_vmm DESTINATION bin)
