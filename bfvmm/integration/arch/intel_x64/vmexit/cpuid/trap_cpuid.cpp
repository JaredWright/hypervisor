//
// Copyright (C) 2019 Assured Information Security, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#include <vmm.h>

void
global_init()
{
    bfdebug_info(0, "running trap_cpuid integration test");
    bfdebug_lnbr(0);
}

bool
handle_cpuid(vcpu_t *vcpu)
{
    if (cpuid::leaf(vcpu) == 42) {
        vcpu->set_rcx(42);
    }

    return true;
}

void
hlt_delegate(bfobject *obj)
{
    bfignored(obj);

    auto [rax, rbx, rcx, rdx] =
        ::x64::cpuid::get(
            42, 0, 0, 0
        );

    bfignored(rax);
    bfignored(rbx);
    bfignored(rdx);

    if (rcx == 42) {
        bfdebug_pass(0, "test");
    }
}

void
vcpu_init_nonroot(vcpu_t *vcpu)
{
    vcpu->add_hlt_delegate(
        vcpu_delegate_t::create<hlt_delegate>()
    );

    cpuid::add_emulator(
        vcpu, 42, handler_delegate_t::create<handle_cpuid>()
    );
}
