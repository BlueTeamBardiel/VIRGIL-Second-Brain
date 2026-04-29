# MSR

## What it is
Like a car's ECU storing hidden tuning parameters that mechanics never see on the dashboard, Model-Specific Registers (MSRs) are special CPU registers that control low-level processor behavior — power management, performance counters, and critically, security features like Secure Boot enforcement and hardware virtualization settings. They are accessible only from Ring 0 (kernel mode) via the `RDMSR`/`WRMSR` x86 instructions.

## Why it matters
Attackers with kernel-level access can write to MSRs to disable CPU security features silently — for example, clearing the IA32_EFER register's NXE bit to disable No-Execute (NX/DEP) protection, allowing shellcode to execute in data pages. This technique bypasses OS-level protections entirely because the change happens below the operating system, making it nearly invisible to standard endpoint detection tools.

## Key facts
- MSRs are read/written with privileged instructions (`RDMSR`/`WRMSR`), requiring Ring 0 access — compromising a driver is a common path to reach them
- The `IA32_EFER` MSR controls critical features including NX bit enforcement and Long Mode activation
- UEFI Secure Boot settings and SMM (System Management Mode) behavior can be influenced through specific MSRs, making them a target in firmware-level attacks
- Hypervisors (VMMs) intercept MSR access from guest VMs using VM-exit controls, preventing guests from tampering with host CPU state
- Forensic tools like `rdmsr` (Linux) or CPU-Z can read MSR values for defensive auditing of unexpected configuration changes

## Related concepts
[[Rings of Protection]] [[Kernel Exploits]] [[NX Bit / DEP]] [[UEFI Secure Boot]] [[Hypervisor Security]]