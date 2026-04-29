# WPA2-PSK

## What it is
Think of it like a neighborhood gate where everyone uses the same key card — convenient, but if one resident loses theirs, the whole neighborhood is compromised. WPA2-PSK (Wi-Fi Protected Access 2 - Pre-Shared Key) is a wireless authentication mode where all clients authenticate using one shared passphrase, which is then used to derive unique per-session encryption keys via the 4-way handshake. It uses AES-CCMP encryption, making it far stronger than its WEP and WPA-TKIP predecessors.

## Why it matters
An attacker within range can passively capture the 4-way handshake when a client connects to the network, then take it offline and run dictionary or brute-force attacks using tools like Hashcat or Aircrack-ng — never touching the live network again. This is exactly why a weak passphrase like "Summer2024!" on a corporate guest Wi-Fi can lead to full network access; the cryptography is solid but the human-chosen secret is the vulnerability. Defenses include enforcing long, random passphrases (20+ characters) and migrating to WPA2-Enterprise where practical.

## Key facts
- Uses the **4-way handshake** to derive the Pairwise Transient Key (PTK); capturing this handshake is the first step in offline cracking attacks
- Encryption standard is **AES-CCMP** (Counter Mode with CBC-MAC Protocol) — not TKIP, which is deprecated and weaker
- Vulnerable to **PMKID attacks** (modern variant) which don't even require capturing a client handshake — just an AP association request
- The **PMK** (Pairwise Master Key) is derived from: `PBKDF2(HMAC-SHA1, passphrase, SSID, 4096 iterations, 256 bits)`
- WPA2-PSK is suitable for **home/small office** environments; enterprises should use **WPA2/WPA3-Enterprise** (802.1X + RADIUS) to avoid shared-secret risk

## Related concepts
[[WPA3-SAE]] [[4-Way Handshake]] [[802.1X Authentication]] [[Evil Twin Attack]] [[PBKDF2]]