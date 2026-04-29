# Keychain

## What it is
Think of it as a bank vault with individual safety deposit boxes — each app gets its own locked compartment, and the vault manager (the OS) controls who has the keys. Apple's Keychain is a secure, encrypted storage system built into macOS and iOS that stores passwords, cryptographic keys, certificates, and other sensitive credentials, protected by the device's hardware security enclave and user authentication.

## Why it matters
In 2019, researchers demonstrated that malicious macOS apps could silently dump Keychain contents if the system's security database was misconfigured or if the attacker had already escalated to root. Defenders rely on Keychain's access control lists (ACLs) to enforce that only authorized applications can retrieve a given secret — making lateral movement harder even after initial compromise.

## Key facts
- Keychain items are encrypted using AES-256, with encryption keys derived from the user's login password and protected by the Secure Enclave on modern Apple hardware.
- Each Keychain item has an **Access Control List (ACL)** specifying which applications are permitted to read it — preventing one app from stealing another app's stored credentials.
- On iOS, the Keychain persists across app reinstalls but is wiped on factory reset; items can optionally be synced via **iCloud Keychain** using end-to-end encryption.
- The `security` command-line tool on macOS can query and manipulate Keychain items — a common target in post-exploitation scripts and red team playbooks.
- Keychain items have **accessibility attributes** (e.g., `kSecAttrAccessibleAfterFirstUnlock`) that define *when* an item can be accessed — a misconfigured attribute can expose secrets while the device is locked.

## Related concepts
[[Credential Storage]] [[Secure Enclave]] [[Access Control Lists]] [[Certificate Management]] [[macOS Security Architecture]]