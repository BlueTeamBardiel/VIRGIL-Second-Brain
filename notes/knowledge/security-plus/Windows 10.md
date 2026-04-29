# Windows 10

## What it is
Think of Windows 10 like a massive apartment building — thousands of tenants (processes), shared hallways (kernel memory), a superintendent (SYSTEM account), and a front desk that checks IDs (UAC). Precisely, Windows 10 is Microsoft's flagship desktop OS released in 2015, built on the NT kernel, featuring a hybrid security architecture that separates user-mode and kernel-mode execution to contain damage from compromised processes.

## Why it matters
In the 2021 PrintNightmare vulnerability (CVE-2021-34527), attackers exploited the Windows Print Spooler service — running as SYSTEM — to execute arbitrary code with full privileges on unpatched Windows 10 machines, allowing lateral movement across enterprise networks. Defenders responded by disabling the spooler service on non-print servers, illustrating how Windows service attack surface directly drives organizational hardening decisions.

## Key facts
- **UAC (User Account Control)** separates standard user tokens from administrator tokens; even admins run with reduced privileges until elevation is explicitly granted
- **Windows Defender Credential Guard** uses virtualization-based security (VBS) to isolate LSASS memory, blocking Pass-the-Hash and credential dumping attacks
- **Windows 10 EOL**: Consumer support ended October 14, 2025 — running it past EOL means no security patches, a compliance violation under frameworks like PCI-DSS
- **Security baselines** are published by Microsoft via the Security Compliance Toolkit; deviations from these baselines are frequent CySA+ exam topics
- **Event Log IDs to know**: 4624 (successful logon), 4625 (failed logon), 4688 (process creation) — critical for SIEM-based threat detection

## Related concepts
[[User Account Control]] [[Credential Guard]] [[Windows Event Logs]] [[LSASS]] [[Patch Management]]