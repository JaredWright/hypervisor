#ifndef VMM_VCPU_X64_INTEL_CR3_HPP
#define VMM_VCPU_X64_INTEL_CR3_HPP

#include <vmm/vcpu/x64/cr3.hpp>

namespace vmm
{

class intel_cr3 :
    public cr3
{
public:

    void read_cr3_vmexit_enable() noexcept
    {
        return;
    }

    void read_cr3_vmexit_disable() noexcept
    {
        return;
    }

    void read_cr3_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func)
    {
        return;
    }

    void read_cr3_execute() noexcept
    {
        return;
    }

    void read_cr3_emulate(uint64_t cr3_value) noexcept
    {
        return;
    }

    void write_cr3_vmexit_enable() noexcept
    {
        return;
    }

    void write_cr3_vmexit_disable() noexcept
    {
        return;
    }

    void write_cr3_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func)
    {
        return;
    }

    uint64_t write_cr3_vmexit_value() noexcept
    {
        return 0;
    }

    void write_cr3_execute() noexcept
    {
        return;
    }

    void write_cr3_emulate(uint64_t cr3_value) noexcept
    {
        return;
    }

    intel_cr3() noexcept = default;
};

}

#endif
