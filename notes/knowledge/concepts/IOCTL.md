# IOCTL

## What it is
Think of IOCTL like a secret menu at a restaurant — the standard waiter (system calls) handles normal orders, but special requests go through a back-channel conversation directly with the kitchen (hardware driver). IOCTL (Input/Output Control) is a system call that allows user-space processes to send device-specific control commands directly to kernel drivers, bypassing the standard read/write interface. It's the escape hatch between generic OS abstractions and hardware-specific functionality.

## Why it matters
Malicious drivers and rootkits frequently abuse IOCTL handlers because kernel driver code runs at ring 0 with no memory protection guardrails. The 2021 exploitation of vulnerable Gigabyte/ASUS signed drivers (BYOVD — Bring Your Own Vulnerable Driver) used crafted IOCTL calls to achieve kernel-level code execution, bypassing modern EDR solutions that live in user-space. Defenders monitor for suspicious IOCTL call patterns from unexpected processes as a rootkit detection signal.

## Key facts
- IOCTL operates via the `DeviceIoControl()` function on Windows and `ioctl()` syscall on Linux, bridging user-space to kernel-space
- Each IOCTL command is identified by a numeric code; improper validation of these codes or their associated buffers leads to privilege escalation vulnerabilities
- BYOVD attacks weaponize legitimate, Microsoft-signed drivers with vulnerable IOCTL handlers to gain kernel execution while evading signature-based defenses
- Insufficient bounds checking in IOCTL buffer handling is a classic source of kernel heap overflows and arbitrary write primitives
- Security tools like Sysmon and kernel ETW (Event Tracing for Windows) can log driver load events and detect anomalous IOCTL-based activity

## Related concepts
[[Kernel Exploitation]] [[Privilege Escalation]] [[BYOVD Attack]] [[Rootkit]] [[Ring Protection Model]]