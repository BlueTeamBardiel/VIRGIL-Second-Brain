# Unprotected Management Frames

## What it is
Imagine a building's intercom system where anyone with a cheap radio can broadcast "EVACUATE NOW" and every door automatically unlocks — no badge, no verification. That's essentially Wi-Fi without protected management frames: 802.11 management frames (like deauthentication and disassociation packets) are sent in cleartext with no cryptographic authentication, allowing any attacker within radio range to forge them.

## Why it matters
An attacker running `aireplay-ng` can flood a target client with spoofed deauthentication frames, forcibly disconnecting them from the access point in a denial-of-service attack — or more dangerously, knocking them off long enough to capture the WPA2 four-way handshake during reconnection for offline cracking. IEEE 802.11w (Protected Management Frames) was specifically standardized to counter this by cryptographically signing management frames so forgeries are rejected.

## Key facts
- **802.11w** introduced Protected Management Frames (PMF); it became **mandatory in WPA3** and optional-but-recommended in WPA2
- Deauthentication and disassociation attacks are categorized as **Layer 2 denial-of-service attacks** and require no prior authentication to execute
- PMF uses **CCMP encryption** to protect unicast management frames and introduces the **SA Query procedure** to detect spoofed session teardowns
- Tools like **mdk3, mdk4, and aireplay-ng** are commonly used to exploit unprotected management frames in penetration testing scenarios
- On the Security+ exam, unprotected management frames are associated with **evil twin attacks, deauth floods**, and the general category of **wireless disassociation attacks**

## Related concepts
[[WPA3]] [[Deauthentication Attack]] [[Evil Twin Attack]] [[802.11 Wireless Security]] [[Denial of Service]]