# Secure Baselines

## What it is

In Cyberpunk 2077, every netrunner you face in Night City has been pre-configured with a specific quickhack loadout, a defined RAM pool, and ICE that determines which intrusions they can resist. A street thug's deck has weak defaults; a Militech corpo's deck is hardened, locked down, and patched. That pre-defined, repeatable security configuration applied before deployment is exactly what a **secure baseline** does — it's the standardized, hardened starting state every system inherits before it ever touches your network.

A **secure baseline** is a documented, approved minimum security configuration applied uniformly to systems of a given type, defining settings, services, patches, and controls required before the system is considered fit for production.

## Why it matters

Without a baseline, every server, laptop, and switch is a unique snowflake — meaning every one is a unique attack surface. Default credentials, unused services, and missing patches are how ransomware gets a foothold; baselines are how you stop building doors for attackers to walk through. Compliance frameworks (PCI-DSS, HIPAA, NIST 800-53) explicitly require documented baselines, and audit failure here is straightforward: no baseline, no finding-free audit.

**Exam angle:** Objective 4.1 lists baselines under three explicit verbs you must distinguish — **establish**, **deploy**, and **maintain**. CompTIA's favorite trap is mixing up *deploy* (pushing the baseline via Group Policy, MDM, Ansible, etc.) with *maintain* (continuously verifying drift hasn't occurred). Expect a scenario question where the answer hinges on which phase failed.

## Key facts

### The three lifecycle phases (memorize verbatim)

| Phase | What happens | Tools/Methods |
|---|---|---|
| **Establish** | Define the baseline — settings, services, patch level, controls | [[CIS Benchmarks]], [[DISA STIGs]], [[NIST 800-53]], vendor hardening guides |
| **Deploy** | Push the baseline to systems at scale | [[Group Policy]], [[Microsoft Intune]], [[Ansible]], [[Puppet]], [[Chef]], [[SCCM]], [[MDM]] |
| **Maintain** | Verify ongoing compliance, detect [[configuration drift]], reapply | [[SCAP]] scanners, [[OpenSCAP]], [[Tenable]], [[Qualys]], [[Microsoft Defender for Cloud]] |

### What a baseline actually contains

- **Account policy**: password length, lockout thresholds, [[MFA]] requirements
- **Service hardening**: disable unused services (Telnet, SMBv1, LLMNR, NetBIOS)
- **Port closure**: only required ports open — e.g., **443/TCP** open, **23/TCP** (Telnet) closed
- **Patch level**: minimum OS build and required security updates
- **Audit/logging**: which events forwarded to [[SIEM]], retention period
- **Encryption**: [[BitLocker]] / [[LUKS]] / [[FileVault]] enabled, [[TLS]] 1.2+ only
- **Removed defaults**: default accounts disabled, default credentials changed, sample apps removed

### Common baseline standards

| Source | Coverage | Notes |
|---|---|---|
| **[[CIS Benchmarks]]** | OS, cloud, apps, network gear | Free PDFs; Level 1 (basic) vs Level 2 (high-security, may break functionality) |
| **[[DISA STIGs]]** | DoD-mandated; very strict | Security Technical Implementation Guides |
| **[[NIST 800-53]] / 800-171** | Federal control catalog | Mapped to FISMA/CMMC |
| **Vendor guides** | Microsoft Security Baselines, AWS Well-Architected | Often integrated with native tooling |

### Configuration drift — the silent killer

**[[Configuration drift]]** is when systems gradually diverge from the baseline due to manual changes, emergency fixes, or untracked admin actions. A server hardened on day 1 is not hardened on day 400 unless something is checking. Drift detection is the *maintain* phase, typically performed via:

- **[[SCAP]]** (Security Content Automation Protocol) — automated compliance scanning
- **[[Infrastructure as Code]]** with idempotent reapplication
- **File integrity monitoring** ([[Tripwire]], [[AIDE]]) for critical files

### Baselines vs. related concepts (CompTIA loves this)

| Term | What it is |
|---|---|
| **Baseline** | The required *secure* starting state |
| **[[Hardening]]** | The *act* of reducing attack surface to reach the baseline |
| **[[Benchmark]]** | A published *standard* you base your baseline on (CIS, STIG) |
| **[[Image]]** | A *snapshot* deployed to systems — often the baseline made tangible |

## Related concepts

[[Hardening]] · [[Configuration Management]] · [[CIS Benchmarks]] · [[DISA STIGs]] · [[Group Policy]] · [[SCAP]] · [[Configuration drift]] · [[Patch Management]] · [[Change Management]] · [[Golden Image]] · [[Infrastructure as Code]] · [[MDM]]

---
*Source: VIRGIL knowledge base — 2026-05-08*