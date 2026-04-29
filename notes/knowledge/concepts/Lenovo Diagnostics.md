# Lenovo Diagnostics

## What it is
Like a mechanic's OBD port that lets you read engine codes — but built directly into the car's firmware — Lenovo Diagnostics is a pre-installed hardware testing utility on Lenovo devices that runs at the OS or UEFI level to test components like RAM, storage, and CPU. It ships as both a bootable tool and a Windows application (`LenovoDiagnosticsDriver.exe`).

## Why it matters
In 2022, security researchers discovered that the Lenovo Diagnostics Windows driver contained a vulnerable IOCTL handler that allowed any unprivileged local user to trigger arbitrary physical memory reads and writes — effectively handing attackers a kernel-level primitive without requiring an exploit chain. This vulnerability (CVE-2022-3699) was weaponized conceptually as a BYOVD (Bring Your Own Vulnerable Driver) attack vector, where an attacker deploys the legitimate signed driver to bypass kernel protections like Credential Guard and read LSASS memory.

## Key facts
- **CVE-2022-3699**: Local privilege escalation in `LenovoDiagnosticsDriver.sys`; CVSS score 7.8 (High); affected the Windows application variant, not the bootable ISO.
- **BYOVD relevance**: Because the driver is legitimately signed by Lenovo, it can bypass driver signature enforcement (DSE) controls and be used to defeat kernel-level defenses.
- **Root cause**: Improper access control on IOCTL dispatch — the driver failed to restrict `DeviceIoControl` calls to privileged users only.
- **Attack surface**: Requires local access (not remotely exploitable), making it relevant for post-exploitation lateral movement and privilege escalation phases.
- **Mitigation**: Lenovo issued patched driver versions; defenders should use Microsoft's Vulnerable Driver Blocklist and monitor for known-bad driver hashes via EDR solutions.

## Related concepts
[[Bring Your Own Vulnerable Driver (BYOVD)]] [[Kernel Exploitation]] [[Privilege Escalation]] [[Driver Signature Enforcement]] [[LSASS Credential Dumping]]