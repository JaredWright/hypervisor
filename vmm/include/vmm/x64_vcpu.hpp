#ifndef VMM_X64_VCPU_HPP
#define VMM_X64_VCPU_HPP

#include <vmm/vcpu/execute.hpp>

namespace vmm
{

class x64_vcpu :
    public vmm::vcpu_execute 
{ };

}

#endif
