# Adding new NFC cards

## What it is
Like making a copy of a physical key by pressing it into clay and casting a duplicate, adding a new NFC card means enrolling a credential (a unique UID or encrypted token) into a system so it becomes a recognized authenticator. Precisely, it is the provisioning process by which an NFC-enabled smart card, fob, or device is registered in an access control system's whitelist or back-end credential database.

## Why it matters
An attacker with brief physical access to an NFC reader (or its management interface) can clone a legitimate card's UID using a Proxmark device and then enroll the cloned credential — effectively adding a ghost key to the building. This attack is particularly dangerous in older systems using unencrypted UID-only authentication (common with EM4100 or basic MIFARE Classic cards), where no cryptographic challenge-response prevents replay of captured identifiers.

## Key facts
- NFC cards operating at 13.56 MHz (ISO 14443) are more secure than 125 kHz proximity cards, but both can be cloned if enrollment controls are weak
- MIFARE Classic cards use a proprietary crypto (CRYPTO1) that has been fully broken; enrolling one provides a false sense of security
- Secure enrollment requires mutual authentication and encrypted communication between the card and reader, not just UID matching
- Role-based access control (RBAC) should govern *who* can add new credentials — unauthorized provisioning is a critical insider threat vector
- Modern systems use PKI-backed credentials (e.g., FIDO2, PIV/CAC cards) where the private key never leaves the card, making cloning during enrollment non-trivial

## Related concepts
[[NFC Cloning]] [[Physical Access Control Systems]] [[Credential Management]] [[MIFARE Vulnerabilities]] [[Insider Threat]]