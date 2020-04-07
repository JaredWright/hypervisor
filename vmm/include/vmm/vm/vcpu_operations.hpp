#ifndef VMM_VM_VCPU_OPERATIONS_HPP
#define VMM_VM_VCPU_OPERATIONS_HPP

#include <bsl/delegate.hpp>
#include <vmm/x64_vcpu.hpp>

namespace vmm
{

class vcpu_operations
{
public:

    virtual void vcpu_set_init_handler(bsl::delegate<bsl::errc_type (x64_vcpu &)> func) noexcept = 0;

    virtual ~vcpu_operations() noexcept = default;
protected:
    vcpu_operations() noexcept = default;
    vcpu_operations(vcpu_operations &&) noexcept = default;
    vcpu_operations &operator=(vcpu_operations &&) noexcept = default;
    vcpu_operations(vcpu_operations const &) = delete;
    vcpu_operations &operator=(vcpu_operations const &) & = delete;
};

}

#endif
