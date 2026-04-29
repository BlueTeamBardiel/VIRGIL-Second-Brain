# FTPS

## What it is
Like putting a traditional postal letter inside a tamper-evident, locked diplomatic pouch, FTPS takes the old FTP protocol and wraps it inside TLS encryption. Formally, FTPS (FTP Secure) is an extension of the File Transfer Protocol that adds support for TLS (and its predecessor SSL) to encrypt both the control channel (commands) and the data channel (file transfers).

## Why it matters
In 2021, misconfigured FTP servers (including unencrypted FTP) were repeatedly exploited to exfiltrate sensitive data because credentials and file contents passed in plaintext, capturable by anyone with Wireshark on the same network segment. Deploying FTPS forces attackers to break TLS rather than simply sniff credentials — a dramatically higher bar. Security teams auditing perimeter services flag plain FTP as an immediate finding; FTPS or SFTP are the accepted remediation paths.

## Key facts
- **Two modes exist:** Explicit FTPS (FTPES) starts on port 21 and upgrades to TLS via the `AUTH TLS` command; Implicit FTPS starts encrypted immediately on port 990.
- **Not SFTP:** FTPS is FTP-over-TLS; SFTP is a completely separate protocol running over SSH (port 22) — they share no code or architecture.
- **Firewall headache:** FTPS uses separate dynamic data channel ports (passive mode), making firewall rules complex and a common misconfiguration source.
- **Certificate authentication:** FTPS supports mutual TLS, meaning both server and client can authenticate via certificates, not just passwords.
- **Control vs. data channel:** It is possible (and insecure) to encrypt only the control channel while leaving the data channel unencrypted — both should be enforced.

## Related concepts
[[SFTP]] [[TLS]] [[FTP]] [[Data-in-Transit Encryption]] [[Port Security]]