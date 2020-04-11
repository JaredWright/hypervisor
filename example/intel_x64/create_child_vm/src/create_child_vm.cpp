#include <vmm/x64.hpp>

namespace vmm
{

bsl::errc_type
root_vcpu_init(x64_vcpu &vcpu) noexcept
{
    // Initilize the root vm's vcpus here
    return -1;
}

bsl::errc_type
child_vcpu_init(x64_vcpu &vcpu) noexcept
{
    // Initilize the child vm's vcpus here
    return -1;
}

bsl::errc_type
root_vm_init(x64_vm &root_vm) noexcept
{
    uint32_t n_vcpus = 1;
    x64_vm &child_vm = vmm::create_x64_vm(n_vcpus);

    // How to give memory to the vm?
    // TODO

    // How to set the VM's cpu/vcpu affinity, or setup parent vcpus?
    // TODO

    // Set a vcpu init handler for the child vm
    child_vm.set_vcpu_init_handler(child_vcpu_init);

    // Set a different init handler for the root vm's vcpus 
    root_vm.set_vcpu_init_handler(root_vcpu_init);

    return -1;
}

}
