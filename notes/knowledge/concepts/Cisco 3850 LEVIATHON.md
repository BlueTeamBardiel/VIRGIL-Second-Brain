# Cisco 3850 YOUR_SWITCH

## What it is
Like a master key hidden inside a hotel's own lock-changing machine, LEVIATHAN is an implant framework targeting Cisco Catalyst 3850 switches — it persists inside the device's own management infrastructure, surviving reboots and firmware updates by embedding itself in trusted processes. Specifically, it refers to a nation-state-grade persistent implant (attributed to the Chinese APT group LEVIATHAN/APT40) designed to compromise Cisco IOS XE network infrastructure at the firmware or OS level.

## Why it matters
In 2023, Cisco disclosed CVE-2023-20198 and CVE-2023-20273 — zero-day vulnerabilities in IOS XE's Web UI — which threat actors actively exploited to implant malicious configurations and backdoors on thousands of internet-facing switches and routers, including the 3850 series. An attacker owning your core switch owns *all traffic traversing it*, enabling passive credential harvesting, lateral movement, and VLAN hopping without triggering traditional endpoint detection tools.

## Key facts
- Cisco Catalyst 3850 switches run **IOS XE**, not classic IOS — a Linux-kernel-based OS that introduces a larger attack surface than legacy platforms
- CVE-2023-20198 carried a **CVSS score of 10.0** (maximum severity), allowing unauthenticated privilege escalation to level 15 (full admin)
- Implants on network infrastructure are **invisible to EDR/antivirus** tools — only firmware integrity checks or traffic anomaly analysis can detect them
- Cisco's recommended remediation included **disabling the HTTP/HTTPS server feature** (`no ip http server`) if not operationally required — a key hardening control
- Infrastructure implants fall under the **MITRE ATT&CK tactic T1542.005** (Pre-OS Boot: ROMMON), reflecting firmware-level persistence techniques

## Related concepts
[[IOS XE Hardening]] [[Network Infrastructure Attacks]] [[CVE Exploitation]] [[Privilege Escalation]] [[Firmware Persistence]]