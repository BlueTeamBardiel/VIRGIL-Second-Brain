# Four-Way Handshake

## What it is
Like two strangers proving they both know the same secret password without ever saying it aloud, the Four-Way Handshake is a mutual authentication and key exchange process used in WPA2/WPA3 Wi-Fi networks. It occurs after a client associates with an access point, using the Pre-Shared Key (PSK) to derive a fresh session encryption key (PTK) without transmitting the PSK itself.

## Why it matters
The KRACK (Key Reinstallation Attack) vulnerability, disclosed in 2017, exploited the Four-Way Handshake by forcing nonce reuse during retransmission of message 3, allowing an attacker within Wi-Fi range to decrypt traffic without knowing the password. This attack affected virtually every WPA2-capable device and triggered emergency patches across operating systems — demonstrating that even well-designed handshakes fail when implementation details are exploited.

## Key facts
- The four messages exchange two nonces (ANonce from AP, SNonce from client) to derive the **Pairwise Transient Key (PTK)**, which encrypts unicast traffic
- The PTK is derived from: PMK + ANonce + SNonce + both MAC addresses — meaning each session gets a unique key even with the same password
- Message 4 confirms the client has installed the PTK; only then does the AP install its copy
- The **GTK (Group Temporal Key)**, for broadcast/multicast traffic, is delivered encrypted inside Message 3
- Capturing the Four-Way Handshake (via deauthentication attacks) enables **offline dictionary attacks** against the PSK — the primary method used by tools like Hashcat with `hccapx` capture files

## Related concepts
[[WPA2]] [[Pre-Shared Key (PSK)]] [[Deauthentication Attack]] [[KRACK Attack]] [[PMK (Pairwise Master Key)]]