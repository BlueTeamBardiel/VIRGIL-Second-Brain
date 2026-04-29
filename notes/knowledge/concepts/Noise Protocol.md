# Noise Protocol

## What it is
Think of it like a choreographed handshake dance where both parties agree in advance on *exactly* which moves will happen and in what order — no improvisation, no surprise steps. Noise Protocol is a framework for building cryptographic handshake protocols, defining a set of composable "patterns" (like NN, NK, XX) that specify how Diffie-Hellman key exchanges, encryption, and authentication are sequenced between two parties. It strips the complexity of TLS down to its mathematical skeleton, letting developers construct purpose-built, minimal secure channels.

## Why it matters
WhatsApp's end-to-end encryption (built on the Signal Protocol, which uses Noise as its handshake layer) relies on Noise's `XX` pattern to mutually authenticate both sender and receiver before any messages flow. Without this formal structure, a man-in-the-middle attacker could substitute their own public key during the handshake, silently intercepting all traffic — a classical MITM attack that Noise's authentication patterns are specifically designed to prevent.

## Key facts
- Noise defines **handshake patterns** using tokens like `e`, `s`, `ee`, `es`, `se`, `ss` representing static/ephemeral key exchanges
- The **`XX` pattern** provides mutual authentication — both parties prove identity; `NK` means the initiator knows the responder's static key in advance
- Noise uses **only modern primitives**: Curve25519, ChaCha20-Poly1305, and BLAKE2 are the reference suite
- Noise provides **forward secrecy** through ephemeral Diffie-Hellman; compromise of long-term keys doesn't expose past sessions
- Used in production by **WireGuard VPN**, **WhatsApp**, and **Lightning Network** (Bitcoin payment channels)

## Related concepts
[[Diffie-Hellman Key Exchange]] [[Perfect Forward Secrecy]] [[Signal Protocol]] [[WireGuard]] [[Man-in-the-Middle Attack]]