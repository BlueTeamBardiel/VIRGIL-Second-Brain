# IPsec and Site-to-Site VPN

## What it is

In **Overwatch**, when Symmetra drops a Teleporter between two points on the map, allies don't walk the long exposed route through enemy sightlines — they step in one end and pop out the other through a private channel that hostile players can't enter, intercept, or shoot through. That's exactly what IPsec does: it takes packets traveling across hostile public internet and wraps them in cryptographic armor so eavesdroppers see nothing useful and tampering gets caught at the exit.

**IPsec** (Internet Protocol Security) is a suite of protocols that authenticates and encrypts IP packets between two endpoints, typically used to build a [[site-to-site VPN]] tunnel across the public internet between fixed locations like branch offices and HQ.

## Why it matters

Without IPsec, the alternative is paying for private [[MPLS]] circuits at carrier prices — or sending plaintext corporate traffic across the internet, which is the network engineering equivalent of mailing payroll on postcards. A misconfigured [[Phase 1]] proposal or mismatched [[pre-shared key]] means the tunnel never comes up, branch users can't reach internal resources, and you're staring at `QM_IDLE` that never appears in `show crypto isakmp sa`. CCNA exam loves to test the **Phase 1 vs Phase 2** distinction and **AH vs ESP** trivia.

## Key facts

### The Two-Phase Handshake

IPsec uses [[IKE]] (Internet Key Exchange, UDP **500**) to negotiate everything before any user data flows. Think of it as two diplomats meeting in a secure room (Phase 1) to then agree on how to ship cargo (Phase 2).

| Phase | Purpose | Result | Protocol |
|-------|---------|--------|----------|
| **Phase 1** | Build secure management tunnel; authenticate peers; exchange keys via [[Diffie-Hellman]] | **ISAKMP SA** (bidirectional) | [[ISAKMP]] |
| **Phase 2** | Negotiate how to protect actual user data | **IPsec SA** (two unidirectional SAs) | IPsec |

**Phase 1 modes:**
- **Main Mode** — 6 messages, hides peer identities. Default, more secure.
- **Aggressive Mode** — 3 messages, faster but exposes identities.

**Phase 2** uses **Quick Mode** (3 messages) and runs inside the Phase 1 tunnel.

### The Five Phase 1 Parameters (HAGLE)

Both peers must agree on all five or the tunnel dies in negotiation:

| Letter | Parameter | Common Values |
|--------|-----------|---------------|
| **H** | Hash | [[MD5]], [[SHA]] |
| **A** | Authentication | Pre-shared key, [[RSA]] signatures |
| **G** | DH Group | 1, 2, 5, 14, 19, 20, 24 |
| **L** | Lifetime | Default **86400** seconds (24h) |
| **E** | Encryption | [[DES]], [[3DES]], [[AES]] |

### AH vs ESP

| Feature | **AH** (Protocol 51) | **ESP** (Protocol 50) |
|---------|---------------------|----------------------|
| Authentication | Yes (entire packet incl. outer header) | Yes (payload only) |
| Integrity | Yes | Yes |
| **Encryption** | **NO** | **YES** |
| [[NAT]] traversal | Breaks (header is hashed) | Works (with NAT-T, UDP **4500**) |

**ESP is what you actually use.** AH alone is rare in production — authenticating a packet you can't read is rarely the goal.

### Tunnel vs Transport Mode

- **Tunnel mode** — Encrypts the entire original IP packet and prepends a new IP header. Used for **site-to-site VPNs**. The default and the one CCNA cares about.
- **Transport mode** — Encrypts only the payload, keeps original IP header. Used for host-to-host (e.g., protecting [[GRE]] between two routers).

### Configuration Skeleton (IOS Classic Crypto Map)

```
! Phase 1 — ISAKMP policy
crypto isakmp policy 10
 encryption aes 256
 hash sha
 authentication pre-share
 group 14
 lifetime 86400
!
crypto isakmp key MyS3cret address 203.0.113.2
!
! Phase 2 — Transform set
crypto ipsec transform-set TSET esp-aes 256 esp-sha-hmac
 mode tunnel
!
! Interesting traffic ACL
access-list 100 permit ip 10.1.1.0 0.0.0.255 10.2.2.0 0.0.0.255
!
! Crypto map ties it together
crypto map CMAP 10 ipsec-isakmp
 set peer 203.0.113.2
 set transform-set TSET
 match address 100
!
interface GigabitEthernet0/0
 crypto map CMAP
```

### Verification

```
show crypto isakmp sa     ! Phase 1 status — look for QM_IDLE
show crypto ipsec sa      ! Phase 2 status — pkts encaps/decaps counters
show crypto map           ! Configured policy
```

### GRE over IPsec

IPsec alone has a glaring gap: **it doesn't carry multicast or broadcast**, which means [[OSPF]], [[EIGRP]], and other dynamic routing protocols can't run over a pure IPsec tunnel. Solution: wrap traffic in a [[GRE]] tunnel first (which carries anything), then encrypt the GRE with IPsec.

```
interface Tunnel0
 ip address 172.16.0.1 255.255.255.252
 tunnel source GigabitEthernet0/0
 tunnel destination 203.0.113.2
 tunnel protection ipsec profile MYPROFILE
```

GRE = transport flexibility. IPsec = security. Together = a routable, encrypted overlay. Modern designs use [[DMVPN]] which is GRE + IPsec + [[NHRP]] on steroids.

### Ports and Protocols Cheat Sheet

| Thing | Value |
|-------|-------|
| ISAKMP/IKE | UDP **500** |
| NAT-T (IPsec through NAT) | UDP **4500** |
| ESP | IP Protocol **50** |
| AH | IP Protocol **51** |

## Related concepts

[[IKE]] · [[ISAKMP]] · [[Diffie-Hellman]] · [[GRE]] · [[DMVPN]] · [[MPLS]] · [[Site-to-Site VPN]] · [[Remote Access VPN]] · [[SSL/TLS]] · [[NAT Traversal]] · [[Pre-Shared Key]] · [[AES]] · [[SHA]] · [[Crypto Map]]

---
*Source: VIRGIL knowledge base*