#ifndef VMM_VCPU_X64_INTEL_MONITOR_TRAP_HPP
#define VMM_VCPU_X64_INTEL_MONITOR_TRAP_HPP

#include <vmm/vcpu/x64/monitor_trap.hpp>

namespace vmm
{

class intel_monitor_trap :
    public monitor_trap
{
public:

    intel_monitor_trap() noexcept = default;

    // TODO: Implement Me!
};

}

#endif
