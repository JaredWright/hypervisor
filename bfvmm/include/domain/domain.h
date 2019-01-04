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

#ifndef BFVMM_DOMAIN_H
#define BFVMM_DOMAIN_H

#include <bftypes.h>
#include <bfobject.h>
#include <bfgsl.h>
#include <bfarch.h>
#include <bfvcpuid.h>
#include <list>

// -----------------------------------------------------------------------------
// Exports
// -----------------------------------------------------------------------------

#include <bfexports.h>

#ifndef BFVMM_STATIC_DOMAIN
#ifdef BFVMM_SHARED_DOMAIN
#define BFVMM_EXPORT_DOMAIN EXPORT_SYM
#else
#define BFVMM_EXPORT_DOMAIN IMPORT_SYM
#endif
#else
#define BFVMM_EXPORT_DOMAIN
#endif

// -----------------------------------------------------------------------------
// Definitions
// -----------------------------------------------------------------------------

namespace bfvmm
{

/// Domain
///
class BFVMM_EXPORT_DOMAIN domain : public bfobject
{
public:

    /// domain id type
    ///
    ///
    using domainid_type = uint64_t;

public:

    /// Constructor
    ///
    /// @expects
    /// @ensures
    ///
    /// @param domainid Id for this domain
    ///
    domain(domainid_type domainid);

    /// Destructor
    ///
    /// @expects
    /// @ensures
    ///
    virtual ~domain() = default;

    /// Run
    ///
    /// @expects none
    /// @ensures none
    ///
    /// @param obj object that can be passed around as needed
    ///     by extensions of Bareflank
    ///
    VIRTUAL void run(bfobject *obj = nullptr);

    /// Halt
    ///
    /// @expects none
    /// @ensures none
    ///
    /// @param obj object that can be passed around as needed
    ///     by extensions of Bareflank
    ///
    VIRTUAL void hlt(bfobject *obj = nullptr);

    /// Init vCPU
    ///
    /// @expects none
    /// @ensures none
    ///
    /// @param obj object that can be passed around as needed
    ///     by extensions of Bareflank
    ///
    VIRTUAL void init(bfobject *obj = nullptr);

    /// Fini vCPU
    ///
    /// @expects none
    /// @ensures none
    ///
    /// @param obj object that can be passed around as needed
    ///     by extensions of Bareflank
    ///
    VIRTUAL void fini(bfobject *obj = nullptr);

    /// Get ID
    ///
    /// @expects
    /// @ensures
    ///
    /// @return Returns the domain ID
    ///
    domainid_type id() const noexcept;

    /// Generate Domain ID
    ///
    /// @expects
    /// @ensures
    ///
    /// @return Returns a new, unique domain id
    ///
    static domainid_type generate_domainid()
    {
        static domainid_type s_id = 1;
        return s_id++;
    }

    /// Add vCPU
    ///
    /// Add a vCPU to this domain
    ///
    /// @expects
    /// @ensures
    ///
    /// @param vcpu The vcpu to add to this domain
    void add_vcpu(vcpu_t vcpu)
    {
        m_vcpus.push_back(vcpu);
    }

    /// vcpus
    ///
    /// Return the list of vcpus that belong to this domain
    ///
    /// @expects
    /// @ensures
    ///
    /// @return List of vcpus
    ///
    std::list<vcpu_t>
    vcpus()
    {
        return m_vcpus;
    }

private:

    /// @cond

    domainid_type m_id;
    std::list<vcpu_t> m_vcpus;

    /// @endcond

public:

    /// @cond

    domain(domain &&) = default;
    domain &operator=(domain &&) = default;

    domain(const domain &) = delete;
    domain &operator=(const domain &) = delete;

    /// @endcond
};

// -----------------------------------------------------------------------------
// Constants
// -----------------------------------------------------------------------------

/// @cond

constexpr domain::domainid_type invalid_domainid = 0xFFFFFFFFFFFFFFFF;

/// @endcond

}

#if defined(BF_INTEL_X64)
#include "../hve/arch/intel_x64/domain.h"
#else
#   error "domain.h: unsupported architecture"
#endif

#endif
