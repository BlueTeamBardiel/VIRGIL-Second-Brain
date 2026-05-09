# Operating System Vulnerabilities

## What it is

In Forza, you can tune a car to perfection — but if you skip an oil change or ignore that the brake pads are worn, the McLaren you spent six hours dialing in still ends up in the wall at Le Mans. That's exactly what operating system vulnerabilities do — the OS underneath every app is itself a complex machine with worn parts, and unpatched flaws are the brake pads nobody changed.

An **operating system vulnerability** is a defect, misconfiguration, or unpatched flaw in the kernel, system services, drivers, or default configuration of an OS that an attacker can exploit to gain unauthorized access, escalate privileges, or disrupt operation.

## Why it matters

The OS sits below every application, so a single kernel-level flaw bypasses application security entirely — antivirus, EDR, MFA, all of it runs on top of an OS the attacker now owns. Compromise at this layer enables [[privilege escalation]], persistence via rootkits, lateral movement, and ransomware deployment; regulators (HIPAA, PCI-DSS) treat unpatched OS as a control failure.

**Exam angle (SY0-701 Objective 2.3):** know OS vulnerabilities as a distinct category alongside application, web-based, hardware, and virtualization vulnerabilities. CompTIA's classic trap is conflating OS vulnerabilities with application vulnerabilities — a flaw in `svchost.exe` or the Linux kernel is OS; a flaw in Apache is application. Also expect questions distinguishing **zero-day** vs. **known/unpatched** vulnerabilities and which mitigation (patching vs. compensating controls) applies.

## Key facts

### Categories of OS vulnerability

| Category | What it is | Example |
|---|---|---|
| **Kernel flaws** | Bugs in the core OS code running in ring 0 | [[Dirty COW]] (CVE-2016-5195), PrintNightmare (CVE-2021-34527) |
| **Privilege escalation** | Local user gains SYSTEM/root | [[sudo]] Baron Samedit (CVE-2021-3156) |
| **Default credentials / config** | Shipped insecure out of the box | Default admin passwords, open SMB shares |
| **Unpatched services** | Network-facing daemons missing fixes | [[EternalBlue]] SMBv1 (MS17-010) |
| **Driver vulnerabilities** | Signed drivers with exploitable flaws | [[BYOVD]] — Bring Your Own Vulnerable Driver |
| **End-of-life OS** | Vendor no longer issues patches | Windows 7, Server 2008, CentOS 6 |

### Attack mechanics

- **Remote code execution (RCE):** attacker triggers code execution over the network without auth — see [[EternalBlue]], [[BlueKeep]] (RDP, CVE-2019-0708).
- **Local privilege escalation (LPE):** low-priv shell becomes SYSTEM/root via kernel or service flaw.
- **Rootkits:** post-exploitation persistence by hooking the kernel — see [[kernel rootkit]] vs. [[user-mode rootkit]].
- **DLL hijacking / library injection:** OS loader trusts attacker-controlled paths.
- **Race conditions / TOCTOU:** time-of-check vs. time-of-use flaws in syscalls.

### Common SY0-701 vulnerability types tied to OS

- **[[Zero-day]]** — no patch exists yet; defense relies on EDR behavior detection, segmentation, least privilege.
- **[[Legacy systems]]** — EOL OS, no patches available; isolate or compensate.
- **[[Misconfiguration]]** — open shares, weak ACLs, disabled host firewall.
- **[[Firmware]] vulnerabilities** — adjacent category but often co-listed (UEFI, BIOS).

### Defenses

| Control | What it does |
|---|---|
| **[[Patch management]]** | Primary defense; close known CVEs on a defined cadence |
| **[[Vulnerability scanning]]** | Nessus, OpenVAS, Qualys — find missing patches and misconfigs |
| **[[Configuration baselines]]** | CIS Benchmarks, STIGs, hardened images |
| **[[Endpoint Detection and Response|EDR]]** | Behavioral detection of exploit chains, including zero-days |
| **[[Host-based firewall]]** | Reduce attack surface of network-facing services |
| **[[Least privilege]]** | Limit blast radius if a flaw is exploited |
| **[[Application allowlisting]]** | AppLocker, WDAC — block unsigned binaries post-exploit |
| **[[Secure Boot]] / measured boot** | Mitigates rootkits and bootkits |
| **Network segmentation** | Contain unpatched/legacy systems behind strict ACLs |

### Patch cadence

- **Microsoft:** Patch Tuesday — second Tuesday of each month; out-of-band for critical zero-days.
- **Linux distros:** continuous, distribution-managed (apt, yum, dnf).
- **Apple:** irregular but bundled in macOS / iOS point releases.
- Mean time to patch (**MTTP**) is the metric auditors care about; 30 days for critical is a common SLA.

### Exam-relevant distinctions

- **Vulnerability ≠ exploit ≠ threat.** A vulnerability is the flaw; an exploit is the weaponization; a threat is the actor or event.
- **CVE vs. CVSS:** [[CVE]] is the identifier, [[CVSS]] is the severity score (0.0–10.0).
- **Known vs. zero-day:** patch availability is the dividing line.

## Related concepts

[[Patch management]] · [[Zero-day]] · [[Privilege escalation]] · [[EternalBlue]] · [[CVE]] · [[CVSS]] · [[Endpoint Detection and Response]] · [[Configuration baselines]] · [[Legacy systems]] · [[BYOVD]] · [[Secure Boot]] · [[Least privilege]] · [[Vulnerability scanning]]

---
*Source: VIRGIL knowledge base — 2026-05-08*