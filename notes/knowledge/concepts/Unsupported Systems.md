# Unsupported Systems

## What it is
Like a car whose manufacturer stopped making replacement parts — it still drives, but when something breaks, you're on your own. An unsupported system is any hardware or software that the vendor no longer provides security patches, updates, or technical assistance for, leaving all newly discovered vulnerabilities permanently unmitigated.

## Why it matters
In 2017, the WannaCry ransomware campaign devastated organizations running Windows XP — a system Microsoft had stopped supporting in 2014. Hospitals using XP-based medical devices couldn't patch the EternalBlue SMB vulnerability, and patient care was directly disrupted. The attack demonstrated that unsupported systems don't just risk data loss; they become contagion vectors that spread compromise across entire networks.

## Key facts
- **End-of-Life (EOL)** means the vendor stops all support; **End-of-Support (EOS)** specifically means no more security patches — both leave systems permanently vulnerable to newly published CVEs.
- Unsupported systems violate **PCI-DSS, HIPAA, and NIST frameworks**, which require vendors to maintain patched, supported software in regulated environments.
- Common compensating controls include **network segmentation/isolation**, application whitelisting, and host-based firewalls to limit attack surface when patching is impossible.
- **Legacy systems** (old but still running) are frequently unsupported — industrial control systems (ICS/SCADA) and medical devices are notorious examples due to long operational lifespans.
- Organizations can sometimes purchase **Extended Security Updates (ESU)** from vendors like Microsoft as a paid bridge, but this is a temporary measure, not a long-term solution.

## Related concepts
[[Patch Management]] [[Vulnerability Management]] [[Legacy Systems]] [[Compensating Controls]] [[End-of-Life Software]]