#ifndef VMM_x64_VCPU_OPERATIONS_HPP
#define VMM_x64_VCPU_OPERATIONS_HPP

#include <vmm/vm/x64/x64_vcpu_op.hpp>

namespace vmm
{

class x64_vcpu_op:
    public vcpu_op
{
public:

    x64_vcpu_op() noexcept = default;

    void
    set_vcpu_init_handler(bsl::delegate<bsl::errc_type (x64_vcpu &)> func) noexcept final
    {
        // TODO: Implement Me!
        return;
    }

    void
    set_vcpu_fini_handler(bsl::delegate<bsl::errc_type (x64_vcpu &)> func) noexcept final
    {
        // TODO: Implement Me!
        return;
    }
};

}

#endif
