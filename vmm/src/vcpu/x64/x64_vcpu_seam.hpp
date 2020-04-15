#ifndef VMM_X64_VCPU_SEAM_HPP
#define VMM_X64_VCPU_SEAM_HPP

#include <vmm/vcpu/x64/x64_vcpu.hpp>

namespace vmm
{

template<
    // Generic vcpu interfaces:
    class execute_type,
    class instruction_pointer_type,
    class nested_paging_type,
    class property_type,
    class virtual_register_type,
    // x64 vcpu interfaces:
    class cpuid_type,
    class cr0_type,
    class cr3_type,
    class cr4_type,
    class exception_type,
    class external_interrupt_type,
    class general_register_x64_type,
    class init_signal_type,
    class interrupt_window_type,
    class io_port_type,
    class microcode_update_type,
    class monitor_trap_type,
    class nmi_type,
    class nmi_window_type,
    class preemption_timer_type,
    class rdmsr_type,
    class sipi_signal_type,
    class vmexit_type,
    class vpid_type,
    class wrmsr_type,
    class xcr0_type
>
class x64_vcpu_seam :
    public x64_vcpu
{
public:

    // --------------------------- execute seam -------------------------------
    bsl::errc_type load() noexcept final
    { return m_execute.load(); }

    bsl::errc_type unload() noexcept final
    { return m_execute.unload(); }

    bsl::errc_type run() noexcept final
    { return m_execute.run(); }

    // ---------------------- instruction pointer seam -------------------------
    bsl::errc_type instruction_pointer_advance() noexcept final
    { return m_instruction_pointer.instruction_pointer_advance(); }

    // --------------------------- property seam -------------------------------
    property::id_type id() noexcept final
    { return m_property.id(); }

    bool is_bootstrap_vcpu() noexcept final
    { return m_property.is_bootstrap_vcpu(); }

    bool is_root_vcpu() noexcept final
    { return m_property.is_root_vcpu(); }

    // ----------------------------- cpuid seam --------------------------------
    void cpuid_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept final
    { return m_cpuid.cpuid_vmexit_handler_set(func); }

    void cpuid_execute() noexcept final
    { return m_cpuid.cpuid_execute(); }

    void cpuid_emulate(uint64_t cpuid_value) noexcept final
    { return m_cpuid.cpuid_emulate(cpuid_value); }

    // ------------------------------ cr0 seam ---------------------------------
    void write_cr0_vmexit_enable() noexcept final
    { return m_cr0.write_cr0_vmexit_enable(); }

    void write_cr0_vmexit_disable() noexcept final
    { return m_cr0.write_cr0_vmexit_disable(); }

    void write_cr0_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept final
    { return m_cr0.write_cr0_vmexit_handler_set(func); }

    uint64_t write_cr0_vmexit_value() noexcept final
    { return m_cr0.write_cr0_vmexit_value(); }

    void write_cr0_execute() noexcept final
    { return m_cr0.write_cr0_execute(); }

    void write_cr0_emulate(uint64_t cr0_value) noexcept final
    { return m_cr0.write_cr0_emulate(cr0_value); }

    // ------------------------------ cr3 seam ---------------------------------
    void read_cr3_vmexit_enable() noexcept final
    { return m_cr3.read_cr3_vmexit_enable(); }

    void read_cr3_vmexit_disable() noexcept final
    { return m_cr3.read_cr3_vmexit_disable(); }

    void read_cr3_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept final
    { return m_cr3.read_cr3_vmexit_handler_set(func); }

    void read_cr3_execute() noexcept final
    { return m_cr3.read_cr3_execute(); }

    void read_cr3_emulate(uint64_t cr3_value) noexcept final
    { return m_cr3.read_cr3_emulate(cr3_value); }

    void write_cr3_vmexit_enable() noexcept final
    { return m_cr3.write_cr3_vmexit_enable(); }

    void write_cr3_vmexit_disable() noexcept final
    { return m_cr3.write_cr3_vmexit_disable(); }

    void write_cr3_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept final
    { return m_cr3.write_cr3_vmexit_handler_set(func); }

    uint64_t write_cr3_vmexit_value() noexcept final
    { return m_cr3.write_cr3_vmexit_value(); }

    void write_cr3_execute() noexcept final
    { return m_cr3.write_cr3_execute(); }

    void write_cr3_emulate(uint64_t cr3_value) noexcept final
    { return m_cr3.write_cr3_emulate(cr3_value); }

    // ------------------------------ cr4 seam ---------------------------------
    void write_cr4_vmexit_enable() noexcept final
    { return m_cr4.write_cr4_vmexit_enable(); }

    void write_cr4_vmexit_disable() noexcept final
    { return m_cr4.write_cr4_vmexit_disable(); }

    void write_cr4_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept final
    { return m_cr4.write_cr4_vmexit_handler_set(func); }

    uint64_t write_cr4_vmexit_value() noexcept final
    { return m_cr4.write_cr4_vmexit_value(); }

    void write_cr4_execute() noexcept final
    { return m_cr4.write_cr4_execute(); }

    void write_cr4_emulate(uint64_t cr4_value) noexcept final
    { return m_cr4.write_cr4_emulate(cr4_value); }

    // ---------------------- external interrupt seam --------------------------
    void external_interrupt_vmexit_enable() noexcept final
    { return m_external_interrupt.external_interrupt_vmexit_enable(); }

    void external_interrupt_vmexit_disable() noexcept final
    { return m_external_interrupt.external_interrupt_vmexit_disable(); }

    void external_interrupt_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept final
    { return m_external_interrupt.external_interrupt_vmexit_handler_set(func); }

    void external_interrupt_inject(uint64_t vector) noexcept final
    { return m_external_interrupt.external_interrupt_inject(vector); }

    // ---------------------- interrupt window seam ----------------------------
    void interrupt_window_vmexit_enable() noexcept final
    { return m_interrupt_window.interrupt_window_vmexit_enable(); }

    void interrupt_window_vmexit_disable() noexcept final
    { return m_interrupt_window.interrupt_window_vmexit_disable(); }

    void interrupt_window_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept final
    { return m_interrupt_window.interrupt_window_vmexit_handler_set(func); }

    // --------------------------- io port seam --------------------------------
    void io_port_vmexit_enable(uint16_t port_number) noexcept final
    { return m_io_port.io_port_vmexit_enable(port_number); }

    void io_port_vmexit_range_enable(uint16_t begin, uint16_t end) noexcept final
    { return m_io_port.io_port_vmexit_range_enable(begin, end); }

    void io_port_vmexit_disable(uint16_t port_number) noexcept final
    { return m_io_port.io_port_vmexit_disable(port_number); }

    void io_port_vmexit_range_disable(uint16_t begin, uint16_t end) noexcept final
    { return m_io_port.io_port_vmexit_range_disable(begin, end); }

    void io_port_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept final
    { return m_io_port.io_port_vmexit_handler_set(func); }

    uint64_t io_port_vmexit_size() noexcept final
    { return m_io_port.io_port_vmexit_size(); }

    bool io_port_vmexit_is_read() noexcept final
    { return m_io_port.io_port_vmexit_is_read(); }

    bool io_port_vmexit_is_write() noexcept final
    { return m_io_port.io_port_vmexit_is_write(); }

    uint16_t io_port_vmexit_port_number() noexcept final
    { return m_io_port.io_port_vmexit_port_number(); }

    uint64_t io_port_vmexit_value() noexcept final
    { return m_io_port.io_port_vmexit_value(); }

    void write_io_port_execute() noexcept final
    { return m_io_port.write_io_port_execute(); }

    void write_io_port_emulate(uint64_t value) noexcept final
    { return m_io_port.write_io_port_emulate(value); }

    void read_io_port_execute() noexcept final
    { return m_io_port.read_io_port_execute(); }

    void read_io_port_emulate(uint64_t value) noexcept final
    { return m_io_port.read_io_port_emulate(value); }

    // ------------------------ monitor trap seam ------------------------------
    void monitor_trap_vmexit_enable() noexcept final
    { return m_monitor_trap.monitor_trap_vmexit_enable(); }

    void monitor_trap_vmexit_disable() noexcept final
    { return m_monitor_trap.monitor_trap_vmexit_disable(); }

    void monitor_trap_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept final
    { return m_monitor_trap.monitor_trap_vmexit_handler_set(func); }

    // ----------------------------- nmi seam ----------------------------------
    void nmi_vmexit_enable() noexcept final
    { return m_nmi.nmi_vmexit_enable(); }

    void nmi_vmexit_disable() noexcept final
    { return m_nmi.nmi_vmexit_disable(); }

    void nmi_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept final
    { return m_nmi.nmi_vmexit_handler_set(func); }

    void nmi_inject() noexcept final
    { return m_nmi.nmi_inject(); }

    // -------------------------- nmi window seam ------------------------------
    void nmi_window_vmexit_enable() noexcept final
    { return m_nmi_window.nmi_window_vmexit_enable(); }

    void nmi_window_vmexit_disable() noexcept final
    { return m_nmi_window.nmi_window_vmexit_disable(); }

    void nmi_window_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept final
    { return m_nmi_window.nmi_window_vmexit_handler_set(func); }

    // ----------------------------- rdmsr seam --------------------------------
    void rdmsr_vmexit_enable() noexcept final
    { return m_rdmsr.rdmsr_vmexit_enable(); }

    // ----------------------------- vmexit seam -------------------------------
    uint32_t vmexit_reason() noexcept final
    { return m_vmexit.vmexit_reason(); }

    uint32_t vmexit_qualification() noexcept final
    { return m_vmexit.vmexit_qualification(); }

    void vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept final
    { return m_vmexit.vmexit_handler_set(func); }

    void post_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept final
    { return m_vmexit.post_vmexit_handler_set(func); }

    // ------------------------------ vpid seam --------------------------------
    void vpid_enable() noexcept final
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
    external_interrupt_type m_external_interrupt{};
    general_register_x64_type m_general_register_x64{};
    init_signal_type m_init_signal{};
    interrupt_window_type m_interrupt_window{};
    io_port_type m_io_port{};
    microcode_update_type m_microcode_update{};
    monitor_trap_type m_monitor_trap{};
    nmi_type m_nmi{};
    nmi_window_type m_nmi_window{};
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
