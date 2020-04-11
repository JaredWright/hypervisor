#ifndef VMM_VCPU_X64_INTEL_EXECUTE_HPP
#define VMM_VCPU_X64_INTEL_EXECUTE_HPP

#include <vmm/vcpu/execute.hpp>

namespace vmm
{

class intel_execute :
    public execute
{
public:

    intel_execute() noexcept = default;

    bsl::errc_type
    run() noexcept final
    {
        // TODO: Implement Me!
        return -1;
    }
    
    bsl::errc_type
    hlt() noexcept final
    {
        // TODO: Implement Me!
        return -1;
    }
    
};

}

#endif
