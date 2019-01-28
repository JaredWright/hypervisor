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

#ifndef DOMAIN_INTEL_X64_BFVMM_H
#define DOMAIN_INTEL_X64_BFVMM_H


#include "../../../domain/domain.h"

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
// Definitions
// -----------------------------------------------------------------------------

namespace bfvmm::intel_x64
{

/// Intel Domain
///
/// Base implementation for an Intel based domain
///
class EXPORT_HVE domain : public bfvmm::domain
{
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
    ~domain() = default;

public:

    /// @cond

    domain(domain &&) = default;
    domain &operator=(domain &&) = default;

    domain(const domain &) = delete;
    domain &operator=(const domain &) = delete;

    /// @endcond
};

}

/// Get Domain
///
/// Gets a domain from the domain manager given a domain id
///
/// @expects
/// @ensures
///
/// @return returns a pointer to the domain being queried or throws
///     and exception.
///
#define get_domain(a) \
    g_dm->get<bfvmm::intel_x64::domain *>(a, "invalid domainid: " __FILE__)

#define domain_cast(a) domain_t(static_cast<bfvmm::intel_x64::domain *>(a.get()))

#endif
