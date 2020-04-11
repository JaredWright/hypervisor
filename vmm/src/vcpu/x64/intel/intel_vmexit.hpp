#ifndef VMM_VCPU_X64_INTEL_VMEXIT_HPP
#define VMM_VCPU_X64_INTEL_VMEXIT_HPP

#include <vmm/vcpu/x64/vmexit.hpp>

namespace vmm
{

class intel_vmexit :
    public vmexit
{
public:

    intel_vmexit() noexcept = default;

    // TODO: Implement Me!
};

}

#endif
