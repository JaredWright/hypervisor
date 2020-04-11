#ifndef VMM_VCPU_X64_CR3_HPP
#define VMM_VCPU_X64_CR3_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class cr3
{
public:

    // TODO: Define My Interface!

    virtual ~cr3() noexcept = default;
protected:
    cr3() noexcept = default;
    cr3(cr3 &&) noexcept = default;
    cr3 &operator=(cr3 &&) noexcept = default;
    cr3(cr3 const &) = delete;
    cr3 &operator=(cr3 const &) & = delete;
};

}

#endif
