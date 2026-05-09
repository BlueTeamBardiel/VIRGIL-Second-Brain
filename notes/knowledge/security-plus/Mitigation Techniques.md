# Mitigation Techniques

## What it is

In Marvel Rivals, when a Hela main is shredding your backline, you don't just sigh — you swap to Doctor Strange's Shield of the Seraphim, push a Vanguard up to body-block, pop Luna Snow's healing ult, and have your Strategist cleanse the bleed. Layered, specific responses to a specific threat. That's exactly what **mitigation techniques** do — they're the concrete defensive moves you make to reduce risk after a vulnerability or threat is identified.

**Mitigation techniques** are the technical and administrative actions taken to reduce the likelihood or impact of a security threat, applied as part of incident response and ongoing hardening per SY0-701 Objective 2.5.

## Why it matters

Without layered mitigation, a single exploited weakness becomes a full breach — credential theft becomes domain compromise, a phished link becomes ransomware on the file server. CompTIA expects you to match the *right* mitigation to the *right* scenario: they will hand you a situation ("a user clicked a malicious macro") and ask which technique applies, not the textbook definition. The classic trap: confusing **segmentation** (network-layer isolation) with **isolation** (removing a host entirely), or picking **patching** when the question is really asking about **configuration enforcement**.

## Key facts

### The SY0-701 mitigation list (Objective 2.5)

CompTIA names these explicitly. Memorize the list — questions assume you know each by name.

| Technique | What it does | When you pick it |
|---|---|---|
| [[Segmentation]] | Splits networks into zones (VLANs, subnets, microsegmentation) | Limit lateral movement, separate IoT/OT/guest |
| [[Access control]] | Enforces who can do what (ACLs, RBAC, ABAC) | Least privilege, separation of duties |
| [[Application allow list]] | Only approved binaries execute | Kiosks, servers, high-assurance endpoints |
| [[Isolation]] | Removes a host/process from the network | Active incident, malware containment |
| [[Patching]] | Applies vendor fixes for known CVEs | Vulnerability management, post-disclosure |
| [[Encryption]] | Renders data unreadable without a key | Data-at-rest, data-in-transit, lost devices |
| [[Monitoring]] | Continuous telemetry collection and alerting | Detection, audit, threat hunting |
| [[Least privilege]] | Users/processes get minimum needed rights | Reduce blast radius of compromise |
| [[Configuration enforcement]] | Forces systems to a known-good baseline | Drift prevention, GPO/MDM/Ansible |
| [[Decommissioning]] | Securely retires assets and data | EOL hardware, employee offboarding, cloud cleanup |
| [[Hardening techniques]] | Reduces attack surface on a specific system | Servers, endpoints, network gear |

### Hardening techniques (sub-list CompTIA loves)

- **Encryption** — full-disk ([[BitLocker]], [[LUKS]]), TLS for transit
- **Installation of endpoint protection** — [[EDR]]/[[XDR]], not just legacy AV
- **Host-based firewall** — local rules independent of perimeter
- **Host-based intrusion prevention system ([[HIPS]])** — blocks malicious behavior on the endpoint
- **Disabling ports/protocols** — close [[Telnet]] (23), [[FTP]] (21), [[SMBv1]] (445), unused services
- **Default password changes** — every appliance, every IoT device, no exceptions
- **Removal of unnecessary software** — bloatware, unused agents, attack surface reduction

### Mapping mitigations to attacks (the exam scenario shape)

| Attack | Primary mitigation |
|---|---|
| [[Lateral movement]] after compromise | Segmentation, least privilege |
| [[Ransomware]] execution | Application allow list, EDR, immutable backups |
| [[Zero-day]] exploit | Monitoring, isolation, virtual patching/[[WAF]] |
| [[Privilege escalation]] | Least privilege, patching, configuration enforcement |
| [[Data exfiltration]] | Encryption, [[DLP]], egress monitoring |
| Stolen laptop | Full-disk encryption, remote wipe |
| Misconfigured cloud bucket | Configuration enforcement, [[CSPM]] |

### The trap CompTIA sets

- **Segmentation vs. isolation**: segmentation is *architectural* (always on); isolation is *reactive* (you yanked the cable).
- **Patching vs. configuration enforcement**: patching fixes vendor code; configuration enforcement fixes *your* settings drifting from baseline.
- **Allow list vs. deny list**: allow list is default-deny (more secure, harder to manage); deny list is default-allow (easier, weaker).
- **Decommissioning** includes [[data sanitization]] — degaussing, crypto-erase, physical destruction. Throwing the drive in a closet is not decommissioning.

## Related concepts

[[Defense in depth]] · [[Zero Trust]] · [[Incident response]] · [[Vulnerability management]] · [[Change management]] · [[Baseline configuration]] · [[Group Policy]] · [[Endpoint detection and response]]

---
*Source: VIRGIL knowledge base — 2026-05-08*