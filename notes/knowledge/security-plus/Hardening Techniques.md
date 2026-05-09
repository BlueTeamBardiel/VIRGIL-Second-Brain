# Hardening Techniques

## What it is

In DOTA, you don't send a level 1 hero with no items into a 5v5 teamfight wearing only the starting Tango. You buy a Black King Bar for magic immunity, Eul's for dispel, Linken's Sphere to block single-target spells, and you ward the map so nothing surprises you. That's exactly what hardening does — you strip a system down to only what it needs and stack defenses against the specific attacks it will face.

**Hardening** is the systematic reduction of a system's [[attack surface]] by disabling unnecessary services, applying secure configurations, and layering protective controls to minimize exploitable weaknesses.

## Why it matters

Default installations are catastrophic. A fresh OS, IoT device, or [[SCADA]] controller ships with debug ports open, default credentials, verbose error messages, and services nobody asked for — every one of which is an attacker's foothold. Unhardened systems lead to ransomware footholds, lateral movement via [[SMB]], and audit failures under [[PCI DSS]], [[HIPAA]], and [[CMMC]].

**Exam angle (Objective 2.5):** CompTIA wants you to map the *right* hardening technique to the *right* device class. The trap: they describe a mobile device and bait you with "patching" when the answer is [[MDM]], or describe an [[ICS]]/SCADA system and bait you with "install antivirus" when the correct answer is network segmentation because you can't patch a 1998 RTU running proprietary firmware.

## Key facts

### The hardening techniques CompTIA lists explicitly

| Technique | What it does | Where it shines |
|---|---|---|
| [[Encryption]] | Protects data at rest and in transit | Endpoints, mobile, removable media |
| Installation of [[Endpoint Protection]] | AV, EDR, [[HIPS]] | Workstations, servers |
| [[Host-based firewall]] | Filters traffic per-host | Servers in flat networks |
| [[Host-based intrusion prevention system|HIPS]] | Blocks malicious behavior on the host | High-value endpoints |
| **Disabling ports/protocols** | Closes unused listeners | Every system, always |
| **Default password changes** | Eliminates known credentials | IoT, network gear, appliances |
| **Removal of unnecessary software** | Shrinks attack surface | Servers, workstations |

### Hardening targets by device class

| Device | Primary hardening moves |
|---|---|
| **Workstations / Servers** | [[Patching]], [[CIS Benchmarks]], [[Group Policy]], remove bloatware, disable [[SMBv1]], enforce [[BitLocker]] |
| **Mobile devices** | [[MDM]] enrollment, containerization, screen lock, remote wipe, app allowlisting |
| **Cloud workloads** | [[CIS Benchmarks]], [[CSPM]], IAM least privilege, disable public S3 buckets |
| **Network appliances** | Change default creds, disable [[Telnet]] (port 23), disable [[HTTP]] mgmt, enable [[SSH]] (22) only, restrict mgmt VLAN |
| **[[IoT]] devices** | Segregated VLAN, disable [[UPnP]], firmware updates, change defaults |
| **[[ICS]]/[[SCADA]]** | Network segmentation, [[data diode]], jump hosts — *not* aggressive patching; uptime is sacred |
| **[[RTOS]] / Embedded** | Code signing, secure boot, minimal services, vendor patch cadence |

### The configuration baseline pipeline

1. **Establish a baseline** — [[CIS Benchmarks]], [[DISA STIGs]], or vendor security guides.
2. **Apply via automation** — [[Group Policy]], [[Ansible]], [[Intune]], [[SCCM]].
3. **Audit continuously** — [[SCAP]] scans, [[OpenSCAP]], [[Nessus]] compliance scans.
4. **Drift detection** — [[FIM]] (file integrity monitoring), config management tooling.

### Ports and protocols you disable on sight

| Disable | Replace with |
|---|---|
| [[Telnet]] (23) | [[SSH]] (22) |
| [[FTP]] (21) | [[SFTP]] (22) / [[FTPS]] (990) |
| [[HTTP]] (80) for admin | [[HTTPS]] (443) |
| [[SNMPv1]]/v2c (161) | [[SNMPv3]] |
| [[SMBv1]] (445) | SMBv3 with signing |
| [[LM]]/[[NTLMv1]] | [[Kerberos]] / NTLMv2 |

### Common CompTIA traps

- **"Hardening" ≠ "patching."** Patching is one technique within hardening. Don't conflate.
- **ICS/SCADA hardening is mostly *segmentation*.** You can't reboot a turbine controller for Patch Tuesday.
- **Mobile hardening = [[MDM]] policies**, not host firewalls.
- **Removing unnecessary software** is a separate listed technique from disabling ports — they want you to recognize both.
- **Default password changes** apply to firmware, BMCs, [[iDRAC]]/[[iLO]], printers, IP cameras — not just user accounts.

## Related concepts

[[Attack surface]] · [[CIS Benchmarks]] · [[DISA STIGs]] · [[Group Policy]] · [[Patch management]] · [[MDM]] · [[Endpoint Detection and Response|EDR]] · [[Host-based firewall]] · [[Network segmentation]] · [[Secure baseline]] · [[Configuration management]] · [[Least functionality]]

---
*Source: VIRGIL knowledge base — 2026-05-08*