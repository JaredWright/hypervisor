#ifndef VMM_VCPU_X64_WRMSR_HPP
#define VMM_VCPU_X64_WRMSR_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class wrmsr
{
public:

    // TODO: Define My Interface!

    virtual ~wrmsr() noexcept = default;
protected:
    wrmsr() noexcept = default;
    wrmsr(wrmsr &&) noexcept = default;
    wrmsr &operator=(wrmsr &&) noexcept = default;
    wrmsr(wrmsr const &) = delete;
    wrmsr &operator=(wrmsr const &) & = delete;
};

}

#endif
