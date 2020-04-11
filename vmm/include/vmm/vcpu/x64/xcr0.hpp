#ifndef VMM_VCPU_X64_XCR0_HPP
#define VMM_VCPU_X64_XCR0_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class xcr0
{
public:

    // TODO: Define My Interface!

    virtual ~xcr0() noexcept = default;
protected:
    xcr0() noexcept = default;
    xcr0(xcr0 &&) noexcept = default;
    xcr0 &operator=(xcr0 &&) noexcept = default;
    xcr0(xcr0 const &) = delete;
    xcr0 &operator=(xcr0 const &) & = delete;
};

}

#endif
