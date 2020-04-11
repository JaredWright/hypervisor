#ifndef VMM_VCPU_X64_SIPI_SIGNAL_HPP
#define VMM_VCPU_X64_SIPI_SIGNAL_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class sipi_signal
{
public:

    // TODO: Define My Interface!

    virtual ~sipi_signal() noexcept = default;
protected:
    sipi_signal() noexcept = default;
    sipi_signal(sipi_signal &&) noexcept = default;
    sipi_signal &operator=(sipi_signal &&) noexcept = default;
    sipi_signal(sipi_signal const &) = delete;
    sipi_signal &operator=(sipi_signal const &) & = delete;
};

}

#endif
