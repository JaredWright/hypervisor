#ifndef VMM_VCPU_X64_VPID_HPP
#define VMM_VCPU_X64_VPID_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class vcpu_vpid
{
public:

    virtual bsl::errc_type vpid_enable() noexcept = 0;

    virtual ~vcpu_vpid() noexcept = default;
protected:
    vcpu_vpid() noexcept = default;
    vcpu_vpid(vcpu_vpid &&) noexcept = default;
    vcpu_vpid &operator=(vcpu_vpid &&) noexcept = default;
    vcpu_vpid(vcpu_vpid const &) = delete;
    vcpu_vpid &operator=(vcpu_vpid const &) & = delete;
};

}

#endif
