# States of Data

## What it is
Like water existing as ice, liquid, or steam depending on what's happening to it, data exists in three distinct states depending on whether it's being stored, moved, or processed. **Data at rest** is stored on a medium (disk, USB, cloud bucket); **data in transit** is moving across a network; **data in use** is actively loaded into RAM or CPU registers for processing.

## Why it matters
In 2017, an AWS S3 misconfiguration exposed Verizon customer records — data at rest with no encryption and broken access controls. Had server-side encryption (SSE) been enforced, the raw files would have been unreadable even after unauthorized access. Each state demands its own protection strategy; defending only one state leaves the others exposed.

## Key facts
- **Data at rest** → protect with full-disk encryption (BitLocker, FileVault) or database encryption (TDE); governed by controls like access permissions and DLP tools
- **Data in transit** → protect with TLS 1.2/1.3, IPsec, or VPN tunnels; plaintext protocols (HTTP, FTP, Telnet) leave this state completely exposed
- **Data in use** → hardest to protect; lives in RAM unencrypted; attacked via cold boot attacks, RAM scraping malware (common in POS breaches like Target 2013), and DMA attacks
- All three states are explicitly tested on **Security+ SY0-701** as part of the data classification and protection domain
- Emerging tech like **homomorphic encryption** and **Trusted Execution Environments (TEEs)** specifically target data-in-use protection — still largely experimental at scale

## Related concepts
[[Data Loss Prevention]] [[Encryption]] [[Cold Boot Attack]] [[Transport Layer Security]] [[Data Classification]]