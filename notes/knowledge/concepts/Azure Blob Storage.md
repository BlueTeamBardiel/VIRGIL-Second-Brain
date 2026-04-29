# Azure Blob Storage

## What it is
Think of it like a massive public self-storage facility where anyone can rent a unit — but the owner sometimes forgets to put a lock on the door. Azure Blob Storage is Microsoft's cloud object storage service for unstructured data (images, backups, logs, documents), organized into **containers** within **storage accounts**. Access is controlled through account keys, Shared Access Signatures (SAS), or Azure Active Directory RBAC.

## Why it matters
Misconfigured Blob Storage containers set to **anonymous public access** have repeatedly exposed sensitive data — a classic example being organizations accidentally publishing database backups or PII-laden log files to publicly readable containers. Attackers routinely scan for open Azure blobs using tools like BlobHunter or **gray-zone enumeration** via predictable storage account naming (e.g., `companyname.blob.core.windows.net`). Defenders must enforce the "Allow Blob Public Access = Disabled" setting at the storage account level and audit containers regularly using Microsoft Defender for Storage.

## Key facts
- **Three access tiers**: Hot (frequent access), Cool (infrequent), Archive (rarely accessed, hours to rehydrate) — misidentifying tier affects data recovery time in incident response
- **Shared Access Signatures (SAS)** grant time-limited, scoped access without exposing the master account key; leaked SAS tokens are a common credential exposure vector
- **Anonymous access levels**: Private (default), Blob (individual blob read), Container (full container listing + read) — Container-level anonymous access is the dangerous misconfiguration
- **Soft delete and versioning** can be enabled for data recovery, relevant for ransomware resilience planning
- Microsoft Defender for Storage detects anomalies like **unusual access patterns**, access from Tor exit nodes, and potential malware uploads via hash reputation

## Related concepts
[[Cloud Storage Misconfiguration]] [[Shared Access Signatures]] [[Azure Active Directory RBAC]] [[Data Exposure]] [[Microsoft Defender for Cloud]]