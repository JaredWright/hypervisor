#ifndef VMM_VCPU_X64_INTEL_PREEMPTION_TIMER_HPP
#define VMM_VCPU_X64_INTEL_PREEMPTION_TIMER_HPP

#include <vmm/vcpu/x64/preemption_timer.hpp>

namespace vmm
{

class intel_preemption_timer :
    public preemption_timer
{
public:

    intel_preemption_timer() noexcept = default;

    // TODO: Implement Me!
};

}

#endif
