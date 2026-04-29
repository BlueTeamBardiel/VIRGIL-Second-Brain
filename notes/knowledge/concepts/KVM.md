# KVM

## What it is
Think of KVM like a stage manager running multiple theater productions simultaneously in the same building — each show thinks it owns the whole venue, but the manager invisibly coordinates them all. Kernel-based Virtual Machine (KVM) is a Linux kernel module that turns the host OS into a Type 1 hypervisor, allowing multiple isolated virtual machines to run directly on hardware using CPU virtualization extensions (Intel VT-x or AMD-V).

## Why it matters
In cloud environments, KVM underpins platforms like OpenStack and is the hypervisor beneath many AWS and Google Cloud instances. A successful **VM escape** attack against KVM — where malicious code in a guest VM breaks out into the hypervisor or host kernel — would let an attacker pivot across every tenant sharing that physical server, turning one compromised VM into a full infrastructure breach.

## Key facts
- KVM is a **Type 1 (bare-metal) hypervisor** implemented as a loadable Linux kernel module (`kvm.ko`), not a separate OS layer
- Requires hardware virtualization support: **Intel VT-x** or **AMD-V** must be enabled in BIOS/UEFI
- Each guest VM runs as a regular **Linux process**, making it subject to standard Linux access controls (SELinux, cgroups, namespaces)
- **QEMU** is almost always paired with KVM to emulate hardware devices; vulnerabilities in QEMU (like the 2015 "VENOM" flaw, CVE-2015-3456) can enable VM escape
- Security hardening includes **sVirt** (SELinux labels per VM), mandatory access controls, and keeping QEMU updated to patch escape vectors

## Related concepts
[[Hypervisor]] [[VM Escape]] [[Type 1 vs Type 2 Hypervisor]] [[Containerization]] [[Hardware Virtualization]]