# Credentials from Password Stores

## What it is
Like a master key cabinet that burglars target first because it unlocks every other door in the building, password stores are centralized repositories where credentials are cached or saved — and compromising them yields cascading access. Precisely, this attack technique (MITRE ATT&CK T1555) involves adversaries extracting saved usernames and passwords from dedicated storage locations such as browser credential databases, OS keychains, or third-party password managers.

## Why it matters
During the 2020 SolarWinds campaign, attackers harvested credentials from password stores on compromised endpoints to enable lateral movement across victim networks without triggering brute-force alerts. Defenders counter this by enforcing endpoint detection rules around processes unexpectedly reading credential database files (e.g., Chrome's `Login Data` SQLite file) and by deploying privileged access workstations that restrict credential caching.

## Key facts
- **Browser password stores** (Chrome, Firefox, Edge) store credentials in SQLite databases; Chrome encrypts them with DPAPI, which an attacker running as the same user can decrypt without additional privileges
- **Windows Credential Manager** stores web and Windows credentials accessible via `cmdkey /list` or tools like Mimikatz's `dpapi` module
- **macOS Keychain** holds Wi-Fi passwords, certificates, and app credentials — accessible via `security` CLI or targeted by tools like `Chainbreaker`
- **Third-party managers** (KeePass, 1Password) are targeted via memory scraping or malicious plugins; KeePass CVE-2023-32784 allowed plaintext master password recovery from process memory
- Detection focus: monitor for unusual access to known credential store file paths and abnormal process injection into password manager processes

## Related concepts
[[DPAPI (Data Protection API)]] [[Credential Dumping]] [[OS Credential Dumping]] [[Lateral Movement]] [[Keylogging]]