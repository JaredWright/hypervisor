#ifndef HYPERVISOR_H
#define HYPERVISOR_H

#include <bfvmm/vcpu/vcpu_manager.h>
#include <bfvmm/hve/arch/intel_x64/vcpu.h>
#include <bfdebug.h>
#include <bferrorcodes.h>

using namespace intel_x64;
using namespace x64;
using namespace bfvmm::intel_x64;
using namespace bfvmm::x64;

class domain
{
public:
    domain(uint64_t num_vcpus)
    {
        m_vcpus = gsl::make_span<bfvmm::intel_x64::vcpu *>(0, num_vcpus);
        for(uint64_t vcpuid = 0; vcpuid < num_vcpus; vcpuid++) {
            // m_vcpus.at(vcpuid) = g_vcm->get(vcpuid);
            m_vcpus.at(vcpuid) = reinterpret_cast<bfvmm::intel_x64::vcpu *>(g_vcm->get(vcpuid).get());
        }
    }

    gsl::span<bfvmm::intel_x64::vcpu *>
    vcpus()
    { return m_vcpus; }

private:
    gsl::span<bfvmm::intel_x64::vcpu *> m_vcpus;
};


#endif
