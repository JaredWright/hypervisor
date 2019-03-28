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

#ifndef BFVMM_SDK_CPUID_INTEL_X64_H
#define BFVMM_SDK_CPUID_INTEL_X64_H

namespace bfvmm::intel_x64::cpuid
{

using leaf_t = ::bfvmm::intel_x64::cpuid_handler::leaf_t;

void add_handler(vcpu *vcpu, leaf_t leaf, handler_delegate_t handler);

void add_emulator(vcpu *vcpu, leaf_t leaf, handler_delegate_t handler);

void execute(vcpu *vcpu);

void emulate(vcpu *vcpu, uint64_t rax, uint64_t rbx, uint64_t rcx, uint64_t rdx);

leaf_t get_leaf(vcpu *vcpu);

leaf_t get_subleaf(vcpu *vcpu);

}

#endif
