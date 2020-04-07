#include <bsl/exit_code.hpp>

#include <virtual_machine_monitor_instance.hpp>

#include <vmm/x64_vm.hpp>
#include <vm/x64/x64_vm_instance.hpp>
#include <vm/x64/x64_vcpu_operations.hpp>

#include <vmm/x64_vcpu.hpp>
#include <vcpu/x64/x64_vcpu_instance.hpp>
#include <vcpu/x64/intel/intel_execute.hpp>

namespace vmm
{
    typedef x64_vcpu_instance<
        intel_execute
    > vcpu_type;

    typedef x64_vm_instance<
        x64_vcpu_operations
    > vm_type;


    static virtual_machine_monitor_instance<
        vm_type,
        vcpu_type
    > g_vmm{};

    static bsl::exit_code
    do_command(uint32_t cmd, void * context)
    {
        // Create the "root" virtual machine
        auto n_physical_cpus = 4; // <-- Get this in from *context
        x64_vm &root_vm = g_vmm.make_virtual_machine(n_physical_cpus);
        init_root_vm(root_vm);

        return bsl::exit_failure;
    }
}

/// @brief Implements the vmm's main function
///
/// @return bsl::exit_success on success, bsl::exit_failure on failure
///
extern "C"
bsl::exit_code
main(uint32_t cmd, void * context) noexcept
{
    return vmm::do_command(cmd, context);
}
