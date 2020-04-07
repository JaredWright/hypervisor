#ifndef VMM_VCPU_EXECUTE_HPP
#define VMM_VCPU_EXECUTE_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class vcpu_execute
{
public:

    virtual bsl::errc_type run() noexcept = 0;
    virtual bsl::errc_type hlt() noexcept = 0;

    virtual ~vcpu_execute() noexcept = default;
protected:
    vcpu_execute() noexcept = default;
    vcpu_execute(vcpu_execute &&) noexcept = default;
    vcpu_execute &operator=(vcpu_execute &&) noexcept = default;
    vcpu_execute(vcpu_execute const &) = delete;
    vcpu_execute &operator=(vcpu_execute const &) & = delete;
};

}

#endif
