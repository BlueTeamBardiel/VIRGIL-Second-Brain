# EAPOL

## What it is
Think of EAPOL as the bouncer's velvet rope at a club entrance — it's the specific protocol that controls the conversation *before* anyone gets let inside the network. EAPOL (Extensible Authentication Protocol over LAN) is the Layer 2 encapsulation method defined in IEEE 802.1X that carries EAP authentication messages between a supplicant (client) and an authenticator (switch or access point) during the network access control handshake.

## Why it matters
In WPA2-Enterprise Wi-Fi cracking, attackers capture the EAPOL 4-way handshake — the specific exchange where the client and AP derive and verify the Pairwise Transient Key (PTK). Tools like `aircrack-ng` and `hcxdumptool` specifically target this handshake capture because it contains enough cryptographic material to perform offline dictionary attacks against the Pre-Shared Key, making EAPOL traffic a high-value interception target on Wi-Fi networks.

## Key facts
- EAPOL operates at **Layer 2 (Data Link)** using EtherType **0x888E**, meaning it requires no IP address — authentication happens before network access is granted
- The **4-way handshake** uses EAPOL-Key frames to establish the PTK between client and AP; capturing all 4 frames is sufficient for offline PSK cracking
- EAPOL defines four message types: **EAP-Packet, EAPOL-Start, EAPOL-Logoff, and EAPOL-Key**
- In 802.1X port-based NAC, the switch port remains in an **unauthorized state** blocking all traffic except EAPOL until authentication succeeds
- EAPOL-Start is sent by the supplicant to trigger authentication; absence of this frame can indicate a **rogue AP** scenario or misconfigured client

## Related concepts
[[802.1X]] [[EAP]] [[WPA2 4-Way Handshake]] [[RADIUS]] [[Network Access Control]]