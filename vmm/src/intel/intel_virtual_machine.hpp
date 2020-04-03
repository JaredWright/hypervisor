#ifndef VMM_INTEL_VIRTUAL_MACHINE_HPP
#define VMM_INTEL_VIRTUAL_MACHINE_HPP

#include <vm/virtual_machine.hpp>

namespace vmm
{

class intel_virtual_machine :
    public vmm::virtual_machine 
{
public:

    void foo() noexcept
    {
        volatile uintptr_t bar{};
        bar++;
    }
};

}

#endif

