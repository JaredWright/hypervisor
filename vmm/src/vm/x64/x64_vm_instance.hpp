#ifndef VMM_X64_VM_INSTANCE_HPP
#define VMM_X64_VM_INSTANCE_HPP

#include<vmm/x64_vcpu.hpp>
#include <vmm/x64_vm.hpp>

namespace vmm
{

template<
    class vm_vcpu_operations_type
>
class x64_vm_instance :
    public vmm::x64_vm
{
public:

    void vcpu_set_init_handler(bsl::delegate<bsl::errc_type (x64_vcpu &)> func) noexcept final
    { return m_vm_vcpu_ops.vcpu_set_init_handler(func); }

private:
    vm_vcpu_operations_type m_vm_vcpu_ops;
};

}

#endif
