#ifndef VMM_VCPU_X64_NMI_HPP
#define VMM_VCPU_X64_NMI_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class nmi
{
public:

    // TODO: Define My Interface!

    virtual ~nmi() noexcept = default;
protected:
    nmi() noexcept = default;
    nmi(nmi &&) noexcept = default;
    nmi &operator=(nmi &&) noexcept = default;
    nmi(nmi const &) = delete;
    nmi &operator=(nmi const &) & = delete;
};

}

#endif

