# ACPI

## What it is
Think of ACPI like a universal remote control for your computer's hardware—it lets the operating system talk to physical devices (fans, power supplies, batteries) instead of each device speaking its own dialect. ACPI (Advanced Configuration and Power Interface) is a firmware standard that gives the OS low-level control over power management, thermal management, and device configuration without needing proprietary drivers for every component.

## Why it matters
An attacker can exploit ACPI tables (stored in firmware) to inject malicious code that runs before the OS boots—bypassing security measures like Secure Boot. Researchers have demonstrated ACPI rootkits that persist across reboots and modify how the system handles power states. Defenders must validate ACPI table signatures and monitor firmware integrity to prevent this attack vector.

## Key facts
- ACPI tables (DSDT, SSDT) contain bytecode interpreted by the ACPI Machine Language (AML) interpreter running in the kernel
- Power states S0-S5 map to sleep/hibernate modes; attackers can manipulate transitions to extract sensitive data
- ACPI is mandatory on modern x86/x64 systems and runs with Ring 0 privileges, making vulnerabilities catastrophic
- DMA-capable devices can read/write ACPI tables during sleep states without OS intervention (a DMA attack vector)
- UEFI firmware stores and executes ACPI code, making it part of the firmware attack surface

## Related concepts
[[Firmware Security]] [[DMA Attack]] [[Secure Boot]] [[Rootkit]] [[Privilege Escalation]]