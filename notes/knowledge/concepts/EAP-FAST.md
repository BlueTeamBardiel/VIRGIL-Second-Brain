# EAP-FAST

## What it is
Like a temporary visitor badge issued at the front desk that lets you skip the full background check on repeat visits, EAP-FAST uses a Protected Access Credential (PAC) to streamline re-authentication without requiring a full certificate infrastructure. It is an EAP method developed by Cisco as a replacement for LEAP, using a two-phase tunnel to protect credentials during 802.1X wireless authentication. Phase 0 provisions the PAC, Phase 1 establishes a TLS tunnel using it, and Phase 2 performs the actual credential verification inside that tunnel.

## Why it matters
Organizations that couldn't deploy a full PKI (needed for EAP-TLS or PEAP) adopted EAP-FAST as a "good enough" middle ground — but the PAC provisioning phase, if done in-band without authentication (anonymous PAC provisioning), creates a vulnerability. An attacker running a rogue access point can intercept anonymous PAC provisioning and conduct an offline dictionary attack against the captured credentials. This is why authenticated or out-of-band PAC provisioning is the secure deployment requirement.

## Key facts
- Developed by Cisco in response to known weaknesses in **LEAP** (which sent credentials with weak MS-CHAPv1)
- Uses a **Protected Access Credential (PAC)** instead of server-side certificates, eliminating the need for a full PKI
- **Three phases**: Phase 0 (PAC provisioning), Phase 1 (TLS tunnel establishment), Phase 2 (inner authentication)
- Anonymous PAC provisioning is a known attack surface — **authenticated PAC provisioning** or manual out-of-band delivery mitigates this
- Defined in **RFC 4851**; supports multiple inner authentication methods including MS-CHAPv2 and GTC

## Related concepts
[[EAP-TLS]] [[PEAP]] [[802.1X]] [[LEAP]] [[Rogue Access Point]]