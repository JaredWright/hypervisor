#ifndef VMM_VM_VIRTUAL_MACHINE_HPP
#define VMM_VM_VIRTUAL_MACHINE_HPP

namespace vmm
{

class virtual_machine
{
public:

    virtual void foo() noexcept = 0;

    virtual ~virtual_machine() noexcept = default;
protected:
    virtual_machine() noexcept = default;
    virtual_machine(virtual_machine &&) noexcept = default;
    virtual_machine &operator=(virtual_machine &&) noexcept = default;
    virtual_machine(virtual_machine const &) = delete;
    virtual_machine &operator=(virtual_machine const &) & = delete;
};

}

#endif
