# KRACK Attack

## What it is
Imagine a locksmith who discovered that every deadbolt in the world resets to an unlocked state if you knock on the door exactly three times during installation — that's KRACK. Key Reinstallation Attack (KRACK) is a vulnerability in the WPA2 four-way handshake that forces nonce reuse by replaying cryptographic handshake messages, allowing an attacker to decrypt, replay, and potentially forge wireless traffic without knowing the Wi-Fi password.

## Why it matters
A coffee shop attacker positioned between a victim's laptop and the access point could replay handshake Message 3, forcing the client to reinstall an already-used encryption key and reset its nonce counter to zero. This nonce reuse breaks the AES-CCMP encryption guaranteeing confidentiality, potentially exposing HTTP traffic, credentials, or session cookies transmitted over that connection — even on a "secure" WPA2 network.

## Key facts
- Discovered by Mathy Vanhoef and published in 2017 (CVE-2017-13077 through CVE-2017-13088)
- Exploits the WPA2 **four-way handshake** — specifically, the retransmission of Message 3 causes key reinstallation and nonce reset
- Affects the **client side**, not the access point; patching client devices (phones, laptops) is the primary remediation
- Using **HTTPS/TLS** as a compensating control limits exposure even if layer-2 encryption is broken
- Linux and Android were especially vulnerable because `wpa_supplicant` would reinstall an **all-zero encryption key** in some implementations

## Related concepts
[[WPA2]] [[Four-Way Handshake]] [[Nonce Reuse]] [[AES-CCMP]] [[Man-in-the-Middle Attack]]