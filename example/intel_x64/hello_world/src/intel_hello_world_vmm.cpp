#include <vmm/x64_vm.hpp>
#include <vmm/x64_vcpu.hpp>

namespace vmm
{

bsl::errc_type
init_root_vcpu(x64_vcpu &vcpu) noexcept
{
    vcpu.run();
    vcpu.hlt();
    vcpu.vpid_enable();
    // vcpu.cpuid_vmexit_handler_set(my_cpuid_handler);
    return -1;
}

bsl::errc_type
init_root_vm(x64_vm &root_vm) noexcept
{
    root_vm.vcpu_set_init_handler(init_root_vcpu);
    return -1;
}

}
