# VirtualBox

## What it is
Like a snow globe sitting on your real desk — a completely self-contained world inside a container, untouched by the table beneath it. VirtualBox is a free, open-source Type 2 hypervisor from Oracle that runs guest operating systems as isolated virtual machines on top of a host OS, sharing the host's physical hardware through a software abstraction layer.

## Why it matters
Security analysts use VirtualBox to detonate malware samples in a disposable sandbox — if ransomware executes and encrypts everything, you simply delete the snapshot and restore to a clean state. Conversely, attackers actively probe for VirtualBox artifacts (registry keys like `HKLM\SOFTWARE\Oracle\VirtualBox Guest Additions`, the `VBoxService.exe` process) to detect sandbox environments and halt execution, evading dynamic analysis entirely.

## Key facts
- **Type 2 hypervisor**: Runs on top of a host OS (Windows, Linux, macOS), unlike Type 1 (bare-metal) hypervisors like VMware ESXi or Hyper-V
- **Snapshot functionality**: Captures full VM state at a point in time, enabling instant rollback — critical for repeatable malware analysis
- **Guest Additions**: Drivers installed inside the guest VM that improve performance and enable host-guest integration; their presence is a primary VM detection indicator used by malware
- **Network modes matter**: NAT, Bridged, Host-Only, and Internal networking each carry different security implications — Host-Only isolates the VM from external networks, ideal for malware sandboxing
- **VM escape vulnerabilities**: CVE-2019-2525 and similar bugs allow code in the guest to break out and execute on the host — a critical risk when analyzing untrusted code

## Related concepts
[[Hypervisor]] [[Sandbox Analysis]] [[Malware Evasion Techniques]] [[Snapshot and Rollback]] [[Network Segmentation]]