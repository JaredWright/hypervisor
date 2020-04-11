#ifndef VMM_VCPU_PROPERTY_HPP
#define VMM_VCPU_PROPERTY_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class property
{
public:

    // TODO: Define My Interface!

    virtual ~property() noexcept = default;
protected:
    property() noexcept = default;
    property(property &&) noexcept = default;
    property &operator=(property &&) noexcept = default;
    property(property const &) = delete;
    property &operator=(property const &) & = delete;
};

}

#endif
