#ifndef VMM_x64_VCPU_OPERATIONS_HPP
#define VMM_x64_VCPU_OPERATIONS_HPP

#include <vmm/vm/vcpu_operations.hpp>

namespace vmm
{

class x64_vcpu_operations :
    public vcpu_operations
{
public:

    x64_vcpu_operations() noexcept = default;

    void
    vcpu_set_init_handler(bsl::delegate<bsl::errc_type (x64_vcpu &)> func) noexcept final
    {
        // TODO: Implement Me!
        return;
    }
};

}

#endif
