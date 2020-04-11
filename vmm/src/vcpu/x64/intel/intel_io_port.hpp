#ifndef VMM_VCPU_X64_INTEL_IO_PORT_HPP
#define VMM_VCPU_X64_INTEL_IO_PORT_HPP

#include <vmm/vcpu/x64/io_port.hpp>

namespace vmm
{

class intel_io_port :
    public io_port
{
public:

    intel_io_port() noexcept = default;

    // TODO: Implement Me!
};

}

#endif
