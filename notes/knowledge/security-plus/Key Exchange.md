# Key Exchange

## What it is

In Madden, before the snap, the QB and his receiver run a hot route — the QB taps it in pre-play, the receiver sees it on his screen, and now they both know the route is a slant. The defense saw the same field but never saw the menu. That's exactly what key exchange does — two parties agree on a shared secret while everyone watching the wire sees nothing useful.

**Key exchange** is the cryptographic process by which two parties establish a shared symmetric key over an untrusted channel, enabling subsequent encrypted communication without ever transmitting the key itself in usable form.

## Why it matters

Symmetric encryption is fast but useless if you can't get the key to the other side without an attacker grabbing it. Break the exchange and you break everything that follows — TLS sessions, VPN tunnels, signed transactions, the lot. SY0-701 Objective 1.4 lists **key exchange** explicitly under "use of cryptographic solutions," and the exam trap is conflating **in-band** with **out-of-band** exchange, or mistaking [[Diffie-Hellman]] (key agreement) for [[RSA]] (key transport). They are not the same mechanism.

## Key facts

### The two flavors

| Method | How it works | Example |
|---|---|---|
| **Out-of-band** | Key delivered via a separate channel (courier, phone, USB) | Pre-shared keys handed off in person |
| **In-band** | Key established over the same untrusted channel using asymmetric crypto | TLS handshake over the public internet |

### Asymmetric-assisted exchange

The trick: use slow [[asymmetric-encryption]] once to bootstrap a fast [[symmetric-encryption]] session key.

- **Key transport** — One side generates the symmetric key, encrypts it with the other's public key, sends it. Classic [[RSA]] key exchange. Deprecated in TLS 1.3.
- **Key agreement** — Both sides contribute math; neither transmits the key. Output is derived, not sent. This is [[Diffie-Hellman]] and its variants.

### Diffie-Hellman variants

| Variant | Property |
|---|---|
| **DH** | Classic, uses discrete logarithm over large primes |
| **DHE** (Ephemeral) | New keypair every session — provides [[perfect-forward-secrecy]] |
| **ECDH** | Elliptic curve version — smaller keys, same strength |
| **ECDHE** | Ephemeral elliptic curve — current TLS 1.3 default |

### Perfect Forward Secrecy

[[perfect-forward-secrecy]] (**PFS**) means compromising a long-term private key does not compromise past session keys. Achieved via ephemeral exchanges (DHE, ECDHE). Without it, an attacker who records ciphertext today and steals the server's key in 2029 decrypts everything retroactively.

### What CompTIA wants you to know

- Key exchange solves the **symmetric key distribution problem**.
- [[Diffie-Hellman]] allows two parties to derive a shared secret over a public channel — eavesdroppers cannot compute it.
- **Ephemeral** = fresh keys per session = forward secrecy.
- Out-of-band exchange avoids the network entirely but doesn't scale.
- A [[man-in-the-middle]] attack defeats unauthenticated DH — which is why exchanges are paired with [[digital-signatures]] or [[certificates]] to authenticate the participants.

### What breaks when it goes wrong

- **Unauthenticated DH** → MITM substitutes its own keys with both ends.
- **Static keys, no PFS** → mass retroactive decryption when the private key leaks.
- **Weak DH parameters** (small primes, e.g., Logjam attack) → exchange becomes computable.
- **Reused ephemeral keys** → no longer ephemeral, no longer secret.

## Related concepts

[[Diffie-Hellman]] · [[perfect-forward-secrecy]] · [[asymmetric-encryption]] · [[symmetric-encryption]] · [[RSA]] · [[TLS]] · [[man-in-the-middle]] · [[digital-signatures]] · [[certificates]] · [[PKI]]

---
*Source: VIRGIL knowledge base — 2026-05-08*