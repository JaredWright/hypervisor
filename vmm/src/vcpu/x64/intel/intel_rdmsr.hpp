#ifndef VMM_VCPU_X64_INTEL_RDMSR_HPP
#define VMM_VCPU_X64_INTEL_RDMSR_HPP

#include <vmm/vcpu/x64/rdmsr.hpp>

namespace vmm
{

class intel_rdmsr :
    public rdmsr
{
public:

    intel_rdmsr() noexcept = default;

    bsl::errc_type
    rdmsr_vmexit_enable() noexcept final
    {
        // TODO: Implement Me!
        return -1;
    }
};

}

#endif
