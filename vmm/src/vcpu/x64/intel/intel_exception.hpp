#ifndef VMM_VCPU_X64_INTEL_EXCEPTION_HPP
#define VMM_VCPU_X64_INTEL_EXCEPTION_HPP

#include <vmm/vcpu/x64/exception.hpp>

namespace vmm
{

class intel_exception :
    public exception
{
public:

    intel_exception() noexcept = default;

    // TODO: Implement Me!
};

}

#endif
