# CHAP Authentication

## What it is
Imagine a bouncer who doesn't ask for your ID directly — instead, they whisper a random word to you, and you must hash it with a secret passphrase and whisper back the result. Only someone who knows the passphrase can produce the right answer. CHAP (Challenge Handshake Authentication Protocol) works exactly this way: the server sends a random challenge, the client hashes it with their password using MD5, and sends back the result — the actual password never crosses the wire.

## Why it matters
CHAP was designed to defeat replay attacks that plagued its predecessor, PAP, which sent passwords in plaintext. However, CHAP stores passwords in reversible (cleartext-equivalent) form on the server, meaning if an attacker compromises the authentication server, they can recover all user passwords — a significant trade-off that led organizations to prefer MS-CHAPv2 or move to EAP-based methods.

## Key facts
- CHAP uses a **three-way handshake**: server sends challenge → client responds with MD5(challenge + password) → server verifies
- The challenge is **re-issued periodically** during a session, not just at login, defending against session hijacking
- **PAP** (Password Authentication Protocol) is CHAP's weaker predecessor — it sends credentials in plaintext
- **MS-CHAPv2** is Microsoft's extension of CHAP, used in VPNs and WPA2-Enterprise; it was cracked in 2012 and is considered broken without PEAP tunneling
- CHAP is defined in **RFC 1994** and is commonly tested as the authentication method used in **PPP (Point-to-Point Protocol)** connections

## Related concepts
[[PAP Authentication]] [[MS-CHAPv2]] [[EAP (Extensible Authentication Protocol)]] [[PPP Protocol]] [[Replay Attacks]]