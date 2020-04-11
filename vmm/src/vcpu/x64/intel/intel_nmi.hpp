#ifndef VMM_VCPU_X64_INTEL_NMI_HPP
#define VMM_VCPU_X64_INTEL_NMI_HPP

#include <vmm/vcpu/x64/nmi.hpp>

namespace vmm
{

class intel_nmi :
    public nmi
{
public:

    intel_nmi() noexcept = default;

    // TODO: Implement Me!
};

}

#endif
