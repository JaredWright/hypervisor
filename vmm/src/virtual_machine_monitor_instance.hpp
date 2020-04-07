#ifndef VMM_VIRTUAL_MACHINE_MONITOR_INSTANCE_HPP
#define VMM_VIRTUAL_MACHINE_MONITOR_INSTANCE_HPP

namespace vmm
{

template<
    class virtual_machine_type,
    class vcpu_type
>
class virtual_machine_monitor_instance
{
public:

    virtual_machine_monitor_instance() noexcept 
    { }

    virtual_machine_type &
    make_virtual_machine(uint32_t vcpu_count) noexcept
    {
        // TODO: Allocate a new VM from a pool of uninitialized VMs
        return m_vm_pool[0];
    }

    vcpu_type &
    make_root_vcpu() noexcept
    {
        // TODO: Allocate a new VM from a pool of uninitialized VMs
        return m_vcpu_pool[0];
    }
private:
    virtual_machine_type m_vm_pool[1024]{};
    vcpu_type m_vcpu_pool[1024]{};
};

}

#endif


