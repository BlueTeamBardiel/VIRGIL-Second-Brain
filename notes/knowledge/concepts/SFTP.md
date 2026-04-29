# SFTP

## What it is
Think of SFTP like a sealed armored truck for file delivery — where FTP is just tossing documents out a car window. SSH File Transfer Protocol (SFTP) is a secure file transfer subsystem that runs entirely over an SSH-encrypted tunnel on port 22, providing confidentiality, integrity, and authentication for file operations.

## Why it matters
In 2021, attackers targeting misconfigured FTP servers at healthcare organizations harvested patient records in plaintext transit. Had those organizations enforced SFTP, the transferred files would have been encrypted in-flight, rendering intercepted packets useless. Security teams enforcing SFTP over FTP as a baseline control directly prevents credential harvesting and man-in-the-middle interception of sensitive data.

## Key facts
- SFTP runs on **port 22** (same as SSH) — not to be confused with FTPS, which uses port 21 (control) and port 990 (implicit TLS)
- SFTP is **not FTP over SSL** — it is a completely different protocol built as an SSH extension; FTPS is FTP wrapped in TLS
- Supports **public key authentication**, allowing passwordless, phishing-resistant logins using SSH key pairs
- Provides **integrity checking** natively — each packet is authenticated within the SSH session, preventing data tampering in transit
- On Security+/CySA+ exams, SFTP is the **correct answer** when asked which protocol securely transfers files using SSH; FTPS uses certificates/TLS instead

## Related concepts
[[SSH]] [[FTPS]] [[FTP]] [[Public Key Infrastructure]] [[Encrypted Protocols]]