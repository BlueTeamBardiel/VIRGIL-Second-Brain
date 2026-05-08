# WEP Wired Equivalent Privacy

## What it is

In Silent Hill, you carry a pocket radio that emits static whenever monsters are near — except the monsters can hear it too, and the fog hides nothing from them while you stumble blind. That's exactly what WEP does — it pretends to encrypt your wireless traffic while broadcasting enough hints for any listener to decrypt it within minutes.

**WEP** is a 1997 IEEE 802.11 link-layer encryption protocol using the **RC4 stream cipher** with a 24-bit Initialization Vector, designed to provide privacy "equivalent to wired" — a promise it failed to keep.

## Why it matters

WEP is the textbook example of cryptographic failure: the IV is too short, transmitted in cleartext, and reused predictably, allowing offline key recovery in under five minutes with tools like `aircrack-ng`. Any network still running WEP should be considered open. The CCNA exam keeps it on the menu so you can identify it, condemn it, and replace it with [[WPA2]] or [[WPA3]] — knowing what's broken is half of knowing what to deploy.

## Key facts

### Cipher and key structure

- **Cipher**: [[RC4]] — a stream cipher that XORs a keystream against plaintext.
- **Key sizes**: 64-bit WEP (40-bit key + 24-bit IV) and 128-bit WEP (104-bit key + 24-bit IV). The marketing numbers include the IV; the actual secret is shorter.
- **IV ([[Initialization Vector]])**: 24 bits, sent in cleartext with each frame.

### The IV reuse vulnerability

- 24 bits = **16,777,216** possible IVs. On a busy AP, IVs repeat within hours.
- RC4 + reused IV + same key = **keystream reuse**. XOR two ciphertexts encrypted with the same keystream and the keystream cancels out, leaking plaintext.
- **Weak IVs** (the FMS attack, Klein attack, PTW attack) leak information about the key itself. Capture ~40,000–85,000 frames and the key falls out.
- No replay protection, no proper key management, [[CRC-32]] integrity check is linear and forgeable.

### Authentication modes

| Mode | How it works | Security reality |
|---|---|---|
| **Open System Authentication** | Client associates without proving key knowledge; key only used for encryption | Counterintuitively *more* secure than Shared Key |
| **Shared Key Authentication** | 4-way challenge-response: AP sends cleartext nonce, client returns it WEP-encrypted | Attacker captures both → derives keystream instantly |

Yes — Shared Key is worse than Open. The "authentication" leaks the keystream on the wire.

### Replacements

- **2003**: [[WPA]] (TKIP) — interim fix, still uses RC4.
- **2004**: [[WPA2]] (802.11i, [[CCMP]]/[[AES]]) — proper replacement.
- **2018**: [[WPA3]] (SAE) — current standard.

### Exam angles

- WEP = deprecated, broken, do not deploy. Recognize it in a question stem as the wrong answer for any "secure the WLAN" prompt.
- Know it uses **RC4** (contrast with WPA2's **AES-CCMP** and WPA3's **AES-GCMP**).
- Know **Open vs Shared Key**, and that Shared Key is the trap option.

## Related concepts

[[RC4]] · [[WPA]] · [[WPA2]] · [[WPA3]] · [[TKIP]] · [[CCMP]] · [[AES]] · [[802.11i]] · [[Initialization Vector]] · [[Pre-Shared Key]] · [[WLAN Security]]

---
*Source: VIRGIL knowledge base — 2026-05-07*