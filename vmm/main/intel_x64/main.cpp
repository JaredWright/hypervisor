#include <bsl/exit_code.hpp>

#include <virtual_machine_monitor.hpp>
#include <intel/intel_virtual_machine.hpp>

namespace vmm
{
    static vmm::virtual_machine_monitor<
        vmm::intel_virtual_machine
    > const g_vmm{};
}

/// @brief Implements the vmm's main function
///
/// @return bsl::exit_success on success, bsl::exit_failure on failure
///
extern "C"
bsl::exit_code
main() noexcept
{
    vmm::g_vmm.run();

    return bsl::exit_success;
}
