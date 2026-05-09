# Endpoint Security

## What it is

In Smash Bros, your character has a shield button. Press it and a bubble appears that absorbs hits — but the shield shrinks with damage, breaks if overused, and leaves you stunned and helpless when it shatters. That's exactly what endpoint security does — it's the layered defensive bubble around each individual device, and like a Smash shield, it has limits, blind spots, and fails catastrophically if neglected.

**Endpoint security** is the discipline of hardening, monitoring, and protecting individual devices (workstations, laptops, servers, mobile devices) against threats through a stack of host-based controls including [[EDR]], [[HIDS]]/[[HIPS]], antivirus, host firewalls, [[FDE]], and configuration hardening.

## Why it matters

The endpoint is where users click things, attackers land payloads, and data lives at rest — perimeter controls don't see TLS-encrypted traffic terminating on the laptop, and they can't stop a USB stick. A compromised endpoint becomes a beachhead for [[lateral movement]], [[ransomware]] detonation, and credential theft. SY0-701 Objective **4.5** explicitly names hardening targets and tools; CompTIA's favorite trap is conflating **EDR** (behavior + response on endpoints) with **XDR** (correlated across multiple sources) with **HIDS** (legacy, signature/log-based, no automated response).

## Key facts

### The endpoint protection stack

| Control | What it does | Detection model |
|---|---|---|
| [[Antivirus]] (AV) | Scans files for known malware | Signature-based |
| [[EDR]] (Endpoint Detection and Response) | Continuous behavior monitoring + automated response + forensics | Behavioral / heuristic |
| [[XDR]] (Extended Detection and Response) | EDR plus network, email, identity, cloud telemetry correlation | Cross-domain analytics |
| [[HIDS]] (Host Intrusion Detection System) | Alerts on suspicious host activity | Log/signature, alert-only |
| [[HIPS]] (Host Intrusion Prevention System) | Blocks suspicious host activity inline | Signature/behavior, blocking |
| [[Host-based firewall]] | Filters inbound/outbound traffic per host | Rule-based |
| [[DLP]] agent | Prevents sensitive data exfiltration from the host | Content inspection |
| [[FIM]] (File Integrity Monitoring) | Detects unauthorized changes to critical files | Hash comparison |

### Hardening techniques (Objective 4.5)

- **Configuration enforcement** — apply [[security baselines]] (CIS Benchmarks, DISA STIGs) via [[Group Policy]] or [[MDM]].
- **Patch management** — close vulnerabilities before exploitation; tested against [[CVE]]/[[CVSS]] feeds.
- **Decommissioning** — wipe ([[cryptographic erase]], degauss, physical destruction) before disposal.
- **Default password changes** — eliminate vendor-supplied credentials.
- **Disabling unused ports/services/protocols** — reduce attack surface (e.g., kill SMBv1, Telnet, unused USB).
- **Application allowlisting** (preferred) vs **blocklisting** — allowlist denies by default; blocklist permits by default and is weaker.
- **Host-based encryption** — [[FDE]] (BitLocker, FileVault, LUKS); protects [[data at rest]] if device is stolen.
- **TPM** ([[Trusted Platform Module]]) — hardware chip storing keys for FDE and [[Secure Boot]].
- **Secure Boot / [[UEFI]]** — verifies bootloader signatures, blocks [[bootkits]] and [[rootkits]].
- **[[HSM]]** (Hardware Security Module) — dedicated crypto hardware for high-value keys.

### EDR vs XDR vs HIDS — the CompTIA trap

| Feature | HIDS | EDR | XDR |
|---|---|---|---|
| Scope | Single host | Single host | Multiple domains (host, network, cloud, identity) |
| Response | Alert only | Automated containment (isolate, kill, rollback) | Orchestrated cross-source response |
| Data model | Logs/signatures | Behavioral telemetry, process trees | Correlated telemetry across vectors |
| Era | Legacy | Modern | Current generation |

### Mobile and special endpoints

- **[[MDM]]** (Mobile Device Management) — enforces policy, remote wipe, containerization.
- **[[BYOD]]/[[COPE]]/[[CYOD]]** deployment models change ownership and control boundaries.
- **[[Jailbreaking]]/rooting** defeats endpoint controls — detect via attestation.

### What breaks when endpoint security fails

- Single phished user → ransomware encrypts the file share → operations halt.
- Stolen laptop without FDE → notifiable data breach under GDPR/HIPAA.
- Unpatched endpoint → [[zero-day]] or n-day exploit → [[C2]] beacon → [[lateral movement]].
- Disabled host firewall → worm propagation across flat network.

## Related concepts

[[EDR]] · [[XDR]] · [[HIDS]] · [[HIPS]] · [[Antivirus]] · [[Host-based firewall]] · [[FDE]] · [[TPM]] · [[Secure Boot]] · [[Application allowlisting]] · [[MDM]] · [[Hardening]] · [[Patch management]] · [[DLP]] · [[FIM]] · [[Security baselines]]

---
*Source: VIRGIL knowledge base — 2026-05-08*