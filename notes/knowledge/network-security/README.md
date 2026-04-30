# Network Security — Defending the Wire
> The network doesn't lie. Everything leaves a trace if you're capturing the right traffic in the right place.

---

## Network Security Monitoring (NSM)

### What to Capture
**Full packet capture (PCAP):** Everything. Expensive in storage but invaluable for forensics.
**Flow data (NetFlow/IPFIX):** Who talked to whom, when, how much data. Cheap, scalable, no payload.
**DNS logs:** Every hostname resolution. Critical for C2 detection — malware can hide in HTTPS but has to resolve domains.
**Proxy logs:** Web traffic with URLs, user agents, referrers. Catches most malware callbacks.

### Where to Put Sensors
- **North-South (perimeter):** Internet-facing — catches inbound attacks, C2 callbacks, exfiltration
- **East-West (lateral):** Between VLANs/segments — catches lateral movement *after* perimeter bypass
- **At choke points:** Not everywhere — focus on where traffic *must* flow
- **[[YOUR-LAB]] placement:** [[LAB_HOST]] is the designated network IDS/forensic logging host — see Phase 2.5

---

## IDS vs IPS

| Feature | IDS | IPS |
|---|---|---|
| Position | Passive/tap — out of band | Inline — traffic flows through it |
| Action | **Detect and alert** | **Detect, alert, and block** |
| Failure mode | If it breaks, nothing changes | If it breaks, traffic may stop (fail-open vs fail-closed) |
| False positive cost | Noise in alerts | Blocked legitimate traffic |
| Use case | Forensic visibility, compliance | Active threat blocking |

**Snort vs Suricata vs Zeek:**
| Tool | Type | Best For |
|---|---|---|
| [[Snort]] | IDS/IPS (signature) | Simple rule-based detection, widely deployed |
| [[Suricata]] | IDS/IPS (signature + protocol) | Multi-threading, protocol parsers, EVE JSON logging |
| [[Zeek]] | NSM framework (behavioral) | Protocol analysis, connection logs, scripted detection |

Suricata does what Snort does but faster and with better logging.
Zeek is different — it doesn't do signatures, it logs everything about every connection.
**Best practice:** Suricata for IDS/IPS + Zeek for NSM logging — complementary, not competing.

---

## Firewall Types

### Packet Filter (Layer 3/4)
- Inspects: Source/dest IP, source/dest port, protocol (TCP/UDP/ICMP)
- Does NOT see: Application layer, stateful connections, payload
- Examples: `iptables` rules, ACLs on [[YOUR_SWITCH]] (Cisco 3850)
- Weakness: Can't distinguish a web browser from malware using port 80

### Stateful Inspection (Layer 3/4 + state)
- Tracks TCP connection state (SYN/SYN-ACK/ACK)
- Only allows return traffic for established connections
- Examples: [[UFW]] on YOUR-LAB fleet hosts, most hardware firewalls
- Weakness: Still no application visibility

### Next-Generation Firewall (NGFW, Layer 7)
- Application identification regardless of port
- User identity integration (AD lookup)
- SSL/TLS inspection (decrypt, inspect, re-encrypt)
- Integrated IPS
- Examples: Palo Alto, Fortinet, Cisco Firepower
- Weakness: Complex, expensive, SSL inspection has privacy implications

### Web Application Firewall (WAF, Layer 7 HTTP)
- Specifically designed for web app attack patterns
- Understands HTTP — can block SQL injection, XSS, CSRF, SSRF patterns
- Examples: ModSecurity, AWS WAF, Cloudflare WAF
- Position: In front of web servers, often reverse proxy

---

## Network Segmentation

### Why Flat Networks Are Dangerous
On a flat /24, any compromise = access to every device. Ransomware spreads via SMB, Mimikatz harvests domain creds, BloodHound maps your entire AD. One phished workstation = full domain compromise in hours.

### VLANs
Layer 2 segmentation. Separate broadcast domains. Traffic between VLANs requires a router/L3 switch.
- [[YOUR_SWITCH]] (Cisco 3850) is the YOUR-LAB inter-VLAN routing device
- Current YOUR-LAB is mostly flat (LAB_IP/24) — segmentation is a future hardening goal

### DMZ (Demilitarized Zone)
Public-facing servers in a network segment that has no direct access to internal network.
- Web servers, mail relays, reverse proxies go here
- Compromise of DMZ host doesn't directly expose internal AD

### Microsegmentation
East-west firewall policies between individual workloads. Zero trust networking at the host level.
- Implemented via host-based firewalls ([[UFW]]) + zero-trust software-defined networking
- Tailscale ACLs provide a form of microsegmentation for YOUR-LAB fleet — even on LAN, you can lock down inter-host traffic

---

## Zero Trust Networking

**Principle:** Never trust, always verify — regardless of whether traffic is coming from inside or outside the network perimeter.

The perimeter is dead. VPN gives LAN access, then lateral movement is trivial. Zero trust assumes breach.

### Core Principles
1. **Verify explicitly** — authenticate and authorize every request based on identity, device health, location
2. **Use least privilege access** — minimum permissions, just-in-time access
3. **Assume breach** — monitor everything, segment everything, prepare to contain

### Implementation
- Identity: MFA, conditional access (can't connect from unmanaged device)
- Device: compliance checks (patched OS, AV running, disk encrypted)
- Network: microsegmentation, network access control, [[Tailscale]] ACLs
- Application: WAF, mTLS between services, zero-trust application proxies

### [[Tailscale]] as Zero Trust for YOUR-LAB
Tailscale implements zero trust at the network layer for YOUR-LAB fleet:
- Identity-based access (Tailscale auth = identity)
- ACL policies control which host can reach which service
- No VPN split tunnel — Tailscale provides specific service access, not LAN broadcast

---

## Common Network Attacks

### ARP Spoofing / Poisoning
**What:** Send fake ARP replies associating attacker's MAC with victim's IP → MITM
**Detection:** ARP table inconsistencies, multiple MACs for same IP, [[Wireshark]] `arp.duplicate-address-detected`
**Prevention:** Dynamic ARP Inspection (DAI) on managed switches, static ARP entries for critical hosts

### VLAN Hopping
**What:** Switch spoofing (trunk negotiation) or double tagging to access other VLANs
**Prevention:** Disable DTP (`switchport nonegotiate`), set native VLAN to unused VLAN ID, explicit access mode assignment

### DNS Poisoning / Cache Poisoning
**What:** Inject malicious DNS records into resolver cache → redirect traffic
**Prevention:** DNSSEC, use trusted resolvers ([[Pi-hole]] on [[DNS_HOST]]), monitor for unexpected DNS changes

### BGP Hijacking
**What:** Announce more specific routes than legitimate ASN → redirect internet traffic
**Prevention:** RPKI (Resource Public Key Infrastructure), BGPsec (rarely deployed)
**Detection:** BGPmon, Cloudflare Radar anomalies

### MITM (Man in the Middle)
**What:** Position attacker between client and server to intercept/modify traffic
**How:** ARP spoofing, DNS poisoning, rogue access point, compromised router
**Detection:** Certificate warnings, unexpected TLS certificates, traffic anomalies in [[Zeek]] logs

---

## Wireless Security

See [[Wireless Security]] for full reference.
**Quick:** WPA3 > WPA2-Enterprise > WPA2-Personal. [[CAIM]] (WiFi Pineapple) used for wireless lab testing in YOUR-LAB.

---

## Network Forensics

### What pcap Shows
PCAP is the ground truth. Given full packet capture, you can reconstruct:
- Every TCP connection with payload
- File transfers (HTTP, FTP, SMB)
- Credentials over unencrypted protocols (Telnet, HTTP Basic Auth, FTP)
- DNS lookups (even for deleted malware — it had to resolve its C2 domain)
- TLS certificate details (even for encrypted traffic — see JA3)

### Key Wireshark Filters
```wireshark
# HTTP traffic only
http

# DNS queries
dns

# Failed TCP connections (SYN with no SYN-ACK → scanning)
tcp.flags.syn == 1 && tcp.flags.ack == 0

# Large data transfers (potential exfiltration)
frame.len > 1400

# Specific destination IP
ip.dst == LAB_IP

# Non-standard HTTPS ports (potential C2)
ssl && tcp.port != 443

# ARP broadcast storms
arp.opcode == 1

# Catch specific user agent (common malware pattern)
http.user_agent contains "curl"
```

### NetFlow Analysis
When you don't have PCAP, NetFlow still shows:
- Beaconing patterns (regular intervals = C2)
- Data volume anomalies (1GB exfil to external IP)
- Internal scanning (one host connecting to many IPs on same port)
- DNS query volume (DGA malware = high query rate to random domains)

---

## Tags
`#network-security` `#ids-ips` `#firewall` `#segmentation` `#zero-trust` `#nsm`

[[Wireshark]] [[Snort]] [[Suricata]] [[Zeek]] [[UFW]] [[CAIM]] [[Tailscale]] [[CySA+]] [[DFIR]]