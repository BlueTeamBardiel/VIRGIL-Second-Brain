# VPN — Virtual Private Network

## What it is

In **The Legend of Zelda: Ocarina of Time**, Link plays the Prelude of Light and the warp beam yanks him from anywhere on the overworld straight into the Temple of Time — bypassing Hyrule Field, the guards, the Stalfos, the entire hostile map in between. The warp song is a private channel. Ganon's forces can't see Link traverse it, can't intercept it, can't follow it. He steps out inside the temple as if he'd always been there.

That's exactly what a VPN does — it builds a private, encrypted tunnel across hostile network terrain so the endpoint behaves as if it's sitting inside the trusted network.

**Technical definition:** A Virtual Private Network is a point-to-point or client-to-network technology that establishes an authenticated, encrypted tunnel over an untrusted transport (usually the public internet), making remote systems addressable as if they were on the internal LAN. Modern enterprise VPNs ride on **IPsec** (layer 3, AH/ESP, IKEv2 for key exchange) or **TLS/SSL** (layer 4–7, browser-friendly, NAT-friendly). Increasingly, organizations are replacing always-on VPN concentrators with [[Zero Trust]] [[SASE]] architectures that authenticate per-session instead of per-tunnel.

## Why it matters

VPNs are CS0-003 Objective 1.1 because every SOC analyst inherits VPN logs on day one, and every IR engagement has to answer one question fast: *was the inbound session a legitimate remote worker or an attacker reusing stolen credentials?* The VPN concentrator is the highest-value chokepoint and the highest-value blind spot in the architecture. It's where credential stuffing lands, where MFA fatigue gets exploited, where ransomware crews like Conti and LockBit historically walked in through unpatched Pulse Secure, Fortinet SSL-VPN, and Citrix appliances.

Career relevance: if you can't read a VPN log, correlate the geolocation against the user's expected location, and spot the impossible-traveler pattern, you can't do L1 SOC. This is table stakes.

## Key facts

### Protocols you must know cold

| Protocol | Layer | Port | Notes |
|---|---|---|---|
| **IPsec (IKEv2)** | L3 | UDP 500, UDP 4500 (NAT-T), ESP proto 50 | Site-to-site standard. AH = integrity only, ESP = integrity + encryption. |
| **SSL/TLS VPN** | L4–7 | TCP 443 | Client-to-site standard. Traverses NAT and most firewalls. |
| **WireGuard** | L3 | UDP 51820 (default) | Modern, small codebase, ChaCha20/Poly1305. Faster handshake than IPsec. |
| **OpenVPN** | L4 | UDP 1194 or TCP 443 | Open-source TLS-based, common in SMB. |
| **L2TP/IPsec** | L2+L3 | UDP 1701 + IPsec | Legacy. L2TP alone has no encryption. |
| **PPTP** | L2 | TCP 1723 + GRE | Dead. MS-CHAPv2 broken. Flag if you see it. |

### Topologies

- **Site-to-site** — two gateways tunnel between offices. Persistent, IPsec, no user interaction. Failure mode: misconfigured Phase 1/Phase 2 mismatches, expired pre-shared keys.
- **Client-to-site (remote access)** — user laptop connects to concentrator. TLS or IPsec. Authenticates via [[Identity and Access Management]], ideally with [[Multifactor Authentication]] and certificate from internal [[Public Key Infrastructure]].
- **Full tunnel** — all client traffic routes through the corporate edge. Good for DLP, [[Data Loss Prevention]] inspection, and forcing traffic through the [[Cloud Access Security Broker]]. Bad for bandwidth.
- **Split tunnel** — only corporate-subnet traffic goes through the VPN; Netflix and Spotify go direct. Good for performance. Bad for visibility — the SOC can't see what the laptop touches off-tunnel. This is the perpetual war between Network and Security teams.

### The IPsec phases (CompTIA loves this)

1. **IKE Phase 1** — negotiate the secure channel itself. Main mode (6 packets, identity protected) or Aggressive mode (3 packets, identity exposed — avoid). Result: ISAKMP SA.
2. **IKE Phase 2** — negotiate the actual IPsec SAs that will carry user traffic. Result: ESP/AH SAs with their own keys, refreshed on a timer (PFS via Diffie-Hellman if configured).

If Phase 1 succeeds and Phase 2 fails, the tunnel "comes up" but no traffic passes. Classic ticket: *"VPN says connected but nothing works."* That's a Phase 2 mismatch on encryption/hash/PFS group.

### What the VPN concentrator logs (and what you ingest into SIEM)

[[Log Ingestion]] from the VPN is non-negotiable. Pull at minimum:

- Username, source IP, source geolocation, ASN
- Authentication result (success/fail), MFA challenge result
- Assigned internal IP from the VPN pool
- Session start, session end, bytes in/out
- Posture check result (if NAC is integrated)
- Certificate serial used (if cert-based auth)

[[Time Synchronization]] via NTP across the concentrator, the SIEM, the IdP, and the endpoint matters enormously here — VPN correlation across systems is timestamp-driven, and a 90-second drift will make a session look like two separate events or hide a credential-reuse window.

### Authentication stack

Modern VPN auth is layered:

- **Something you have** — device certificate from internal [[PKI]], or a hardware token
- **Something you know** — password (or [[Passwordless]] via WebAuthn/FIDO2 — the future)
- **MFA** — push, TOTP, FIDO2. Push fatigue is the #1 bypass in 2024–2026.
- **[[SSO]] / [[Federation]]** — VPN auths against SAML/OIDC IdP (Okta, Entra ID, Ping). One identity, one MFA, one audit trail.
- **Posture check** — is the endpoint patched, AV running, disk encrypted? If no, quarantine VLAN.

### Where VPN fits in modern architecture

Traditional VPN was a **moat-and-castle** assumption: once you're through the tunnel, you're trusted, full LAN access. That model is dead in 2026. Replace with:

- **[[Zero Trust]] Network Access (ZTNA)** — per-application access, not per-network. Every request re-authenticated. Identity is the perimeter, not the IP.
- **[[SASE]] (Secure Access Service Edge)** — VPN + CASB + SWG + ZTNA + FWaaS delivered from cloud PoPs. User connects to the nearest PoP; policy is enforced there.
- **Microsegmentation** — even inside the VPN, lateral movement is blocked by host-level policy. Pairs with [[Network Segmentation]] and [[Software-Defined Networking]] east-west inspection.

### CompTIA exam traps

> **CompTIA exam trap:** VPN ≠ encrypted = secure. A VPN encrypts data in transit between the client and the concentrator. It does NOT encrypt data at the destination, does NOT inspect for malware in the tunnel by default, and does NOT prevent a compromised endpoint from being the attacker's foothold inside your LAN. CompTIA loves the answer that says *"VPN provides confidentiality of the tunnel, not endpoint integrity."*

> **CompTIA exam trap:** Split tunnel vs full tunnel. If the scenario emphasizes **[[DLP]] inspection, CASB enforcement, or visibility into user web traffic** — the answer is full tunnel. If the scenario emphasizes **bandwidth, latency, or remote-worker performance** — the answer is split tunnel. The trap is picking the one that "sounds more secure" when the question is actually about a business constraint.

> **CompTIA exam trap:** AH vs ESP. **AH (Authentication Header)** provides integrity and authentication but NO encryption. **ESP (Encapsulating Security Payload)** provides integrity, authentication, AND encryption. If the question says "confidentiality required," the answer is ESP. AH-only is a niche compliance scenario.

> **CompTIA exam trap:** PPTP and L2TP-alone are not acceptable answers in 2026. PPTP uses MS-CHAPv2 which is cryptographically broken. L2TP without IPsec has no encryption at all. If CompTIA offers these alongside IKEv2 or TLS, they're distractors.

> **CompTIA exam trap:** Site-to-site vs client-to-site. Two offices linking permanently = site-to-site. A remote employee's laptop = client-to-site (also called remote access VPN). CompTIA will swap these in scenarios about "branch office connectivity."

### VPN as attack surface — what actually goes wrong

The VPN appliance is one of the most attacked devices on the internet. Known patterns:

- **Unpatched edge devices** — Pulse Secure CVE-2019-11510, Fortinet CVE-2018-13379, Citrix CVE-2019-19781, Ivanti Connect Secure CVE-2024-21887. Pre-auth RCE on internet-facing concentrators. Ransomware crews scan for these daily.
- **Credential stuffing without MFA** — leaked password from another breach, sprayed against the VPN portal. If MFA isn't enforced or has a bypass for "legacy clients," you're owned.
- **MFA fatigue / push bombing** — attacker has the password, spams push notifications until the user taps Approve to make it stop. Lapsus$ and Scattered Spider playbook.
- **Session hijacking via stolen cookies** — infostealer (Lumma, Redline) grabs the VPN cookie from the browser, replays it from attacker infrastructure. Bypasses MFA entirely.
- **Misconfigured split tunnel** leaking internal DNS to the public resolver — recon gift to an attacker watching DNS.

## SOC reality

- The 3am alert is "impossible traveler" — same user, two VPN logins, geographically incompatible. Your first action is not to disable the account. It's to pull both session logs, check the ASN (is the second one a known commercial VPN egress?), and confirm with the user via an out-of-band channel. About 60% of impossible-traveler alerts are legitimate users on a commercial VPN or roaming SIM. The other 40% will ruin your morning.
- The CISO asks three questions during a suspected VPN compromise: *"Is MFA enforced on every account including service accounts? When was the last firmware patch? Do we have full session logs to SIEM or just connect/disconnect?"* Have the answers before they ask.
- Never promise leadership the VPN is "secure because it's encrypted." The tunnel is encrypted. The endpoint on the other end is a Windows laptop in someone's kitchen that may or may not be patched. *The crypto is the easy part; the endpoint is where you die.*
- L1 triage on a VPN auth-failure spike: is it one user (forgot password, no big deal), one source IP hitting many users (password spray, escalate to L2 immediately), or many sources hitting one user (targeted, escalate to IR)? The pattern is the answer.
- The handoff: VPN compromise that resulted in internal access → IR team owns it, identity team rotates credentials, network team pulls the session's internal NetFlow, legal gets notified if PII or CHD touched the session. Don't sit on it.

*The VPN tunnel is Link's warp song — it gets the endpoint past the hostile terrain. It does not check whether Link is still Link when he arrives.*

## Related concepts

[[Zero Trust]] · [[SASE]] · [[Cloud Access Security Broker]] · [[Network Segmentation]] · [[Software-Defined Networking]] · [[Public Key Infrastructure]] · [[Identity and Access Management]] · [[Multifactor Authentication]] · [[Single Sign-On]] · [[Federation]] · [[Passwordless]] · [[Privileged Access Management]] · [[Data Loss Prevention]] · [[Log Ingestion]] · [[Time Synchronization]] · [[System Hardening]] · [[Encryption]]

*Source: VIRGIL knowledge base — 2026-05-11*