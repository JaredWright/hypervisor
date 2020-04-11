#ifndef VMM_VCPU_X64_INTEL_INSTRUCTION_POINTER_HPP
#define VMM_VCPU_X64_INTEL_INSTRUCTION_POINTER_HPP

#include <vmm/vcpu/instruction_pointer.hpp>

namespace vmm
{

class intel_instruction_pointer :
    public instruction_pointer
{
public:

    intel_instruction_pointer() noexcept = default;

    bsl::errc_type
    instruction_pointer_advance() noexcept final
    {
        // TODO: Implement Me!
        return -1;
    }
};

}

#endif
