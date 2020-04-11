#include <vmm/x64.hpp>

namespace vmm
{

bsl::errc_type
my_extension_vcpu_init(x64_vcpu &vcpu) noexcept
{
    vcpu.run();
    vcpu.hlt();
    vcpu.vpid_enable();
    vcpu.rdmsr_vmexit_enable();
    // etc... all of the x64 vcpu apis will be available on the given vcpu
    return -1;
}

bsl::errc_type
root_vm_init(x64_vm &root_vm) noexcept
{
    root_vm.set_vcpu_init_handler(my_extension_vcpu_init);
    return -1;
}

}
