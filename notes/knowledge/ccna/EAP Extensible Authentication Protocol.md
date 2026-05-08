# EAP Extensible Authentication Protocol

## What it is

In Subnautica, your PDA doesn't decide *how* to scan things — it just provides the framework. Scan a Peeper, you get biological data. Scan a Warper, you get fragment analysis. Scan an Architect artifact, you get something else entirely. The PDA is the wrapper; the scan logic depends on what you're looking at. That's exactly what EAP does — it's a container that carries whatever authentication method you've chosen, without caring about the method itself.

**EAP** is an authentication *framework* (RFC 3748) that defines message formats and a request/response exchange, while delegating the actual credential verification to pluggable methods.

## Why it matters

Without a framework, every new auth scheme would need a new protocol stack. EAP lets you swap certificates for passwords for tokens without rewriting [[802.1X]]. Pick the wrong method and you get [[LEAP]] — cracked in minutes by `asleap` since 2004. Pick correctly and you get [[EAP-TLS]], which is still considered gold-standard in 2026. Exam angle: Cisco wants you to know EAP runs *inside* [[802.1X]], and that 802.1X is the port-based access control mechanism, not the authentication itself.

## Key facts

### The three roles

| Role | Subnautica equivalent | Real function |
|---|---|---|
| **Supplicant** | You, holding the scanner | Client requesting access ([[wpa_supplicant]], Windows native client) |
| **Authenticator** | The airlock door — gates access, doesn't verify | Switch or [[WLC]] that forwards EAP messages |
| **Authentication Server** | The PDA database deciding what's valid | [[RADIUS]] server, usually [[Cisco ISE]] or FreeRADIUS |

The authenticator is deliberately dumb. It relays EAP frames between supplicant and AS. This is why you configure RADIUS on the switch but not the actual user database.

### EAPoL — EAP over LAN

[[EAPoL]] is the encapsulation that carries EAP frames across the wired or wireless segment between supplicant and authenticator. EtherType **0x888E**.

EAPoL frame types:
- **EAPoL-Start** — supplicant announces itself
- **EAPoL-Key** — used for [[4-way handshake]] in [[WPA2]]/[[WPA3]]
- **EAPoL-Logoff** — graceful disconnect
- **EAP-Packet** — carries the actual EAP method exchange

Between authenticator and AS, EAP is wrapped in [[RADIUS]] attributes (UDP 1812) instead of EAPoL.

### Common EAP methods

| Method | Credentials | Tunnel | Verdict |
|---|---|---|---|
| **[[EAP-TLS]]** | Client + server certs | TLS | Strongest. PKI overhead is the cost. |
| **[[PEAP]]** | Server cert + inner password (MSCHAPv2) | TLS | Most common in Microsoft shops |
| **[[EAP-FAST]]** | PAC (Protected Access Credential) | TLS | Cisco-developed, replaced LEAP |
| **[[LEAP]]** | Username/password, MSCHAPv1 | None | Dead. Do not deploy. Cisco-proprietary, broken 2004. |
| **[[EAP-TTLS]]** | Server cert + arbitrary inner method | TLS | Common outside Microsoft world |

### Sample exchange (simplified)

```
Supplicant            Authenticator           AS (RADIUS)
    |--EAPoL-Start------->|                      |
    |<--EAP-Request/Id----|                      |
    |--EAP-Response/Id--->|--RADIUS Access-Req-->|
    |                     |<-RADIUS Access-Chal--|
    |<--EAP-Request-------|                      |
    |       (method-specific exchange)           |
    |--EAP-Response------>|--RADIUS Access-Req-->|
    |                     |<-RADIUS Access-Accept|
    |<--EAP-Success-------|                      |
```

### Switch config (IOS, for context)

```
aaa new-model
aaa authentication dot1x default group radius
dot1x system-auth-control
!
interface Gi0/1
 switchport mode access
 authentication port-control auto
 dot1x pae authenticator
```

The switch never sees the password. It shuttles opaque EAP blobs.

## Related concepts

[[802.1X]] · [[RADIUS]] · [[WPA2-Enterprise]] · [[WPA3]] · [[4-way handshake]] · [[Cisco ISE]] · [[PKI]] · [[MAB]] · [[AAA]]

---
*Source: VIRGIL knowledge base — 2026-05-07*