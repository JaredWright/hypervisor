#ifndef VMM_VCPU_X64_EXCEPTION_HPP
#define VMM_VCPU_X64_EXCEPTION_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class exception
{
public:

    // TODO: Define My Interface!

    virtual ~exception() noexcept = default;
protected:
    exception() noexcept = default;
    exception(exception &&) noexcept = default;
    exception &operator=(exception &&) noexcept = default;
    exception(exception const &) = delete;
    exception &operator=(exception const &) & = delete;
};

}

#endif
