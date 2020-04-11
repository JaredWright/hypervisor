#ifndef VMM_VCPU_X64_INTEL_WRMSR_HPP
#define VMM_VCPU_X64_INTEL_WRMSR_HPP

#include <vmm/vcpu/x64/wrmsr.hpp>

namespace vmm
{

class intel_wrmsr :
    public wrmsr
{
public:

    intel_wrmsr() noexcept = default;

    // TODO: Implement Me!
};

}

#endif
