#ifndef VMM_VCPU_X64_IO_PORT_HPP
#define VMM_VCPU_X64_IO_PORT_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class io_port
{
public:

    // TODO: Define My Interface!

    virtual ~io_port() noexcept = default;
protected:
    io_port() noexcept = default;
    io_port(io_port &&) noexcept = default;
    io_port &operator=(io_port &&) noexcept = default;
    io_port(io_port const &) = delete;
    io_port &operator=(io_port const &) & = delete;
};

}

#endif
