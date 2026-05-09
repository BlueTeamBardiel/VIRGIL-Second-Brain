# Operating System Security

## What it is

In Red Dead Redemption 2, Arthur Morgan doesn't just walk into Saint Denis with a sawed-off shotgun on his back — the lawmen would shoot him on sight. He has to holster weapons, keep his honor in check, change clothes for the climate, and the game itself enforces these rules through the Wanted system, bounty hunters, and witness mechanics. That's exactly what operating system security does — it's the layered set of rules and enforcement mechanisms baked into the OS that decides who can do what, when, and what happens when they break the rules.

**Operating system security** is the configuration of an OS using hardening techniques, patching, secure baselines, and built-in controls to reduce attack surface and enforce least privilege.

## Why it matters

The OS is the layer attackers most want to compromise — root or SYSTEM access means full control of the host, lateral movement potential, and persistence. An unhardened OS leaves default accounts, unnecessary services, and unpatched kernels exposed; that's how ransomware crews land and pivot. For SY0-701 Objective 4.5, you must know **patch management**, **host-based firewall**, **HIDS/HIPS**, **endpoint protection**, **secure baselines**, **group policy**, and **SELinux**. CompTIA's favorite trap: confusing **Group Policy** (Windows configuration enforcement) with **SELinux/AppArmor** (Linux mandatory access control) — they solve overlapping problems on different platforms.

## Key facts

### Hardening fundamentals

- [[Secure baseline]] — a known-good configuration template (CIS Benchmarks, DISA STIGs, Microsoft Security Baselines) applied to every host of a given role.
- [[Attack surface reduction]] — disable unused services, close unused ports, remove default accounts, uninstall bloatware.
- [[Least functionality]] — the system does only what its job requires, nothing more.
- [[Default deny]] — start from nothing allowed, then permit explicitly.

### Windows-specific controls

| Control | Purpose |
|---|---|
| [[Group Policy]] (GPO) | Centralized configuration push via Active Directory |
| [[Local Security Policy]] | Per-host policy when not domain-joined |
| [[Windows Defender]] | Built-in AV/EDR |
| [[BitLocker]] | Full-disk encryption tied to [[TPM]] |
| [[User Account Control]] (UAC) | Privilege elevation prompt |
| [[AppLocker]] / [[WDAC]] | Application allow-listing |
| [[Credential Guard]] | Isolates LSASS to block [[Pass-the-Hash]] |

### Linux-specific controls

| Control | Purpose |
|---|---|
| [[SELinux]] | Mandatory access control with type enforcement (Red Hat default) |
| [[AppArmor]] | Path-based MAC (Ubuntu/SUSE default) |
| [[iptables]] / [[nftables]] | Host firewall |
| [[sudo]] | Granular privilege delegation, logged |
| [[chroot]] / [[namespaces]] | Process isolation |
| [[auditd]] | Kernel-level audit logging |

**SELinux modes**: `enforcing` (blocks and logs), `permissive` (logs only), `disabled` (off — the wrong answer on every exam).

### Patch management

- [[Patch management]] lifecycle: identify → test → deploy → verify → document.
- **Patch Tuesday** — Microsoft's second-Tuesday release cadence.
- [[WSUS]] / [[SCCM]] / [[Intune]] for Windows; **yum/dnf/apt** with management layers like [[Spacewalk]] or [[Ansible]] for Linux.
- Emergency out-of-band patches for actively exploited CVEs.

### Endpoint defense layers

- [[Host-based firewall]] — packet filtering at the OS level.
- [[HIDS]] — detects intrusions, alerts only.
- [[HIPS]] — detects and blocks inline.
- [[EDR]] — behavioral monitoring, telemetry, response actions.
- [[XDR]] — EDR correlated across email, identity, network.
- [[Antivirus]] — signature + heuristic file scanning.
- [[FIM]] (File Integrity Monitoring) — flags unauthorized changes to system files (e.g., [[Tripwire]], [[OSSEC]]).

### Boot-chain protections

- [[Secure Boot]] — UEFI verifies bootloader signature.
- [[Measured Boot]] — TPM records hashes of each boot stage for [[remote attestation]].
- [[Hardware Root of Trust]] — immutable trust anchor in silicon.

### Common hardening targets

- Disable [[SMBv1]], [[Telnet]], [[FTP]], [[LLMNR]], [[NetBIOS]].
- Enforce [[password policy]] and [[account lockout]].
- Enable [[audit logging]] and forward to [[SIEM]].
- Remove or rename **Administrator** / **root** where possible; require [[MFA]] for privileged access.

### Exam traps

- **GPO ≠ SELinux**. GPO configures Windows; SELinux enforces MAC on Linux.
- **HIDS detects, HIPS prevents.** One letter, one big difference.
- **Secure Boot** verifies signatures; **Measured Boot** records hashes. Don't swap them.
- A **baseline** is the configuration; a **benchmark** (CIS) is the published standard you baseline against.

## Related concepts

[[Endpoint Detection and Response]] · [[Trusted Platform Module]] · [[Mandatory Access Control]] · [[Principle of Least Privilege]] · [[Configuration Management]] · [[Vulnerability Management]] · [[Application Allow-listing]] · [[Full Disk Encryption]]

---
*Source: VIRGIL knowledge base — 2026-05-08*