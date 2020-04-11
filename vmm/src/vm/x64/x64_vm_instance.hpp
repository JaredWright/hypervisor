#ifndef VMM_X64_VM_INSTANCE_HPP
#define VMM_X64_VM_INSTANCE_HPP

#include<vmm/vcpu/x64/x64_vcpu.hpp>
#include <vmm/vm/x64/x64_vm.hpp>

namespace vmm
{

template<
    class vm_id_type,
    class vcpu_op_type
>
class x64_vm_instance :
    public vmm::x64_vm
{
public:

    uint32_t id() noexcept final
    { return m_vm_id_type.id(); }

    void set_vcpu_init_handler(bsl::delegate<bsl::errc_type (x64_vcpu &)> func) noexcept final
    { return m_vcpu_ops.set_vcpu_init_handler(func); }

    void set_vcpu_fini_handler(bsl::delegate<bsl::errc_type (x64_vcpu &)> func) noexcept final
    { return m_vcpu_ops.set_vcpu_fini_handler(func); }


private:
    vm_id_type m_vm_id_type;
    vcpu_op_type m_vcpu_ops;
};

}

#endif
