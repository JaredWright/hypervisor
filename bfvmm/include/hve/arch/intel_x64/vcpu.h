//
// Bareflank Hypervisor
// Copyright (C) 2018 Assured Information Security, Inc.
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

#ifndef VCPU_INTEL_X64_H
#define VCPU_INTEL_X64_H

#include "vmx.h"
#include "vmcs.h"

#include "delegator/cpuid.h"
#include "delegator/nmi.h"
#include "delegator/cr.h"
#include "delegator/invd.h"
#include "delegator/msr.h"

#include "../../../vcpu/vcpu.h"
#include "../../../memory_manager/arch/x64/cr3.h"

// -----------------------------------------------------------------------------
// Exports
// -----------------------------------------------------------------------------

#include <bfexports.h>

#ifndef STATIC_HVE
#ifdef SHARED_HVE
#define EXPORT_HVE EXPORT_SYM
#else
#define EXPORT_HVE IMPORT_SYM
#endif
#else
#define EXPORT_HVE
#endif

#ifdef _MSC_VER
#pragma warning(push)
#pragma warning(disable : 4251)
#endif

// -----------------------------------------------------------------------------
// Defintion
// -----------------------------------------------------------------------------

namespace bfvmm::intel_x64
{

/// Intel vCPU
///
/// This class provides the base implementation for an Intel based vCPU. For
/// more information on how a vCPU works, please @see bfvmm::vcpu
///
class EXPORT_HVE vcpu : public bfvmm::vcpu
{

using handler_t = bool(gsl::not_null<bfvmm::intel_x64::vcpu *>);
using handler_delegate_t = delegate<handler_t>;

public:

    /// Default Constructor
    ///
    /// @expects none
    /// @ensures none
    ///
    /// @param id the id of the vcpu
    ///
    vcpu(vcpuid::type id);

    /// Destructor
    ///
    /// @expects none
    /// @ensures none
    ///
    ~vcpu() override = default;

    /// Run Delegate
    ///
    /// Provides the base implementation for starting the vCPU. This delegate
    /// does not "resume" a vCPU as the base implementation does not support
    /// guest VMs.
    ///
    /// @expects none
    /// @ensures none
    ///
    /// @param obj ignored
    ///
    void run_delegate(bfobject *obj);

    /// Halt Delegate
    ///
    /// Provides the base implementation for stopping the vCPU.
    ///
    /// @expects none
    /// @ensures none
    ///
    /// @param obj ignored
    ///
    void hlt_delegate(bfobject *obj);

    /// Load vCPU
    ///
    /// Loads the vCPU into hardware.
    ///
    /// @expects none
    /// @ensures none
    ///
    void load();

    /// Promote vCPU
    ///
    /// Promotes the vCPU.
    ///
    /// @expects none
    /// @ensures none
    ///
    void promote();

    /// Advance vCPU
    ///
    /// Advances the vCPU.
    ///
    /// @expects none
    /// @ensures none
    ///
    /// @return always returns true
    ///
    bool advance();

    /// Halt vCPU
    ///
    /// Halts the vCPU.
    ///
    /// @expects none
    /// @ensures none
    ///
    void halt();

    void add_init_handler(const handler_delegate_t &d);

    bool init();

    void add_fini_handler(const handler_delegate_t &d);

    bool fini();

public:

    /// @cond

    uint64_t rax() const;
    void set_rax(uint64_t val);

    uint64_t rbx() const;
    void set_rbx(uint64_t val);

    uint64_t rcx() const;
    void set_rcx(uint64_t val);

    uint64_t rdx() const;
    void set_rdx(uint64_t val);

    uint64_t rbp() const;
    void set_rbp(uint64_t val);

    uint64_t rsi() const;
    void set_rsi(uint64_t val);

    uint64_t rdi() const;
    void set_rdi(uint64_t val);

    uint64_t r08() const;
    void set_r08(uint64_t val);

    uint64_t r09() const;
    void set_r09(uint64_t val);

    uint64_t r10() const;
    void set_r10(uint64_t val);

    uint64_t r11() const;
    void set_r11(uint64_t val);

    uint64_t r12() const;
    void set_r12(uint64_t val);

    uint64_t r13() const;
    void set_r13(uint64_t val);

    uint64_t r14() const;
    void set_r14(uint64_t val);

    uint64_t r15() const;
    void set_r15(uint64_t val);

    uint64_t rip() const;
    void set_rip(uint64_t val);

    uint64_t rsp() const;
    void set_rsp(uint64_t val);

    gsl::not_null<save_state_t *> save_state() const;

    /// @endcond

public:

    /// @cond

    cpuid::delegator * cpuid_delegator() const
    { return m_cpuid_delegator.get(); }

    nmi::delegator * nmi_delegator() const
    { return m_nmi_delegator.get(); }

    cr::delegator * cr_delegator() const
    { return m_cr_delegator.get(); }

    invd::delegator * invd_delegator() const
    { return m_invd_delegator.get(); }

    msr::delegator * msr_delegator() const
    { return m_msr_delegator.get(); }

    /// @endcond

private:

    bool m_launched{false};

    std::unique_ptr<vmcs> m_vmcs;
    std::unique_ptr<vmx> m_vmx;

    std::list<handler_delegate_t> m_init_delegates;
    std::list<handler_delegate_t> m_fini_delegates;
    std::array<handler_delegate_t, 128> m_exit_delegates;
    // std::list<handler_delegate_t> m_all_exit_delegates;

    std::unique_ptr<cpuid::delegator> m_cpuid_delegator;
    std::unique_ptr<nmi::delegator> m_nmi_delegator;
    std::unique_ptr<cr::delegator> m_cr_delegator;
    std::unique_ptr<invd::delegator> m_invd_delegator;
    std::unique_ptr<msr::delegator> m_msr_delegator;


private:

    void vmexit_handler() noexcept;
};

}

/// Get Guest vCPU
///
/// Gets a guest vCPU from the vCPU manager given a vcpuid
///
/// @expects
/// @ensures
///
/// @return returns a pointer to the vCPU being queried or throws
///     and exception.
///
#define get_vcpu(a) \
    g_vcm->get<bfvmm::intel_x64::vcpu *>(a, __FILE__ ": invalid vcpuid")

#ifdef _MSC_VER
#pragma warning(pop)
#endif

#endif
