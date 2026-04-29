# Eavesdropping

## What it is
Like a stranger pressing their ear against a café wall to overhear your business conversation, eavesdropping is the passive interception of network traffic without altering it. An attacker silently captures data in transit — packets, credentials, session tokens — without the communicating parties ever knowing. Because nothing is modified, it leaves almost no trace and bypasses integrity-focused defenses entirely.

## Why it matters
In 2017, researchers demonstrated that WPA2-protected Wi-Fi was vulnerable to the KRACK attack, allowing an attacker within radio range to force nonce reuse and decrypt traffic that users believed was encrypted. A coffee shop attacker using a passive wireless card in monitor mode could silently harvest unencrypted HTTP credentials, VoIP audio, or session cookies from dozens of victims simultaneously. Deploying TLS/HTTPS and VPNs remains the primary defense, since encryption renders captured traffic unreadable even if intercepted.

## Key facts
- Eavesdropping is a **passive attack** — it preserves confidentiality as the threat (no integrity or availability violation), making detection extremely difficult
- Tools like **Wireshark** and **tcpdump** are legitimate packet analyzers that become eavesdropping instruments when used without authorization
- **Promiscuous mode** on a NIC allows a host to capture all packets on a network segment, not just those addressed to it
- On switched networks, attackers must first perform **ARP poisoning or port mirroring** to redirect traffic before passive capture is possible
- **TLS 1.3** eliminates weak cipher suites and enforces forward secrecy (ECDHE), ensuring that capturing traffic today can't be decrypted later even if the private key is stolen

## Related concepts
[[Man-in-the-Middle Attack]] [[Packet Sniffing]] [[ARP Poisoning]] [[SSL Stripping]] [[Wireless Security]]