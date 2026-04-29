# virtual-machines

## What it is
Like a snow globe sitting on your desk — a complete, self-contained world that can be shaken, smashed, or reset without affecting the table it sits on. A virtual machine (VM) is a software-emulated computer running on top of a physical host, with its own OS, memory, storage, and network stack, isolated from the underlying hardware via a hypervisor.

## Why it matters
Malware analysts routinely detonate ransomware samples inside a VM (a "sandbox") to observe behavior safely — the ransomware encrypts the VM's virtual disk, the analyst snapshots the damage, then rolls back to a clean state in seconds. However, sophisticated malware like Emotet performs VM-detection checks (looking for VMware registry keys or suspiciously round RAM values like exactly 2048 MB) and goes dormant to evade analysis.

## Key facts
- **Two hypervisor types matter for Security+:** Type 1 (bare-metal, e.g., VMware ESXi, Hyper-V) runs directly on hardware; Type 2 (hosted, e.g., VirtualBox) runs on top of a host OS — Type 1 has a smaller attack surface.
- **VM escape** is a critical vulnerability where malicious code breaks out of the guest VM and executes on the host or other VMs — CVE-2018-3646 (L1TF) demonstrated this via speculative execution.
- **Snapshots** enable rapid rollback, making VMs the standard tool for malware sandboxing, penetration testing labs, and forensic investigation.
- **VM sprawl** is a compliance and attack-surface risk: forgotten, unpatched VMs on a network are valid targets even if "not in use."
- Shared clipboard and drag-and-drop features between host and guest are common **VM isolation weaknesses** that should be disabled in security-sensitive environments.

## Related concepts
[[hypervisor]] [[sandboxing]] [[containerization]] [[malware-analysis]] [[snapshot-forensics]]