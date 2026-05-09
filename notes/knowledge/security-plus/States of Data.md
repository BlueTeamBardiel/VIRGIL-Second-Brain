# States of Data

## What it is

In Overwatch, Mercy's healing beam is constantly *moving* between her staff and her teammate, her ultimate charge sits *stored* in her resource bar between fights, and the moment she presses Q it's *being processed* into a Valkyrie transformation. Three different states, three different vulnerabilities — sever the beam mid-transit, kill her before she banks the charge, or interrupt the cast animation. That's exactly what **states of data** describes — every piece of information lives in one of three modes at any given moment, and each mode needs its own protection.

**States of data** are the three operational conditions in which information exists — **at rest**, **in transit** (in motion), and **in use** (in processing) — each requiring distinct cryptographic and access controls per SY0-701 Objective 3.3.

## Why it matters

If you encrypt the database but leave the API call cleartext, an attacker with a packet sniffer harvests credentials all afternoon while your AES-256 disk encryption sits there looking pretty. Compliance frameworks — PCI DSS, HIPAA, GDPR — all demand controls mapped to specific states, and missing one state is how breaches happen and audits fail. The CompTIA trap: candidates memorize "encrypt everything" but the exam will hand you a scenario where data is being *processed* in RAM (in use) and ask why TLS and full-disk encryption don't help — answer: because neither protects decrypted data inside running memory.

## Key facts

### The three states

| State | Definition | Where it lives | Primary defense |
|---|---|---|---|
| **At rest** | Stored, not actively moving or being processed | Disks, SSDs, tape backups, databases, S3 buckets | [[AES-256]], [[full-disk encryption]], [[transparent data encryption]] |
| **In transit** | Moving across a network or between systems | Ethernet, Wi-Fi, fiber, internal buses | [[TLS]] 1.3, [[IPsec]], [[SSH]], [[VPN]] |
| **In use** | Actively being processed in CPU/RAM | Memory pages, CPU registers, application heap | [[secure enclaves]], [[homomorphic encryption]], [[confidential computing]] |

### Data at rest

- **Mechanism**: symmetric encryption — usually [[AES]] in modes like [[XTS-AES]] (disk) or [[GCM]] (database fields)
- **Examples**: [[BitLocker]], [[FileVault]], [[LUKS]], [[TDE]] in SQL Server/Oracle, [[SED]] (self-encrypting drives)
- **Threats**: stolen laptops, decommissioned drives sold on eBay, snapshot exfiltration from cloud storage
- **Key management**: [[KMS]], [[HSM]], [[TPM]] — the encryption is only as strong as where the keys are kept

### Data in transit

- **Mechanism**: [[TLS]] for application traffic, [[IPsec]] for network-layer tunnels, [[SSH]] for admin sessions
- **Ports to memorize**: HTTPS 443, SMTPS 465, IMAPS 993, POP3S 995, FTPS 989/990, LDAPS 636, SSH 22
- **Threats**: [[on-path attack]] (formerly MITM), [[packet sniffing]], [[SSL stripping]], [[downgrade attacks]]
- **Watch for**: cleartext protocols still in use — HTTP, FTP, Telnet, SNMPv1/v2, LDAP — exam loves asking which to replace

### Data in use

- **Hardest to protect** — the data must be decrypted to be processed
- **Defenses**:
  - [[Trusted Execution Environment]] (TEE) — Intel [[SGX]], AMD [[SEV]], ARM [[TrustZone]]
  - [[Homomorphic encryption]] — compute on ciphertext without decrypting (slow, niche)
  - [[Secure multi-party computation]] (SMPC)
  - [[Confidential computing]] — cloud VMs with memory encryption (Azure Confidential VMs, AWS Nitro Enclaves)
- **Threats**: [[memory scraping]] (RAM-based malware like POS scrapers), [[cold boot attack]], [[Spectre]]/[[Meltdown]] side channels, [[DMA attacks]]

### Mapping to objective 3.3

Objective 3.3 explicitly lists "data states" alongside [[data classifications]], [[data sovereignty]], and [[data types]]. Expect questions that pair a state with the correct control — and at least one distractor that suggests TLS protects data at rest or that disk encryption protects data in transit. It does not.

## Related concepts

[[Encryption]] · [[TLS]] · [[IPsec]] · [[Full-disk encryption]] · [[Trusted Platform Module]] · [[Hardware Security Module]] · [[Data Loss Prevention]] · [[Tokenization]] · [[Data classification]] · [[Data sovereignty]] · [[Confidential computing]]

---
*Source: VIRGIL knowledge base — 2026-05-08*