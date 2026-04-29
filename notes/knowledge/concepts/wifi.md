# wifi

## What it is
Think of WiFi like a conversation shouted across a crowded café — anyone nearby can hear it unless you're whispering in code. WiFi is a wireless networking technology based on the IEEE 802.11 standard family that transmits data over radio frequencies (typically 2.4 GHz or 5 GHz) between devices and access points.

## Why it matters
In a classic evil twin attack, an adversary sets up a rogue access point mimicking a legitimate network (same SSID, stronger signal) to intercept credentials and session tokens from unsuspecting users — a scenario that played out repeatedly in coffee shop breaches before WPA3 gained traction. Defenders counter this using 802.1X certificate-based authentication, which forces mutual verification so clients can't be tricked into trusting a fake AP.

## Key facts
- **WEP** (Wired Equivalent Privacy) is cryptographically broken — RC4 with weak IV reuse means it can be cracked in minutes; never use it
- **WPA2** uses AES-CCMP for encryption; its main vulnerability is the **KRACK attack** (Key Reinstallation Attack), which forces nonce reuse in the 4-way handshake
- **WPA3** introduces Simultaneous Authentication of Equals (SAE), replacing PSK handshakes and eliminating offline dictionary attacks against captured handshakes
- **Deauthentication attacks** exploit the fact that 802.11 management frames are unauthenticated in WPA2 — an attacker can force clients to disconnect and capture the reauthentication handshake
- **War driving** is the practice of scanning for WiFi networks from a moving vehicle to map vulnerable or open APs — a recon technique still relevant in physical penetration testing

## Related concepts
[[WPA3]] [[Evil Twin Attack]] [[802.1X Authentication]] [[Deauthentication Attack]] [[Rogue Access Point]]