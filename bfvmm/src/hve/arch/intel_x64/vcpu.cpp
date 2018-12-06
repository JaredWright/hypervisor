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

#include <hve/arch/intel_x64/vcpu.h>

// -----------------------------------------------------------------------------
// Implementation
// -----------------------------------------------------------------------------

namespace bfvmm::intel_x64
{

vcpu::vcpu(vcpuid::type id) :
    bfvmm::vcpu{id},
    m_vmcs{std::make_unique<bfvmm::intel_x64::vmcs>(this)},
    m_vmx{std::make_unique<intel_x64::vmx>()},
    m_cpuid_delegator{std::make_unique<cpuid::delegator>()},
    m_nmi_delegator{std::make_unique<nmi::delegator>()},
    m_cr_delegator{std::make_unique<cr::delegator>()},
    m_invd_delegator{std::make_unique<invd::delegator>()},
    m_msr_delegator{std::make_unique<msr::delegator>()}
{
    using namespace ::intel_x64::vmcs::exit_reason;

    this->add_run_delegate(
        run_delegate_t::create<intel_x64::vcpu, &intel_x64::vcpu::run_delegate>(this)
    );

    this->add_hlt_delegate(
        hlt_delegate_t::create<intel_x64::vcpu, &intel_x64::vcpu::hlt_delegate>(this)
    );

    auto exit_delegate = handler_delegate_t::create<cpuid::delegator,
         &cpuid::delegator::handle>(m_cpuid_delegator);
    m_exit_delegates.at(basic_exit_reason::cpuid) = exit_delegate;

    exit_delegate = handler_delegate_t::create<nmi::delegator,
         &nmi::delegator::handle_nmi>(m_nmi_delegator);
    m_exit_delegates.at(basic_exit_reason::exception_or_non_maskable_interrupt) = exit_delegate;

    exit_delegate = handler_delegate_t::create<nmi::delegator,
         &nmi::delegator::handle_nmi_window>(m_nmi_delegator);
    m_exit_delegates.at(basic_exit_reason::nmi_window) = exit_delegate;

    exit_delegate = handler_delegate_t::create<invd::delegator,
         &invd::delegator::handle>(m_invd_delegator);
    m_exit_delegates.at(basic_exit_reason::invd) = exit_delegate;

    exit_delegate = handler_delegate_t::create<msr::delegator,
         &msr::delegator::handle_rdmsr>(m_msr_delegator);
    m_exit_delegates.at(basic_exit_reason::rdmsr) = exit_delegate;

    exit_delegate = handler_delegate_t::create<msr::delegator,
         &msr::delegator::handle_wrmsr>(m_msr_delegator);
    m_exit_delegates.at(basic_exit_reason::wrmsr) = exit_delegate;

    exit_delegate = handler_delegate_t::create<cr::delegator,
         &cr::delegator::handle>(m_cr_delegator);
    m_exit_delegates.at(basic_exit_reason::control_register_accesses) = exit_delegate;
}

void
vcpu::run_delegate(bfobject *obj)
{
    bfignored(obj);

    if (m_launched) {
        m_vmcs->resume();
    }
    else {
        if (this->is_host_vm_vcpu()) {
            m_vmx->enable();
        }

        try {
            m_vmcs->init();
            m_vmcs->load();
            m_vmcs->launch();
            m_launched = true;
        }
        catch (...) {
            m_launched = false;
            throw;
        }

        ::x64::cpuid::get(0xBF10, 0, 0, 0);
        ::x64::cpuid::get(0xBF11, 0, 0, 0);
    }
}

void
vcpu::hlt_delegate(bfobject *obj)
{
    bfignored(obj);

    ::x64::cpuid::get(0xBF20, 0, 0, 0);
    ::x64::cpuid::get(0xBF21, 0, 0, 0);
}

bool
vcpu::init()
{
    for (const auto &d : m_init_delegates) {
        if(!d(this)) {
            bferror_info(0, "VCPU init failed");
            return false;
        }
    }

    return true;
}

bool
vcpu::fini()
{
    for (const auto &d : m_fini_delegates) {
        if(!d(this)) {
            bferror_info(0, "VCPU fini failed");
            return false;
        }
    }

    return true;
}

void
vcpu::vmexit_handler() noexcept
{
    using namespace ::intel_x64::vmcs;

    guard_exceptions([&]() {

        // for (const auto &d : m_all_exit_delegates) {
        //     d(this);
        // }

        auto exit_reason = exit_reason::basic_exit_reason::get();
        auto exit_delegate = m_exit_delegates.at(exit_reason);
        if(exit_delegate(this)) {
            this->run();
        }

        bfdebug_transaction(0, [&](std::string * msg) {
            bferror_lnbr(0, msg);
            bferror_info(0, "unhandled exit reason", msg);
            bferror_brk1(0, msg);

            bferror_subtext(
                0, "exit_reason",
                exit_reason::basic_exit_reason::description(), msg
            );
        });

        if (exit_reason::vm_entry_failure::is_enabled()) {
            debug::dump();
            check::all();
        }
    });

    this->halt();
}

void
vcpu::load()
{ m_vmcs->load(); }

void
vcpu::promote()
{ m_vmcs->promote(); }

uint64_t
vcpu::rax() const
{ return m_vmcs->save_state()->rax; }

void
vcpu::set_rax(uint64_t val)
{ m_vmcs->save_state()->rax = val; }

uint64_t
vcpu::rbx() const
{ return m_vmcs->save_state()->rbx; }

void
vcpu::set_rbx(uint64_t val)
{ m_vmcs->save_state()->rbx = val; }

uint64_t
vcpu::rcx() const
{ return m_vmcs->save_state()->rcx; }

void
vcpu::set_rcx(uint64_t val)
{ m_vmcs->save_state()->rcx = val; }

uint64_t
vcpu::rdx() const
{ return m_vmcs->save_state()->rdx; }

void
vcpu::set_rdx(uint64_t val)
{ m_vmcs->save_state()->rdx = val; }

uint64_t
vcpu::rbp() const
{ return m_vmcs->save_state()->rbp; }

void
vcpu::set_rbp(uint64_t val)
{ m_vmcs->save_state()->rbp = val; }

uint64_t
vcpu::rsi() const
{ return m_vmcs->save_state()->rsi; }

void
vcpu::set_rsi(uint64_t val)
{ m_vmcs->save_state()->rsi = val; }

uint64_t
vcpu::rdi() const
{ return m_vmcs->save_state()->rdi; }

void
vcpu::set_rdi(uint64_t val)
{ m_vmcs->save_state()->rdi = val; }

uint64_t
vcpu::r08() const
{ return m_vmcs->save_state()->r08; }

void
vcpu::set_r08(uint64_t val)
{ m_vmcs->save_state()->r08 = val; }

uint64_t
vcpu::r09() const
{ return m_vmcs->save_state()->r09; }

void
vcpu::set_r09(uint64_t val)
{ m_vmcs->save_state()->r09 = val; }

uint64_t
vcpu::r10() const
{ return m_vmcs->save_state()->r10; }

void
vcpu::set_r10(uint64_t val)
{ m_vmcs->save_state()->r10 = val; }

uint64_t
vcpu::r11() const
{ return m_vmcs->save_state()->r11; }

void
vcpu::set_r11(uint64_t val)
{ m_vmcs->save_state()->r11 = val; }

uint64_t
vcpu::r12() const
{ return m_vmcs->save_state()->r12; }

void
vcpu::set_r12(uint64_t val)
{ m_vmcs->save_state()->r12 = val; }

uint64_t
vcpu::r13() const
{ return m_vmcs->save_state()->r13; }

void
vcpu::set_r13(uint64_t val)
{ m_vmcs->save_state()->r13 = val; }

uint64_t
vcpu::r14() const
{ return m_vmcs->save_state()->r14; }

void
vcpu::set_r14(uint64_t val)
{ m_vmcs->save_state()->r14 = val; }

uint64_t
vcpu::r15() const
{ return m_vmcs->save_state()->r15; }

void
vcpu::set_r15(uint64_t val)
{ m_vmcs->save_state()->r15 = val; }

uint64_t
vcpu::rip() const
{ return m_vmcs->save_state()->rip; }

void
vcpu::set_rip(uint64_t val)
{ m_vmcs->save_state()->rip = val; }

uint64_t
vcpu::rsp() const
{ return m_vmcs->save_state()->rsp; }

void
vcpu::set_rsp(uint64_t val)
{ m_vmcs->save_state()->rsp = val; }

gsl::not_null<save_state_t *>
vcpu::save_state() const
{ return m_vmcs->save_state(); }

bool
vcpu::advance()
{
    using namespace ::intel_x64::vmcs;

    this->set_rip(this->rip() + vm_exit_instruction_length::get());
    return true;
}

void
vcpu::halt()
{
    using namespace ::intel_x64::vmcs;

    bferror_lnbr(0);
    bferror_info(0, "halting vcpu");
    bferror_brk1(0);

    bferror_subnhex(0, "rax", this->rax());
    bferror_subnhex(0, "rbx", this->rbx());
    bferror_subnhex(0, "rcx", this->rcx());
    bferror_subnhex(0, "rdx", this->rdx());
    bferror_subnhex(0, "rbp", this->rbp());
    bferror_subnhex(0, "rsi", this->rsi());
    bferror_subnhex(0, "rdi", this->rdi());
    bferror_subnhex(0, "r08", this->r08());
    bferror_subnhex(0, "r09", this->r09());
    bferror_subnhex(0, "r10", this->r10());
    bferror_subnhex(0, "r11", this->r11());
    bferror_subnhex(0, "r12", this->r12());
    bferror_subnhex(0, "r13", this->r13());
    bferror_subnhex(0, "r14", this->r14());
    bferror_subnhex(0, "r15", this->r15());
    bferror_subnhex(0, "rip", this->rip());
    bferror_subnhex(0, "rsp", this->rsp());

    bferror_subnhex(0, "cr0", guest_cr0::get());
    bferror_subnhex(0, "cr2", ::intel_x64::cr2::get());
    bferror_subnhex(0, "cr3", guest_cr3::get());
    bferror_subnhex(0, "cr4", guest_cr4::get());

    bferror_subnhex(0, "linear address", guest_linear_address::get());
    bferror_subnhex(0, "physical address", guest_physical_address::get());

    bferror_subnhex(0, "exit reason", exit_reason::get());
    bferror_subnhex(0, "exit qualification", exit_qualification::get());

    ::x64::pm::stop();
}

}
