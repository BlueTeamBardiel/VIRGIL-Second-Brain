# Cyfral

## What it is
Like a simple combination lock where the "secret" is just the order you press buttons, Cyfral is a basic electronic key system used widely in post-Soviet apartment buildings, where a touch-based iButton-style contact transmits a fixed numeric code to unlock a door. It is a Dallas/Maxim 1-Wire protocol-based access control system that stores a static, unencrypted identifier in a small metal token (the key), which a reader compares against a stored list to grant entry.

## Why it matters
Because the code is static and transmitted in cleartext over the 1-Wire interface, an attacker with a simple Arduino-based reader (costing under $5) can capture and clone a resident's key in seconds with physical proximity — a textbook credential cloning attack requiring no cryptographic knowledge whatsoever. Security researchers and locksmiths in Eastern Europe regularly demonstrate this, highlighting how legacy physical access control systems create exploitable gaps even in modern threat models.

## Key facts
- Cyfral keys transmit a **fixed, unencrypted 8-byte identifier** — there is no challenge-response or cryptographic handshake
- The underlying **Dallas 1-Wire protocol** operates at low voltage over a single data line, making interception trivially easy with basic hardware
- Cloning attacks require only a **blank RW1990 or TM08 writable iButton** and an inexpensive reader/writer device
- Cyfral is distinct from **Metakom**, another Russian iButton-style system, though both share the same fundamental static-code vulnerability
- This system represents **Security through Obscurity** failure: the "security" relied on physical possession, not cryptographic proof of identity

## Related concepts
[[iButton]] [[RFID Cloning]] [[Physical Access Control Systems]] [[Dallas 1-Wire Protocol]] [[Replay Attack]]