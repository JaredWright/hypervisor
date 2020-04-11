#ifndef VMM_VCPU_X64_CR4_HPP
#define VMM_VCPU_X64_CR4_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class cr4
{
public:

    // TODO: Define My Interface!

    virtual ~cr4() noexcept = default;
protected:
    cr4() noexcept = default;
    cr4(cr4 &&) noexcept = default;
    cr4 &operator=(cr4 &&) noexcept = default;
    cr4(cr4 const &) = delete;
    cr4 &operator=(cr4 const &) & = delete;
};

}

#endif
