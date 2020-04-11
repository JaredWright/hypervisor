#ifndef VMM_VCPU_X64_INTEL_CR3_HPP
#define VMM_VCPU_X64_INTEL_CR3_HPP

#include <vmm/vcpu/x64/cr3.hpp>

namespace vmm
{

class intel_cr3 :
    public cr3
{
public:

    intel_cr3() noexcept = default;

    // TODO: Implement Me!
};

}

#endif
