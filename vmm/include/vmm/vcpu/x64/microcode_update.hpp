#ifndef VMM_VCPU_X64_MICROCODE_UPDATE_HPP
#define VMM_VCPU_X64_MICROCODE_UPDATE_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class microcode_update
{
public:

    // TODO: Define My Interface!

    virtual ~microcode_update() noexcept = default;
protected:
    microcode_update() noexcept = default;
    microcode_update(microcode_update &&) noexcept = default;
    microcode_update &operator=(microcode_update &&) noexcept = default;
    microcode_update(microcode_update const &) = delete;
    microcode_update &operator=(microcode_update const &) & = delete;
};

}

#endif
