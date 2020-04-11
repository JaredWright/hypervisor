#ifndef VMM_VCPU_X64_MONITOR_TRAP_HPP
#define VMM_VCPU_X64_MONITOR_TRAP_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class monitor_trap
{
public:

    // TODO: Define My Interface!

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

