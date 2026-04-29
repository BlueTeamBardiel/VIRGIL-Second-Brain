# Hyper-V

## What it is
Like a landlord dividing a single house into separate apartments with locked doors between units, Hyper-V is Microsoft's Type 1 hypervisor that partitions physical hardware into isolated virtual machines running directly on the host OS. It creates a privileged "parent partition" (the host) and isolated "child partitions" (guest VMs), each with its own virtualized CPU, memory, and devices.

## Why it matters
In a datacenter breach scenario, an attacker who compromises a guest VM might attempt a **VM escape**—exploiting a Hyper-V vulnerability to break out of the child partition and gain code execution in the parent partition or on another VM. CVE-2021-28476, a critical Hyper-V remote code execution flaw, demonstrated exactly this risk: a malicious guest could crash or compromise the host kernel, making hypervisor patch management a tier-1 security priority.

## Key facts
- Hyper-V runs in **Ring -1** (VMX root mode), giving it higher privilege than the guest OS kernel which runs at Ring 0
- The **parent partition** has direct hardware access; child partitions communicate through the VMBus, which has been a recurring attack surface
- Hyper-V uses **Virtual Secure Mode (VSM)** to underpin Windows Defender Credential Guard and Virtualization-Based Security (VBS), isolating sensitive processes like LSASS
- Type 1 hypervisors (like Hyper-V) are generally considered more secure than Type 2 (like VirtualBox) because there is no underlying host OS to compromise
- Hyper-V is enabled by default on Windows Server and is the foundation of **Azure's cloud infrastructure**, meaning vulnerabilities have massive blast radius implications

## Related concepts
[[Virtualization-Based Security]] [[VM Escape]] [[Type 1 vs Type 2 Hypervisor]] [[Credential Guard]] [[Ring Privilege Levels]]