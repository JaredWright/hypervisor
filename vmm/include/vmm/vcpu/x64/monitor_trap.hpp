#ifndef VMM_VCPU_X64_MONITOR_TRAP_HPP
#define VMM_VCPU_X64_MONITOR_TRAP_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class monitor_trap
{
public:

    /// @brief Enable vmexits for all instructions that execute on a vcpu
    virtual void monitor_trap_vmexit_enable() noexcept = 0;

    /// @brief Disable vmexits for all instructions that execute on a vcpu
    virtual void monitor_trap_vmexit_disable() noexcept = 0;

    /// @brief Set a vmexit handler that will be called for all monitor trap
    ///     vmexits caused by exectuion of a vcpu
    ///
    /// @param func The delegate function to be called
    virtual void monitor_trap_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept = 0;

    virtual ~monitor_trap() noexcept = default;
protected:
    monitor_trap() noexcept = default;
    monitor_trap(monitor_trap &&) noexcept = default;
    monitor_trap &operator=(monitor_trap &&) noexcept = default;
    monitor_trap(monitor_trap const &) = delete;
    monitor_trap &operator=(monitor_trap const &) & = delete;
};

}

#endif

