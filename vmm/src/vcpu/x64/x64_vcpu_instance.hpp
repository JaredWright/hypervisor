#ifndef VMM_X64_VCPU_INSTANCE_HPP
#define VMM_X64_VCPU_INSTANCE_HPP

#include <vmm/x64_vcpu.hpp>

namespace vmm
{

template<
    class vcpu_execute_type
>
class x64_vcpu_instance :
    public x64_vcpu
{
public:

    bsl::errc_type run() noexcept final
    { return m_vcpu_execute.run(); }

    bsl::errc_type hlt() noexcept final
    { return m_vcpu_execute.hlt(); }

private:
    vcpu_execute_type m_vcpu_execute{};
};

}

#endif
