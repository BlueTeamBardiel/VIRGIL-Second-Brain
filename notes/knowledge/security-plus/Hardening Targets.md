# Hardening Targets

## What it is

In Factorio, a fresh assembling machine ships with no recipe set, no modules, no inserters wired in, and crucially — no walls or turrets around it. Leave it that way and the first medium biter wave erases your factory. Hardening is the part where you bolt on walls, install efficiency modules, set the recipe explicitly, and remove the unused inserter slots so nothing rogue connects to it. That's exactly what hardening does — you take a system shipped in its default, permissive state and strip it down to only what's necessary for its job.

**Hardening targets** are the specific categories of systems, devices, and software that must be configured to reduce attack surface by disabling unused services, applying secure baselines, patching, and enforcing least-functionality.

## Why it matters

Default configurations are the cockroach of breach reports — every incident response retro finds them. An unhardened IoT camera with `admin/admin` joins a botnet by Tuesday; an unhardened mobile device leaks corporate data through a sideloaded app; an unhardened ICS controller takes down a pipeline. SY0-701 Objective 4.1 explicitly enumerates the target categories below, and the CompTIA trap is asking you to match a *specific* hardening technique to a *specific* target type — e.g., they'll show "industrial control system" and the wrong answer will be "install antivirus" (you often can't), while the right answer is network segmentation or compensating controls.

## Key facts

### The SY0-701 hardening target list

CompTIA names these explicitly. Memorize the list — they test by category.

| Target | Primary hardening moves | Special concern |
|---|---|---|
| **Mobile devices** | [[MDM]], [[screen lock]], encryption, app vetting, disable sideloading | BYOD, lost/stolen |
| **Workstations** | [[Group Policy]] baselines, [[EDR]], patch mgmt, disable USB autorun | Largest attack surface |
| **Switches** | Disable unused ports, [[port security]], disable [[Telnet]] use [[SSH]], change default creds | Layer 2 attacks |
| **Routers** | ACLs, disable [[SNMP]] v1/v2c (use v3), management plane isolation | Edge exposure |
| **Cloud infrastructure** | [[CIS Benchmarks]], IAM least privilege, disable public buckets, [[CSPM]] | Misconfiguration is #1 cloud risk |
| **Servers** | Remove unused roles/features, [[host-based firewall]], [[FIM]], baseline configs | Crown jewels |
| **[[ICS]]/[[SCADA]]** | [[Network segmentation]], [[jump server]], compensating controls | Often can't patch — uptime mandate |
| **[[Embedded systems]]** | Firmware signing, secure boot, disable debug interfaces | Long lifecycles, no updates |
| **[[RTOS]]** | Minimal kernel, code signing, memory protection | Real-time constraints limit defenses |
| **[[IoT devices]]** | Change default creds, segment to IoT VLAN, disable [[UPnP]], firmware updates | Mirai-class botnet fodder |

### Universal hardening techniques

- **Disable unnecessary services and ports** — [[least functionality]] principle. Telnet (23), [[FTP]] (21), [[SMBv1]], [[NetBIOS]] (137-139) are common kills.
- **Change default credentials** — yes, still an exam answer in 2026.
- **Apply [[secure baselines]]** — [[CIS Benchmarks]], [[DISA STIGs]], vendor hardening guides.
- **Patch management** — known [[CVE]] remediation on a defined cadence.
- **[[Host-based firewall]]** and **[[HIDS]]/[[HIPS]]**.
- **[[Endpoint protection]]** — [[antivirus]], [[EDR]], [[XDR]].
- **Encryption at rest and in transit** — [[BitLocker]], [[FileVault]], [[LUKS]], [[TLS]] 1.2+.
- **Logging and monitoring** — forward to [[SIEM]].
- **[[Application allowlisting]]** — flip the model from "block bad" to "allow only known-good."

### The ICS / embedded / RTOS exception

These targets often *cannot* be hardened the normal way — patching breaks safety certifications, antivirus chews real-time deadlines, and the vendor disappeared in 2009. The exam answer is **compensating controls**: [[network segmentation]], [[jump servers]], [[unidirectional gateways]] (data diodes), and strict [[ACL]]s. If the question shows ICS/SCADA and an option says "install host antivirus," it's wrong.

### Mobile-specific layer

[[MDM]] (Mobile Device Management) enforces: full-device encryption, screen lock timeout, remote wipe, app vetting, [[containerization]] for corporate data, jailbreak/root detection, disable developer mode, disable sideloading.

### Cloud-specific layer

The shared responsibility model means *you* harden the OS, IAM, and configuration; the provider handles the hypervisor down. [[CSPM]] tools continuously check against benchmarks. Public S3 buckets, overly permissive IAM roles, and unencrypted snapshots are the classic findings.

### Exam traps

- "Hardening" ≠ "patching." Patching is one piece. Hardening is the whole reduction-of-attack-surface program.
- Embedded/ICS/RTOS questions almost always want **segmentation or compensating controls**, not endpoint agents.
- IoT default credentials remain the canonical wrong-default answer.
- Switches: the answer to "unused ports" is **disable them**, not "monitor them."

## Related concepts

[[Secure baselines]] · [[CIS Benchmarks]] · [[DISA STIGs]] · [[Least functionality]] · [[Attack surface reduction]] · [[Patch management]] · [[Network segmentation]] · [[MDM]] · [[Group Policy]] · [[Configuration management]] · [[Compensating controls]]

---
*Source: VIRGIL knowledge base — 2026-05-08*