#ifndef VMM_X64_VCPU_HPP
#define VMM_X64_VCPU_HPP

#include <vmm/vcpu/execute.hpp>
#include <vmm/vcpu/x64/vpid.hpp>

namespace vmm
{

class x64_vcpu :
    public vmm::vcpu_execute,
    public vmm::vcpu_vpid
{ };

}

#endif
