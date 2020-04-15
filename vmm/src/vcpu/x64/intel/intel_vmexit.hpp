#ifndef VMM_VCPU_X64_INTEL_VMEXIT_HPP
#define VMM_VCPU_X64_INTEL_VMEXIT_HPP

#include <vmm/vcpu/x64/vmexit.hpp>

namespace vmm
{

class intel_vmexit :
    public vmexit
{
public:

    uint32_t vmexit_reason() noexcept
    {
        // TODO: Implement me!
        return 0;
    }
    
    uint32_t vmexit_qualification() noexcept
    {
        // TODO: Implement me!
        return 0;
    }
    
    void vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func)
    {
        // TODO: Implement me!
    }

    void post_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func)
    {
        // TODO: Implement me!
    }

    intel_vmexit() noexcept = default;
};

}

#endif
