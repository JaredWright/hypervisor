#ifndef VMM_X64_VM_HPP
#define VMM_X64_VM_HPP

#include <vmm/vm/vcpu_operations.hpp>

namespace vmm
{

class x64_vm :
    public vcpu_operations 
{ };

bsl::errc_type
init_root_vm(vmm::x64_vm &vm) noexcept;

}

#endif
