# Session Keys

## What it is
Like a disposable hotel keycard that works only for your stay and is deactivated at checkout, a session key is a temporary symmetric encryption key generated fresh for a single communication session. It is negotiated between parties during a handshake (often using asymmetric cryptography) and discarded once the session ends, meaning it never persists long enough to be valuable if stolen.

## Why it matters
Session keys are the reason that compromising a server's long-term private key doesn't automatically decrypt years of recorded traffic — a property called **Perfect Forward Secrecy (PFS)**. In 2011, when DigiNotar's certificates were compromised, attackers could perform man-in-the-middle attacks on *live* sessions, but past sessions encrypted with ephemeral session keys remained protected. Without PFS (e.g., static RSA key exchange), one stolen private key decrypts everything retroactively.

## Key facts
- Session keys are **symmetric** (e.g., AES-256), making bulk encryption fast after the slow asymmetric handshake establishes them
- In TLS 1.3, session keys are derived using **ECDHE (Elliptic Curve Diffie-Hellman Ephemeral)**, which mandates PFS by design — static RSA key exchange was removed entirely
- Key lifetime is deliberately short: a session key may live seconds to hours, drastically shrinking the attacker's window of opportunity
- Session keys are derived from a **pre-master secret** combined with random nonces from both client and server, ensuring uniqueness even if the same parties reconnect
- Replay attacks are mitigated because each session produces a unique key; a captured ciphertext cannot be decrypted in a new session

## Related concepts
[[Perfect Forward Secrecy]] [[TLS Handshake]] [[Diffie-Hellman Key Exchange]] [[Symmetric Encryption]] [[Key Exchange Algorithms]]