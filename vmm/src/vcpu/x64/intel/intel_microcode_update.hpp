#ifndef VMM_VCPU_X64_INTEL_MICROCODE_UPDATE_HPP
#define VMM_VCPU_X64_INTEL_MICROCODE_UPDATE_HPP

#include <vmm/vcpu/x64/microcode_update.hpp>

namespace vmm
{

class intel_microcode_update :
    public microcode_update
{
public:

    intel_microcode_update() noexcept = default;

    // TODO: Implement Me!
};

}

#endif
