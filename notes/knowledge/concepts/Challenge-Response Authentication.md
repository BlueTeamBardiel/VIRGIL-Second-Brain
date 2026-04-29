# Challenge-Response Authentication

## What it is
Like a bouncer who shouts a random word and only lets you in if you shout back the correct rhyme — one that changes every night — challenge-response authentication proves identity through a dynamic puzzle only the legitimate party can solve. The server sends a random value (the challenge), the client transforms it using a shared secret or private key (producing the response), and the server verifies the result. Critically, the actual secret is never transmitted across the wire.

## Why it matters
In 2017, attackers exploiting NTLM relay attacks captured Windows challenge-response exchanges and replayed them to authenticate to other machines on the same network — no password cracking required. Because the challenge was reused or poorly validated, the attacker's response was accepted as legitimate. Proper challenge-response implementations use nonces (numbers used once) to make each exchange unique and replay-proof.

## Key facts
- **CHAP (Challenge Handshake Authentication Protocol)** uses three-way challenge-response and re-authenticates periodically during a session — unlike PAP, which sends plaintext passwords
- The challenge must be **cryptographically random and unique per session**; predictable challenges enable precomputation attacks
- **NTLM** (NT LAN Manager) is a Windows challenge-response protocol; NTLMv1 is broken, NTLMv2 adds client nonces for mutual protection
- **Zero-knowledge proofs** are an advanced form of challenge-response where the prover demonstrates knowledge of a secret without revealing any information about it
- Challenge-response is the mechanism behind **FIDO2/WebAuthn**: the server challenges the authenticator, which signs the challenge with its private key

## Related concepts
[[CHAP Authentication]] [[NTLM and Pass-the-Hash]] [[Nonce and Replay Attacks]] [[Zero-Knowledge Proof]] [[Multi-Factor Authentication]]