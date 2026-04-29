# DHE

## What it is
Like two strangers mixing secret paint colors in public — each contributes a private splash, combines it openly, and ends up with an identical shared color no eavesdropper can reproduce — DHE (Diffie-Hellman Ephemeral) is a key exchange protocol where both parties generate temporary key pairs for each session, deriving a shared secret without ever transmitting it directly.

## Why it matters
In 2015, the LOGJAM attack demonstrated that attackers could downgrade TLS connections to 512-bit "export-grade" DHE and break the key exchange in real time using precomputed discrete logarithm tables — allowing them to decrypt and modify HTTPS traffic mid-session. This forced the security community to deprecate weak DHE parameters and pushed adoption of ECDHE with properly sized keys.

## Key facts
- The "Ephemeral" in DHE means a brand new key pair is generated for **every session**, which is what provides **Perfect Forward Secrecy (PFS)** — past sessions stay encrypted even if long-term keys are later compromised
- DHE uses the **discrete logarithm problem** over finite fields as its mathematical hardness assumption
- Recommended minimum DHE key size is **2048 bits**; 1024-bit and below are considered broken
- DHE is slower than ECDHE (Elliptic Curve DHE) because it requires larger key sizes to achieve equivalent security
- In TLS 1.3, **plain RSA key exchange was eliminated entirely** — only ephemeral methods like DHE and ECDHE are permitted, making PFS mandatory

## Related concepts
[[Perfect Forward Secrecy]] [[ECDHE]] [[TLS Handshake]]