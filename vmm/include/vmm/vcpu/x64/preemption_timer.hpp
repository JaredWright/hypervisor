#ifndef VMM_VCPU_X64_PREEMPTION_TIMER_HPP
#define VMM_VCPU_X64_PREEMPTION_TIMER_HPP

#include <bsl/errc_type.hpp>

namespace vmm
{

class preemption_timer
{
public:

    // TODO: Define My Interface!

    virtual ~preemption_timer() noexcept = default;
protected:
    preemption_timer() noexcept = default;
    preemption_timer(preemption_timer &&) noexcept = default;
    preemption_timer &operator=(preemption_timer &&) noexcept = default;
    preemption_timer(preemption_timer const &) = delete;
    preemption_timer &operator=(preemption_timer const &) & = delete;
};

}

#endif
