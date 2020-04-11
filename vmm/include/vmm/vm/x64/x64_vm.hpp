#ifndef VMM_X64_VM_HPP
#define VMM_X64_VM_HPP

#include <vmm/vm/vm.hpp>
#include <vmm/vm/x64/x64_vcpu_op.hpp>

namespace vmm
{

class x64_vm :
    public vm,
    public vcpu_op
{ };

}

#endif
