# EFS

## What it is
Like a personal safe bolted inside a shared office filing cabinet — only you have the combination, even though anyone can open the cabinet. Encrypting File System (EFS) is a Windows NTFS feature that transparently encrypts individual files and folders using the user's credentials, so even administrators cannot read the data without the user's private key or a designated Recovery Agent.

## Why it matters
A forensic investigator seizes a Windows laptop and boots from a live USB to bypass the login screen — but finds all files in the Documents folder unreadable because the employee had enabled EFS. Without the user's private key (stored in their profile) or a pre-configured Data Recovery Agent (DRA) certificate, the data is cryptographically inaccessible, demonstrating both EFS's defensive value and a recovery planning nightmare for IT.

## Key facts
- EFS uses a hybrid encryption model: a random **File Encryption Key (FEK)** encrypts the file using AES, and the FEK itself is encrypted with the user's RSA public key.
- EFS keys are tied to the **user profile** — copying an EFS-encrypted file to a FAT32 drive or sending it via email strips encryption and exposes plaintext.
- A **Data Recovery Agent (DRA)** is a designated account (often Domain Admin by default in older Windows domains) that can decrypt EFS files for recovery purposes.
- EFS does **not** protect data in transit or protect against the logged-in user — once you're authenticated, files open transparently.
- EFS is **separate from BitLocker**: BitLocker encrypts the entire volume at rest; EFS encrypts per-file and works above the filesystem layer.

## Related concepts
[[BitLocker]] [[PKI]] [[NTFS Permissions]] [[Data Recovery Agent]] [[Symmetric Encryption]]