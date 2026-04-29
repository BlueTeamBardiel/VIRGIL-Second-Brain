# SAE

## What it is
Like a bouncer who checks IDs *before* letting anyone near the VIP section rather than after they're already inside, Simultaneous Authentication of Equals (SAE) replaces the old WPA2 handshake by ensuring neither side can prove identity without the other — eliminating the ability to capture a handshake and crack it offline. SAE is the key exchange mechanism introduced in WPA3 that uses a Dragonfly handshake to establish a shared secret, providing forward secrecy and resistance to offline dictionary attacks.

## Why it matters
Under WPA2-PSK, an attacker running tools like `hcxdumptool` could silently capture the 4-way handshake between a client and access point, walk away, and brute-force the pre-shared key at leisure on a GPU farm. With SAE, even capturing every packet of the exchange yields nothing crack-worthy offline — each authentication produces a unique session key, so yesterday's capture can't expose today's traffic.

## Key facts
- SAE is based on the **Dragonfly Key Exchange** (RFC 7664), which is a zero-knowledge proof variant resistant to passive eavesdropping
- Provides **forward secrecy** — compromise of the long-term password does not decrypt previously captured session traffic
- Replaces the **PSK (Pre-Shared Key) mechanism** in WPA2; both devices prove knowledge of the password without transmitting it
- Vulnerable to **side-channel timing attacks** (CVE-2019-9494, "Dragonblood") if implementations don't use constant-time operations
- Required for **WPA3-Personal** certification; WPA3-Enterprise uses 192-bit Suite B cryptography separately

## Related concepts
[[WPA3]] [[Dragonblood Attack]] [[Forward Secrecy]] [[4-Way Handshake]] [[Dictionary Attack]]