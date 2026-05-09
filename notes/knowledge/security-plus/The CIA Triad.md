# The CIA Triad

## What it is

In Valorant, your match depends on three things working at once: your enemies can't see your team comp before the round starts (the agent select screen is hidden until lock-in), your shots register exactly as you fired them (no one's tampering with the netcode mid-bullet), and the servers actually stay up so you can play ranked at all. Strip away any one of those and the game collapses. That's exactly what the **CIA Triad** does — it's the three properties every security control on Earth is trying to preserve.

The **CIA Triad** is the foundational security model defining **Confidentiality**, **Integrity**, and **Availability** as the core objectives of information protection.

## Why it matters

Every control you'll be tested on — encryption, hashing, RAID, MFA, backups — exists to defend one or more legs of this triad. Lose confidentiality and you're explaining the data breach to regulators and the press. Lose integrity and your financial records, medical dosages, or election tallies become fiction. Lose availability and the business stops earning money while engineers chase a ransomware payment.

**Exam angle (Objective 1.2):** CompTIA loves scenario questions that hand you a breach and ask which leg of the triad was violated. The classic trap: confusing **integrity** (data was *changed*) with **confidentiality** (data was *seen*). A second favorite: ransomware is primarily an **availability** attack — even though it encrypts data, the harm is denial of access, not disclosure. Read the scenario verbiage carefully.

## Key facts

### The three pillars

| Pillar | Goal | Violated by | Defended with |
|---|---|---|---|
| **Confidentiality** | Only authorized parties can read data | [[Eavesdropping]], [[Shoulder surfing]], [[Data breach]], [[Sniffing]] | [[Encryption]], [[Access controls]], [[MFA]], [[Steganography]] |
| **Integrity** | Data is accurate and unaltered | [[Tampering]], [[On-path attack]], [[SQL injection]], malicious modification | [[Hashing]] ([[SHA-256]]), [[Digital signatures]], [[HMAC]], [[Checksums]] |
| **Availability** | Authorized users can access data when needed | [[DoS]], [[DDoS]], [[Ransomware]], hardware failure, power loss | [[Redundancy]], [[RAID]], [[Load balancing]], [[Backups]], [[Failover]], [[UPS]] |

### Confidentiality mechanics

- **Encryption at rest**: [[AES-256]], [[BitLocker]], [[LUKS]] — protects stored data.
- **Encryption in transit**: [[TLS]] 1.3 (port 443), [[IPsec]], [[SSH]] (port 22) — protects moving data.
- **Access control models**: [[RBAC]], [[ABAC]], [[MAC]], [[DAC]] — protects *who reads what*.
- **Data classification**: Public, Internal, Confidential, Restricted — defines the protection threshold.

### Integrity mechanics

- **Hash functions**: [[MD5]] (broken — collision attacks), [[SHA-1]] (deprecated), [[SHA-256]] / [[SHA-3]] (current).
- **Digital signatures**: hash + asymmetric encryption with sender's private key. Provides integrity *and* [[non-repudiation]].
- **HMAC**: hash combined with a shared secret — verifies message hasn't been altered in transit.
- **File integrity monitoring ([[FIM]])**: tools like [[Tripwire]] detect unauthorized changes to system files.

### Availability mechanics

- **Redundancy levels**: [[RAID 1]] (mirroring), [[RAID 5]] (striping with parity), [[RAID 10]] (mirrored stripes).
- **Geographic**: [[hot site]], [[warm site]], [[cold site]] — disaster recovery tiers.
- **Metrics**: [[MTTR]], [[MTBF]], [[RTO]], [[RPO]] — quantify availability commitments.
- **Uptime targets**: "five nines" = 99.999% = ~5.26 minutes of downtime per year.

### The extended models (worth knowing)

- **[[CIANA]]**: adds **Non-repudiation** and **Authentication**.
- **Parkerian Hexad**: adds **Possession/Control**, **Authenticity**, **Utility**.
- SY0-701 sticks to the classic triad plus **[[non-repudiation]]** as a separate concept under Objective 1.2.

### Common scenario mappings

| Scenario | Pillar violated |
|---|---|
| Attacker reads emails via stolen credentials | Confidentiality |
| Attacker modifies a wire transfer amount | Integrity |
| Ransomware encrypts the file server | Availability (primarily) |
| DDoS knocks the e-commerce site offline on Black Friday | Availability |
| Insider exfiltrates the customer database | Confidentiality |
| Malware silently alters log files to hide its tracks | Integrity |

## Related concepts

[[Non-repudiation]] · [[AAA]] · [[Defense in depth]] · [[Zero Trust]] · [[Risk management]] · [[Encryption]] · [[Hashing]] · [[Redundancy]] · [[Security controls]]

---
*Source: VIRGIL knowledge base — 2026-05-08*