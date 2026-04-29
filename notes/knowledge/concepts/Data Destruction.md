# Data Destruction

## What it is
Like shredding a document versus tossing it in the recycling bin — simply deleting a file leaves the data physically intact on the drive, just invisible to the file system. Data destruction is the deliberate, permanent elimination of data from storage media so that it cannot be recovered through any forensic or technical means.

## Why it matters
When a hospital decommissions old MRI workstations and donates them without proper sanitization, attackers can use tools like Autopsy or Recuva to recover years of patient records from "deleted" partitions — triggering HIPAA violations and massive fines. Proper destruction protocols prevent this exact scenario by ensuring media is unreadable before leaving organizational control.

## Key facts
- **Three NIST SP 800-88 approved methods**: Clear (overwriting for reuse), Purge (degaussing or cryptographic erase), and Destroy (physical shredding, incineration, or disintegration)
- **Overwriting alone is insufficient for SSDs** — wear leveling means data may persist in reserved cells; cryptographic erasure (destroying the encryption key) is the preferred SSD sanitization method
- **Degaussing** renders hard drives permanently inoperable by disrupting the magnetic field — it cannot be used on SSDs or optical media
- **Certificate of Destruction** is a formal document provided by third-party sanitization vendors proving media was destroyed — required for compliance under regulations like HIPAA, PCI-DSS, and GDPR
- **Crypto-shredding** is the technique of encrypting data first, then destroying the key — making recovery computationally infeasible without physically destroying the media

## Related concepts
[[Data Sanitization]] [[Media Disposal Policy]] [[Cryptographic Erasure]] [[Chain of Custody]] [[NIST SP 800-88]]