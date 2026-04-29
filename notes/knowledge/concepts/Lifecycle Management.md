# Lifecycle Management

## What it is
Like a car that needs oil changes, inspections, and eventually gets retired when repair costs exceed its value, every system and credential in your environment has a birth, a useful life, and a necessary death. Lifecycle management is the disciplined process of tracking, maintaining, and decommissioning assets — software, hardware, accounts, certificates, and keys — across their entire operational lifespan. It ensures nothing persists longer than it should or degrades into a vulnerability through neglect.

## Why it matters
In 2017, Equifax's catastrophic breach exposed 147 million records largely because an expired SSL certificate had disabled their intrusion detection system for 19 months — a textbook lifecycle management failure. Had certificate expiration been tracked and renewed, the malicious traffic would have been inspected and flagged. This single oversight turned a patchable Apache Struts vulnerability into a national security event.

## Key facts
- **End-of-Life (EOL) software** no longer receives security patches; running EOL systems (e.g., Windows Server 2008) violates most compliance frameworks including PCI-DSS and HIPAA
- **Certificate lifecycle management** includes issuance, renewal, and revocation; unrevoked compromised certificates remain trusted until expiry, enabling MITM attacks
- **Account lifecycle** requires provisioning, periodic recertification (access reviews), and timely deprovisioning — orphaned accounts are a top vector for privilege abuse
- **Patch management** is a subset of lifecycle management; NIST SP 800-40 recommends patching critical vulnerabilities within 30 days
- **Cryptographic agility** — the ability to swap deprecated algorithms (e.g., SHA-1, 3DES) — depends entirely on knowing where those algorithms are deployed in your lifecycle inventory

## Related concepts
[[Patch Management]] [[Certificate Management]] [[Identity and Access Management]] [[Asset Management]] [[End-of-Life Systems]]