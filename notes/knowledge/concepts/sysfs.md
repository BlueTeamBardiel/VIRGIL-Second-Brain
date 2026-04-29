# sysfs

## What it is
Think of sysfs like a live dashboard on a nuclear reactor control panel — every dial and readout reflects the real-time state of the machine's internals. Precisely: sysfs is a Linux pseudo-filesystem mounted at `/sys` that exposes kernel data structures, device attributes, and hardware configuration as a navigable file tree, allowing userspace processes to read and modify kernel state through ordinary file I/O.

## Why it matters
Attackers with local access can traverse `/sys` to enumerate hardware details, identify virtualized environments (fingerprinting `/sys/hypervisor`), or manipulate kernel parameters — for example, writing to `/sys/kernel/security/lockdown` bypass attempts or disabling IOMMU protections via `/sys/bus/pci` entries to enable DMA attacks. Defenders monitor sysfs for unauthorized writes as an indicator of privilege escalation or rootkit activity, since malicious kernel modules often manipulate sysfs entries to hide processes or devices.

## Key facts
- Mounted at `/sys` by the kernel at boot; not a real disk filesystem — all content is generated in memory at access time
- Organized into subsystems: `/sys/class`, `/sys/bus`, `/sys/devices`, `/sys/kernel`, `/sys/module`
- Writing to `/sys/kernel/kptr_restrict` or `/sys/kernel/dmesg_restrict` can harden systems against kernel pointer leaks — common hardening steps
- Rootkits targeting sysfs can unlink device entries to hide malicious USB devices from the `/sys/bus/usb/devices/` tree
- Distinct from `/proc` (procfs): procfs exposes process information; sysfs exposes device/driver model — though both are pseudo-filesystems used in forensic triage

## Related concepts
[[procfs]] [[kernel hardening]] [[privilege escalation]] [[IOMMU]] [[Linux file permissions]]