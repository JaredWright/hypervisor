#ifndef VMM_VCPU_X64_RDMSR_HPP
#define VMM_VCPU_X64_RDMSR_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class rdmsr
{
public:

    // TODO: Define My Interface!
    virtual bsl::errc_type rdmsr_vmexit_enable() noexcept = 0;

    virtual ~rdmsr() noexcept = default;
protected:
    rdmsr() noexcept = default;
    rdmsr(rdmsr &&) noexcept = default;
    rdmsr &operator=(rdmsr &&) noexcept = default;
    rdmsr(rdmsr const &) = delete;
    rdmsr &operator=(rdmsr const &) & = delete;
};

}

#endif

