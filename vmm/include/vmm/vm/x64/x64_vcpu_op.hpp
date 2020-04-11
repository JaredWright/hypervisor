#ifndef VMM_VM_VCPU_OPERATIONS_HPP
#define VMM_VM_VCPU_OPERATIONS_HPP

#include <bsl/delegate.hpp>
#include <vmm/vcpu/x64/x64_vcpu.hpp>

namespace vmm
{

class vcpu_op
{
public:

    virtual void set_vcpu_init_handler(bsl::delegate<bsl::errc_type (x64_vcpu &)> func) noexcept = 0;
    virtual void set_vcpu_fini_handler(bsl::delegate<bsl::errc_type (x64_vcpu &)> func) noexcept = 0;

    virtual ~vcpu_op() noexcept = default;
protected:
    vcpu_op() noexcept = default;
    vcpu_op(vcpu_op &&) noexcept = default;
    vcpu_op &operator=(vcpu_op &&) noexcept = default;
    vcpu_op(vcpu_op const &) = delete;
    vcpu_op &operator=(vcpu_op const &) & = delete;
};

}

#endif
