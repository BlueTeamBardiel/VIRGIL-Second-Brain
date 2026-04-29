# WPA3-PSK

## What it is
Think of WPA2-PSK as a deadbolt where everyone in the building uses the same key copy — if one copy leaks, an attacker can decrypt *every* conversation they've ever recorded. WPA3-PSK replaces this with SAE (Simultaneous Authentication of Equals), a handshake protocol derived from the Dragonfly key exchange where each session generates a unique cryptographic secret, even if both sides share the same password. This means capturing network traffic is worthless to an attacker even if they later obtain the pre-shared key.

## Why it matters
In WPA2 networks, an attacker capturing a four-way handshake can run it through a dictionary attack offline — tools like Hashcat can test billions of password guesses per second against the captured hash. WPA3-SAE eliminates this entirely through **forward secrecy**: each authentication derives a fresh Pairwise Master Key, so cracking the password post-capture yields nothing usable. This directly nullifies the classic "capture-and-crack" attack that made weak WPA2 passwords catastrophic.

## Key facts
- **SAE replaces PSK's four-way handshake** with a zero-knowledge proof-style exchange — the password is never transmitted or derivable from captured traffic
- **Forward secrecy** is the headline improvement: past session traffic cannot be decrypted even with full knowledge of the network password
- **Transition mode** allows WPA2 and WPA3 clients on the same network, but introduces downgrade attack risk where adversaries force clients to negotiate WPA2
- **Dragonblood vulnerabilities** (CVE-2019-9494) revealed side-channel and denial-of-service flaws in early SAE implementations — WPA3 is not magically bulletproof
- **Minimum encryption**: WPA3-Personal mandates 128-bit AES; WPA3-Enterprise requires 192-bit AES-GCM in its enhanced mode

## Related concepts
[[WPA2-PSK]] [[SAE (Simultaneous Authentication of Equals)]] [[Forward Secrecy]] [[Evil Twin Attack]] [[PMKID Attack]]