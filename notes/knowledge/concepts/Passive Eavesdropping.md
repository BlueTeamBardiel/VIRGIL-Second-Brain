# Passive Eavesdropping

## What it is
Like a stranger reading your newspaper over your shoulder on the subway — they touch nothing, change nothing, yet walk away informed. Passive eavesdropping is the interception and capture of network traffic without injecting, modifying, or disrupting any data in transit. Because no packets are altered and no connections are initiated, the attacker leaves virtually no footprint on the target systems.

## Why it matters
In 2014, researchers demonstrated that unencrypted hotel Wi-Fi could be silently monitored using a $35 device running packet-capture software, exposing guest credentials and session cookies with zero interaction with the victims. This illustrates why WPA3's Opportunistic Wireless Encryption (OWE) was developed — to protect even "open" networks by encrypting each session individually, eliminating the value of bulk passive capture.

## Key facts
- Passive attacks are **confidentiality threats**, not integrity or availability threats — they read data but never change it
- Tools like **Wireshark** and **tcpdump** are the canonical instruments for passive capture; in hostile hands, the same tools become sniffers
- **Promiscuous mode** must be enabled on a NIC to capture traffic not addressed to that interface; on switched networks, an attacker needs a **SPAN/mirror port** or ARP spoofing to see others' traffic
- Passive eavesdropping is essentially **undetectable** without physical inspection of cable taps or anomaly detection on switch port statistics
- **TLS/HTTPS, SSH, and WPA3** are the primary countermeasures — encryption renders captured ciphertext useless without the session keys (see: forward secrecy)

## Related concepts
[[Man-in-the-Middle Attack]] [[Packet Sniffing]] [[Transport Layer Security]] [[ARP Spoofing]] [[Promiscuous Mode]]