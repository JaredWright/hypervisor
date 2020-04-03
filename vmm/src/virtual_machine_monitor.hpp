#ifndef VMM_VIRTUAL_MACHINE_MONITOR_HPP
#define VMM_VIRTUAL_MACHINE_MONITOR_HPP

#include <vmm_init.hpp>
#include <bsl/cstdint.hpp>
// #include <bsl/print.hpp>
#include <bsl/is_base_of.hpp>
// #include <bsl/result.hpp>

namespace vmm
{

template<
    class virtual_machine_type
>
class virtual_machine_monitor final
{
public:

    static void
    virtual_machine_monitor() noexcept 
    {
        static_assert(bsl::is_base_of<vmm::virtual_machine, virtual_machine_type>::value,
                      "vmm_info_type must conform to vmm::vmm_info interface");

        virtual_machine_type vm{};
    }

    static void
    run() noexcept 
    {
        // Instead of calling directly, this should be triggered by a vmexit so
        // that it runs in vmxroot.
        vmm_init(vm);
    }

    // static bsl::result<vmm::virtual_machine>
    vmm::virtual_machine
    make_virtual_machine() noexcept 
    {
        return virtual_machine_type{};
    }

};

}

#endif


