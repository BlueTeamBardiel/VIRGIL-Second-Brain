# Azure Storage

## What it is
Think of Azure Storage like a massive self-storage facility where anyone with the right key — or sometimes *no* key at all — can access your unit. Precisely, it is Microsoft Azure's cloud-based object, file, queue, and table storage service, offering scalable data persistence across blob containers, file shares, and more. Access is controlled through storage account keys, Shared Access Signatures (SAS), and Azure Active Directory RBAC.

## Why it matters
In 2021, misconfigured Azure Blob Storage containers with public access enabled exposed sensitive corporate data — a recurring pattern where developers set container access to "anonymous read" during testing and never lock it down. An attacker can enumerate publicly accessible blobs using tools like `azure-enum-blobs` or even simple HTTP GET requests, exfiltrating gigabytes of PII, credentials, or internal documents with zero authentication required. Defenders must enforce **Allow Blob Public Access = Disabled** at the storage account level.

## Key facts
- **Storage Account Keys** grant root-level access to all data — if leaked, they must be rotated immediately; treat them like private SSH keys
- **Shared Access Signatures (SAS tokens)** provide time-limited, scoped access; an overly permissive or non-expiring SAS token is a critical finding in any cloud audit
- **Azure Defender for Storage** detects anomalies like unusual access patterns, hash reputation analysis on uploaded files, and access from Tor exit nodes
- **Private Endpoints** can bind storage access exclusively to a virtual network, eliminating public internet exposure entirely
- Microsoft Entra ID (Azure AD) RBAC is preferred over key-based access — the principle of least privilege applies through roles like *Storage Blob Data Reader*

## Related concepts
[[Cloud Misconfiguration]] [[Shared Access Signatures]] [[Azure Active Directory]] [[Data Exfiltration]] [[Principle of Least Privilege]]