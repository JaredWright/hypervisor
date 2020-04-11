#ifndef VMM_VCPU_X64_VMEXIT_HPP
#define VMM_VCPU_X64_VMEXIT_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class vmexit
{
public:

    // TODO: Define My Interface!

    virtual ~vmexit() noexcept = default;
protected:
    vmexit() noexcept = default;
    vmexit(vmexit &&) noexcept = default;
    vmexit &operator=(vmexit &&) noexcept = default;
    vmexit(vmexit const &) = delete;
    vmexit &operator=(vmexit const &) & = delete;
};

}

#endif
