#ifndef VMM_X64_VCPU_INSTANCE_HPP
#define VMM_X64_VCPU_INSTANCE_HPP

#include <vmm/vcpu/x64/x64_vcpu.hpp>

namespace vmm
{

template<
    class execute_type,
    class instruction_pointer_type,
    class nested_paging_type,
    class property_type,
    class virtual_register_type,
    class cpuid_type,
    class cr0_type,
    class cr3_type,
    class cr4_type,
    class exception_type,
    class general_register_x64_type,
    class init_signal_type,
    class io_port_type,
    class microcode_update_type,
    class nmi_type,
    class preemption_timer_type,
    class rdmsr_type,
    class sipi_signal_type,
    class vmexit_type,
    class vpid_type,
    class wrmsr_type,
    class xcr0_type
>
class x64_vcpu_instance :
    public x64_vcpu
{
public:

    bsl::errc_type run() noexcept final
    { return m_execute.run(); }

    bsl::errc_type instruction_pointer_advance() noexcept final
    { return m_instruction_pointer.instruction_pointer_advance(); }

    bsl::errc_type hlt() noexcept final
    { return m_execute.hlt(); }

    bsl::errc_type rdmsr_vmexit_enable() noexcept final
    { return m_rdmsr.rdmsr_vmexit_enable(); }

    bsl::errc_type vpid_enable() noexcept final
    { return m_vpid.vpid_enable(); }

private:
    execute_type m_execute{};
    instruction_pointer_type m_instruction_pointer{};
    nested_paging_type m_nested_paging{};
    property_type m_property{};
    virtual_register_type m_virtual_register{};
    cpuid_type m_cpuid{};
    cr0_type m_cr0{};
    cr3_type m_cr3{};
    cr4_type m_cr4{};
    exception_type m_exception{};
    general_register_x64_type m_general_register_x64{};
    init_signal_type m_init_signal{};
    io_port_type m_io_port{};
    microcode_update_type m_microcode_update{};
    nmi_type m_nmi{};
    preemption_timer_type m_preemption_timer{};
    rdmsr_type m_rdmsr{};
    sipi_signal_type m_sipi_signal{};
    vmexit_type m_vmexit{};
    vpid_type m_vpid{};
    wrmsr_type m_wrmsr{};
    xcr0_type m_xcr0{};
};

}

#endif
