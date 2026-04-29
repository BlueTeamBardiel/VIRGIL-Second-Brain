# IMAPS

## What it is
Think of IMAPS as a locked armored truck versus IMAP being an open flatbed — the same mail gets delivered, but one is wrapped in protective steel. IMAPS (Internet Message Access Protocol Secure) is IMAP encrypted via TLS/SSL, allowing email clients to securely retrieve and manage messages stored on a mail server. It ensures that credentials and message content are protected in transit between the client and server.

## Why it matters
Without IMAPS, an attacker performing a man-in-the-middle attack on a coffee shop's unencrypted Wi-Fi could capture IMAP traffic in plaintext using Wireshark, harvesting usernames and passwords in seconds. Enforcing IMAPS on port 993 instead of plain IMAP on port 143 closes this interception window entirely, making credential theft via passive sniffing infeasible. This is why many organizations block port 143 at the firewall and mandate 993 exclusively.

## Key facts
- **Port 993** is the standard port for IMAPS; plain IMAP uses port **143**
- IMAPS wraps the entire IMAP session in **TLS**, protecting authentication and message content from eavesdropping
- Unlike STARTTLS (which upgrades a plaintext connection mid-session), IMAPS initiates TLS **from the very first byte** of the connection
- A misconfigured mail server accepting both ports 143 and 993 creates a **downgrade attack** opportunity where an attacker can force the client to use the unencrypted channel
- IMAPS is distinct from end-to-end encryption (like S/MIME or PGP) — it only protects the **client-to-server transit**, not the stored message at rest on the server

## Related concepts
[[IMAP]] [[SMTPS]] [[TLS]] [[POP3S]] [[Email Security]] [[Man-in-the-Middle Attack]]