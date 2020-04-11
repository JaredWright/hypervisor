#ifndef VMM_VCPU_X64_INTEL_CPUID_HPP
#define VMM_VCPU_X64_INTEL_CPUID_HPP

#include <vmm/vcpu/x64/cpuid.hpp>

namespace vmm
{

class intel_cpuid :
    public cpuid
{
public:

    intel_cpuid() noexcept = default;

    // TODO: Implement Me!
};

}

#endif
