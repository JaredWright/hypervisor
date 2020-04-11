#ifndef VMM_VCPU_X64_CR0_HPP
#define VMM_VCPU_X64_CR0_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class cr0
{
public:

    // TODO: Define My Interface!

    virtual ~cr0() noexcept = default;
protected:
    cr0() noexcept = default;
    cr0(cr0 &&) noexcept = default;
    cr0 &operator=(cr0 &&) noexcept = default;
    cr0(cr0 const &) = delete;
    cr0 &operator=(cr0 const &) & = delete;
};

}

#endif
