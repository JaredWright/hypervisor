#ifndef VMM_VCPU_X64_INIT_SIGNAL_HPP
#define VMM_VCPU_X64_INIT_SIGNAL_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class init_signal
{
public:

    // TODO: Define My Interface!

    virtual ~init_signal() noexcept = default;
protected:
    init_signal() noexcept = default;
    init_signal(init_signal &&) noexcept = default;
    init_signal &operator=(init_signal &&) noexcept = default;
    init_signal(init_signal const &) = delete;
    init_signal &operator=(init_signal const &) & = delete;
};

}

#endif
