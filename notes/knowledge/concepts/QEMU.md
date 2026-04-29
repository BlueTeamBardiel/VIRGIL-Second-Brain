# QEMU

## What it is
Like a method actor who completely transforms into another person — accent, mannerisms, body language — QEMU is an open-source emulator that fully impersonates an entire computer architecture in software. It can pretend to be an ARM chip on an x86 machine, run a complete OS guest without any hardware support, or pair with KVM to achieve near-native performance through hardware-assisted virtualization. Unlike simple virtual machines, QEMU can emulate foreign CPU architectures entirely in software.

## Why it matters
Malware analysts use QEMU to safely detonate suspicious binaries in isolated environments — if ransomware encrypts the guest's filesystem, the host remains untouched and the analyst simply rolls back to a clean snapshot. Conversely, attackers target QEMU itself: the 2015 "VENOM" vulnerability (CVE-2015-3456) exploited a buffer overflow in QEMU's virtual floppy disk controller, allowing a guest VM to escape and execute code on the hypervisor host, compromising every other VM on that machine.

## Key facts
- QEMU operates in two modes: **full-system emulation** (emulates an entire machine including CPU, RAM, peripherals) and **user-mode emulation** (runs single binaries compiled for a different architecture)
- When paired with **KVM (Kernel-based Virtual Machine)**, QEMU offloads CPU virtualization to hardware, achieving ~95% native performance
- QEMU supports **live snapshots**, making it ideal for malware sandboxing — analysts can freeze, inspect, and restore VM state
- VM escape vulnerabilities in QEMU (like VENOM) are critical findings because they break the security boundary between guest and host hypervisor
- QEMU is the underlying engine for many enterprise platforms including **oVirt**, **Proxmox**, and **OpenStack compute nodes**

## Related concepts
[[Hypervisor]] [[VM Escape]] [[Sandbox Analysis]] [[KVM]] [[Malware Sandboxing]]