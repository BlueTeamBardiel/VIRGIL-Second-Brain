# PSK

## What it is
Like two spies who memorized the same codebook before splitting up — they can communicate securely without ever exchanging keys in the open. A Pre-Shared Key (PSK) is a secret cryptographic value configured on both ends of a communication channel *before* any session begins, used to authenticate parties and/or derive session encryption keys.

## Why it matters
In WPA2-Personal networks, PSK is the backbone of home and small-business Wi-Fi security — and its weakness. An attacker running a passive capture of the 4-way handshake can take that offline and brute-force the PSK using tools like Hashcat. This is why a short or dictionary-word Wi-Fi password on WPA2-Personal is catastrophically easy to crack without any active interaction with the network.

## Key facts
- WPA2-Personal uses a PSK derived from the Wi-Fi passphrase via PBKDF2 with SSID as salt (4,096 iterations) — this is the target in offline attacks
- WPA3-Personal replaces PSK exchange with SAE (Simultaneous Authentication of Equals), which resists offline dictionary attacks even if the handshake is captured
- PSK authentication is **symmetric** — both sides must already possess the secret; there is no forward secrecy unless combined with ephemeral key exchange
- In IPsec/IKEv1, PSK authentication is vulnerable to identity leakage in aggressive mode, allowing offline cracking without even completing the handshake
- Contrast with certificate-based authentication (WPA2-Enterprise/802.1X), which is preferred in enterprise environments specifically *because* PSK management doesn't scale securely

## Related concepts
[[WPA2]] [[WPA3]] [[4-Way Handshake]] [[IKE]] [[PBKDF2]] [[Brute Force Attack]]