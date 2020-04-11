#ifndef VMM_VCPU_X64_CPUID_HPP
#define VMM_VCPU_X64_CPUID_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class cpuid
{
public:

    // TODO: Define My Interface!

    virtual ~cpuid() noexcept = default;
protected:
    cpuid() noexcept = default;
    cpuid(cpuid &&) noexcept = default;
    cpuid &operator=(cpuid &&) noexcept = default;
    cpuid(cpuid const &) = delete;
    cpuid &operator=(cpuid const &) & = delete;
};

}

#endif
