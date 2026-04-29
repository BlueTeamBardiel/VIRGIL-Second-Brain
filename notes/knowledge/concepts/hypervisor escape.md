# hypervisor escape

## What it is
Imagine a prisoner who finds a flaw in the prison blueprints — not just breaking out of their cell, but out of the entire building. A hypervisor escape is when malicious code running inside a virtual machine exploits a vulnerability in the hypervisor layer to break containment and execute code on the underlying host OS or other VMs. It is one of the most severe virtualization attacks because it collapses the isolation that cloud infrastructure depends on.

## Why it matters
In 2015, the "VENOM" vulnerability (CVE-2015-3456) in the virtual floppy disk controller of QEMU allowed an attacker inside a guest VM to execute arbitrary code on the host — affecting millions of cloud VMs across providers like AWS, Rackspace, and DigitalOcean. An attacker exploiting this in a shared-tenant cloud could pivot from their rented VM into the host and then laterally into neighboring customers' VMs, achieving full multi-tenant compromise.

## Key facts
- Hypervisor escapes target either **Type 1 (bare-metal)** hypervisors like VMware ESXi or **Type 2 (hosted)** hypervisors like VirtualBox — Type 1 escapes are typically more catastrophic
- VENOM (CVE-2015-3456) is the canonical exam-relevant example; it exploited an unchecked buffer in legacy virtual hardware
- Attack surface includes emulated hardware devices, shared memory regions, hypercalls, and VM management interfaces
- Mitigations include **disabling unnecessary virtual hardware**, applying hypervisor patches promptly, and using hardware-assisted isolation (Intel VT-x, AMD-V)
- Defense-in-depth matters: even post-escape, network segmentation and host EDR should limit lateral movement

## Related concepts
[[virtual machine]] [[privilege escalation]] [[container escape]] [[cloud security]] [[side-channel attack]]