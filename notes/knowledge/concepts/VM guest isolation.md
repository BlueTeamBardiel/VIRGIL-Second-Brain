# VM guest isolation

## What it is
Think of a hotel where each guest room has soundproof walls, separate locks, and no shared minibars — guests can't rifle through each other's belongings even though they share the same building. VM guest isolation is the hypervisor's enforcement that one virtual machine cannot read, write, or interfere with the memory, storage, or processes of another VM running on the same physical host.

## Why it matters
In 2018, the **VENOM vulnerability** (CVE-2015-3456) and later **Spectre/Meltdown** demonstrated that flaws in hypervisors or shared CPU caches could allow a malicious guest VM to escape its sandbox and read memory belonging to the host or sibling VMs. A compromised tenant in a shared cloud environment could theoretically exfiltrate cryptographic keys from a neighboring tenant's VM — making isolation failures catastrophic in multi-tenant infrastructure.

## Key facts
- **Type 1 hypervisors** (bare-metal: VMware ESXi, Hyper-V, Xen) provide stronger isolation than **Type 2** (hosted: VirtualBox, VMware Workstation) because they run directly on hardware without a host OS attack surface in between.
- **VM escape** is the attack where malicious code breaks out of the guest VM and gains control of the hypervisor or host OS — classified as a critical severity class of vulnerability.
- Isolation is enforced through hardware-assisted virtualization (**Intel VT-x / AMD-V**) and memory segmentation (EPT/NPT), not just software controls.
- **Side-channel attacks** (Spectre, Meltdown, L1TF) can bypass isolation at the CPU cache level even when the hypervisor itself is uncompromised.
- Snapshots and shared clipboard/drag-and-drop features are common **misconfiguration vectors** that can weaken guest isolation if left enabled in production environments.

## Related concepts
[[Hypervisor security]] [[VM escape]] [[Side-channel attacks]] [[Container isolation]] [[Cloud shared responsibility model]]