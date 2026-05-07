# IEEE 802.1X

## What it is
Think of it as a bouncer at a club door who checks your ID *before* you ever set foot on the dance floor — not after you've already grabbed a drink. IEEE 802.1X is a port-based Network Access Control (NAC) standard that enforces authentication at the physical or wireless network edge, blocking all traffic except authentication exchanges until a supplicant proves its identity to an authentication server.

## Why it matters
Without 802.1X, an attacker who physically plugs a rogue laptop into an open Ethernet port in a conference room gains full network access immediately. With 802.1X enforced, that port stays in an unauthorized VLAN, passing only EAP traffic to a RADIUS server — the attacker gets nothing until they present valid credentials or a trusted certificate, effectively neutralizing "plug-and-pivot" physical intrusion scenarios.

## Key facts
- **Three-party architecture:** Supplicant (client device) → Authenticator (switch or AP) → Authentication Server (RADIUS/TACACS+). The authenticator never evaluates credentials itself.
- **EAP is the payload:** 802.1X uses Extensible Authentication Protocol (EAP) over LAN (EAPOL); the specific EAP method (EAP-TLS, PEAP, EAP-TTLS) determines actual credential security.
- **EAP-TLS is the gold standard:** Requires mutual certificate authentication — both client and server present certificates, eliminating credential-stuffing attacks.
- **Controlled vs. uncontrolled ports:** The authenticator maintains two logical ports per physical port; the uncontrolled port passes only EAP traffic pre-authentication, the controlled port opens fully post-authentication.
- **VLAN assignment:** A RADIUS server can dynamically assign a supplicant to a specific VLAN upon successful authentication, enabling role-based network segmentation.

## Related concepts
[[RADIUS]] [[Extensible Authentication Protocol (EAP)]] [[Network Access Control (NAC)]] [[VLAN Segmentation]] [[Certificate-Based Authentication]]