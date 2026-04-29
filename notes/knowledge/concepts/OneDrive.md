# OneDrive

## What it is
Think of OneDrive as a safety deposit box at a bank — your files live in Microsoft's vault, accessible from any branch (device) with your key (credentials). Precisely, OneDrive is Microsoft's cloud-based file storage and synchronization service, integrated with Microsoft 365, that stores user data on Microsoft Azure infrastructure.

## Why it matters
Attackers who compromise a Microsoft 365 account gain immediate access to everything synced in OneDrive — business plans, credentials files, HR documents — without ever touching the victim's physical machine. In 2022, several BEC (Business Email Compromise) campaigns leveraged stolen OAuth tokens to silently exfiltrate OneDrive contents, bypassing MFA entirely because the token was already authenticated. Defenders monitor OneDrive audit logs in Microsoft Purview to detect mass downloads or unusual geographic access patterns.

## Key facts
- OneDrive data is encrypted **in transit** (TLS) and **at rest** (BitLocker AES-256 on Azure), but Microsoft holds the encryption keys by default — not the customer
- **Known Folder Move (KFM)** automatically syncs Desktop, Documents, and Pictures — meaning endpoint ransomware can encrypt and push corrupted files directly to the cloud within minutes
- OneDrive **Version History** (default: 500 versions for up to 30 days) can serve as a ransomware recovery mechanism
- Sharing links can be set to **"Anyone with the link"** — a misconfiguration that exposes files publicly without authentication
- Access is controlled via **Azure AD (Entra ID)** Conditional Access Policies, making identity the primary security boundary

## Related concepts
[[Microsoft 365 Security]] [[OAuth Token Theft]] [[Data Loss Prevention (DLP)]] [[Ransomware]] [[Cloud Storage Security]]