# POP3

## What it is
Think of POP3 like a postal worker who delivers all your mail to your house and takes it away from the post office — once it's delivered, the post office copy is gone. Post Office Protocol version 3 is an email retrieval protocol that downloads messages from a mail server to a local client, typically deleting them from the server afterward. It operates at the Application Layer and uses TCP port **110** (plaintext) or **995** (with TLS/SSL).

## Why it matters
POP3 transmitting credentials in cleartext over port 110 is a classic target for credential harvesting via network sniffing — an attacker on the same network segment can run Wireshark and capture usernames and passwords in a single packet capture session. This is why network defenders look for unencrypted POP3 traffic in DLP and SIEM alerts, and why organizations are pushed to enforce POP3S (port 995) or migrate entirely to IMAP over TLS.

## Key facts
- **Port 110** = POP3 plaintext; **Port 995** = POP3S (encrypted with TLS/SSL)
- POP3 is a **download-and-delete** protocol by default — mail is removed from the server after retrieval, making multi-device access problematic (unlike IMAP, which syncs)
- Credentials sent over port 110 are transmitted in **cleartext**, making it vulnerable to **on-path (MITM) attacks** and **credential sniffing**
- Common POP3 commands include `USER`, `PASS`, `RETR`, and `QUIT` — simple enough that attackers can manually script brute-force attempts
- POP3 is frequently targeted in **password spraying** and **brute-force attacks** against exposed mail servers; blocking unauthenticated external access to port 110/995 is a standard hardening step

## Related concepts
[[IMAP]] [[SMTP]] [[Cleartext Protocols]] [[Port Security]] [[Credential Sniffing]]