#ifndef VMM_VCPU_X64_NMI_WINDOW_HPP
#define VMM_VCPU_X64_NMI_WINDOW_HPP

#include <bsl/delegate.hpp>

namespace vmm
{

class nmi_window
{
public:

    /// @brief Enable vmexits for nmi windows that occur during
    ///     execution of a vcpu
    virtual void nmi_window_vmexit_enable() noexcept = 0;

    /// @brief Disable vmexits for nmi windows that occur during
    ///     execution of a vcpu
    virtual void nmi_window_vmexit_disable() noexcept = 0;

    /// @brief Set a vmexit handler that will be called for all vmexits caused
    ///     by an nmi window while a vcpu is executing.
    ///
    /// @param func The delegate function to be called
    virtual void nmi_window_vmexit_handler_set(bsl::delegate<void (x64_vcpu &)> func) noexcept = 0;

    virtual ~nmi_window() noexcept = default;
protected:
    nmi_window() noexcept = default;
    nmi_window(nmi_window &&) noexcept = default;
    nmi_window &operator=(nmi_window &&) noexcept = default;
    nmi_window(nmi_window const &) = delete;
    nmi_window &operator=(nmi_window const &) & = delete;
};

}

#endif

