---
domain: "network-security"
tags: [spoofing, identity-deception, network-attacks, social-engineering, impersonation, active-attack]
---
# Spoofing

**Spoofing** is the act of falsifying data or identity information to deceive a system, network, or user into believing a communication originates from a trusted, legitimate source. It is a foundational technique in many attack chains, enabling adversaries to bypass [[Authentication]], evade [[Intrusion Detection Systems]], or manipulate [[Routing]] decisions. Spoofing attacks target diverse layers of the network stack, from physical [[MAC Address]] forgery to application-layer [[Email Spoofing]] and [[DNS Spoofing]].

---

## Overview

Spoofing encompasses any technique where an attacker misrepresents their identity or the origin of data. The core motivation is deception — making a victim or system trust something it should not. Spoofing exploits the implicit trust built into many protocols designed in an era when security was secondary to functionality. The original TCP/IP suite, for instance, was designed for academic and military resilience, not adversarial environments, meaning authenticity verification was largely absent from foundational protocols like IP, ARP, and DNS.

At the network layer, **IP spoofing** involves crafting packets with a forged source IP address. Because IPv4 provides no built-in mechanism to verify source addresses, a router will forward a packet regardless of whether its source IP is genuine. This allows attackers to impersonate other hosts, redirect responses, or obscure their true origin. IP spoofing is central to reflection and amplification attacks, such as DNS amplification [[DDoS]] campaigns, where the attacker sends small requests apparently from the victim's IP, causing massive response traffic to flood the victim.

At the data link layer, **ARP spoofing** poisons the ARP cache of hosts on a local network, associating the attacker's MAC address with a legitimate IP address. This enables [[Man-in-the-Middle (MitM)]] positioning without requiring any exploitation of the target operating system — only local network access. Historically, tools like Ettercap and arpspoof made this trivially easy, and it remains relevant in environments without dynamic ARP inspection.

Application-layer spoofing is equally prevalent. **Email spoofing** abuses the lack of authentication in the original SMTP protocol to send messages appearing to originate from any domain. This underpins the majority of [[Phishing]] and [[Business Email Compromise (BEC)]] attacks. Similarly, **caller ID spoofing** in [[Vishing]] attacks allows threat actors to display any phone number, commonly impersonating banks, government agencies, or internal IT departments. DNS spoofing redirects legitimate domain resolution to attacker-controlled IP addresses, silently hijacking traffic at scale.

The persistence and diversity of spoofing attacks reflect a systemic design gap in legacy protocols. Modern mitigations — SPF, DKIM, DMARC for email; DNSSEC for DNS; 802.1X and DAI for networks — layer authentication on top of protocols that lacked it by default, illustrating how the security field has had to retrofit trust mechanisms onto infrastructure that was never designed to verify identity.

---

## How It Works

### IP Spoofing

IP spoofing involves crafting a raw packet with a manipulated source IP field in the IPv4 header. On Linux, this can be done with Scapy:

```python
from scapy.all import *

# Craft a packet with a spoofed source IP
packet = IP(src="192.168.1.254", dst="10.0.0.1") / ICMP()
send(packet)
```

The target host receives the ICMP packet and believes it originated from `192.168.1.254`. Responses are sent to the spoofed address, not the attacker. This is exploited in **reflected amplification attacks**:

1. Attacker identifies an open DNS resolver or NTP server.
2. Attacker sends a small query (e.g., `ANY` DNS record request) with the **victim's IP** as the source.
3. The resolver sends a large response (amplification factor up to 70x for DNS) directly to the victim.
4. Repeated at scale, this constitutes a volumetric DDoS.

### ARP Spoofing

ARP (Address Resolution Protocol) has no authentication. Any host can broadcast a gratuitous ARP reply claiming any IP-to-MAC mapping:

```bash
# Using arpspoof (part of dsniff) on Linux
# Tell 192.168.1.1 (router) that 192.168.1.100's MAC is ours
arpspoof -i eth0 -t 192.168.1.1 192.168.1.100

# Simultaneously poison the victim (192.168.1.100)
arpspoof -i eth0 -t 192.168.1.100 192.168.1.1

# Enable IP forwarding to remain invisible (MitM)
echo 1 > /proc/sys/net/ipv4/ip_forward
```

**Step-by-step ARP poisoning:**

1. Attacker sends unsolicited ARP replies to both the victim and the default gateway.
2. Both devices update their ARP caches, mapping the other's IP to the attacker's MAC.
3. Traffic flows through the attacker's machine, which forwards it to maintain connectivity.
4. Attacker can now capture, modify, or drop packets in real time.

### DNS Spoofing

DNS spoofing (cache poisoning) injects fraudulent DNS records into a resolver's cache. The classic **Kaminsky Attack** (2008) exploited the small 16-bit transaction ID space and predictable UDP source ports:

```
Attacker → DNS Resolver: "What is the IP of bank.com?"
Attacker floods resolver with forged DNS responses:
  - Random transaction IDs
  - bank.com → 203.0.113.66 (attacker's server)
If a forged response arrives before the legitimate answer
and matches the transaction ID, the cache is poisoned.
All subsequent queries for bank.com return the fake IP.
```

### Email Spoofing

SMTP's `MAIL FROM` and the `From:` header are entirely independent and unverified by default:

```bash
# Telnet-based email spoofing demonstration
telnet mail.target.com 25
HELO attacker.com
MAIL FROM:<ceo@trustedcorp.com>
RCPT TO:<victim@target.com>
DATA
From: CEO <ceo@trustedcorp.com>
Subject: Urgent Wire Transfer
Please initiate a $50,000 transfer immediately.
.
QUIT
```

Without SPF, DKIM, and DMARC enforcement, many mail servers will accept and deliver this message.

### Caller ID / SMS Spoofing

VoIP-based caller ID spoofing uses SIP INVITE messages with a manipulated `From:` header. Services like SpoofCard (commercially) or custom Asterisk PBX configurations allow arbitrary display numbers, targeting victims through [[Vishing]] and smishing campaigns.

---

## Key Concepts

- **IP Spoofing**: Forging the source IP address field in an IP packet header, allowing an attacker to impersonate another host or obscure their true network location; used extensively in DDoS reflection attacks and trust exploitation.
- **ARP Poisoning / ARP Spoofing**: Sending unsolicited ARP replies on a LAN to corrupt the ARP cache of hosts, associating the attacker's MAC address with a legitimate IP to enable man-in-the-middle interception on Layer 2.
- **DNS Cache Poisoning**: Injecting fraudulent DNS resource records into a recursive resolver's cache so that clients receive false IP mappings for legitimate domains, silently redirecting traffic to attacker-controlled servers.
- **Email Spoofing**: Falsifying the `MAIL FROM` envelope address or the `From:` display header in an SMTP message to make it appear to originate from a trusted sender, bypassing human scrutiny and enabling phishing or BEC attacks.
- **MAC Spoofing**: Changing the hardware-level MAC address of a network interface to impersonate another device, used to bypass MAC-based access control lists, evade network monitoring, or bypass [[802.1X]] port authentication.
- **Caller ID Spoofing**: Manipulating the originating number metadata in a telephone call (via VoIP/SIP) to display an arbitrary number on the recipient's caller ID, facilitating vishing and social engineering attacks.
- **Gratuitous ARP**: An ARP reply broadcast not in response to a request, used legitimately for IP conflict detection but weaponized by attackers to preemptively poison ARP caches without needing to wait for a request cycle.
- **Reflection Attack**: A spoofing-enabled technique where the attacker sends requests with the victim's source IP to third-party servers, causing those servers to direct large responses at the victim, amplifying bandwidth exhaustion.

---

## Exam Relevance

**SY0-701 Objective Mapping**: Spoofing appears under **Domain 2.0 – Threats, Vulnerabilities, and Mitigations** (2.2: Threat Indicators) and **Domain 4.0 – Security Operations** (4.4: Network Security), and is core to understanding social engineering, network attacks, and identity-based threats.

**Common Question Patterns:**

- **Scenario identification**: A question describes someone receiving an email from "CEO@company.com" that passes visual inspection but requests a wire transfer — the answer is **email spoofing** combined with **BEC/phishing**, not necessarily malware.
- **Protocol-to-attack mapping**: Know which protocol each spoofing variant targets. ARP = Layer 2 / LAN, IP spoofing = Layer 3, DNS = application layer, email = SMTP/application layer.
- **Mitigation matching**: Questions will present a spoofing scenario and ask which control mitigates it. Practice these pairings:
  - ARP spoofing → **Dynamic ARP Inspection (DAI)** on managed switches
  - IP spoofing → **Ingress filtering / BCP38**, uRPF (Unicast Reverse Path Forwarding)
  - Email spoofing → **SPF + DKIM + DMARC**
  - DNS spoofing → **DNSSEC**
  - Caller ID spoofing → **STIR/SHAKEN** (for VoIP)
- **Spoofing vs. Impersonation**: SY0-701 distinguishes technical spoofing (protocol/data manipulation) from social engineering **impersonation** (a human pretending to be someone). Both are tested; context determines which term applies.
- **Gotcha — IP spoofing limitations**: Examiners sometimes test whether students know that fully bidirectional TCP sessions cannot be established with a spoofed IP (the attacker cannot receive the SYN-ACK). Spoofed IP is mainly useful for one-way attacks like UDP floods, reflection attacks, and trust exploitation in services that don't require a TCP handshake.
- **Spoofing as an enabler**: Spoofing is rarely an end in itself. Exam questions often chain it — spoofing → MitM → credential theft, or IP spoofing → DDoS amplification. Think about the larger attack chain.

---

## Security Implications

### Vulnerabilities Enabled

Spoofing attacks are foundational primitives for more complex attack chains:

- **Man-in-the-Middle Attacks**: ARP and DNS spoofing both establish MitM positioning, enabling [[SSL Stripping]], credential capture, and session hijacking.
- **Trust Exploitation**: Many legacy protocols (rsh, rlogin, early Kerberos misconfigurations) used IP-based trust. IP spoofing directly violated these trust boundaries.
- **Denial of Service**: IP spoofing underpins reflected/amplified DDoS. The Spamhaus DDoS (2013) used DNS amplification at ~300 Gbps; the Memcached amplification attacks (2018, amplification factor ~51,000x) used spoofed UDP requests.
- **Credential Theft**: Email spoofing-based phishing is the leading initial access vector globally per Verizon DBIR data.

### Notable Real-World Incidents and CVEs

- **CVE-2008-1447 (Kaminsky DNS Bug)**: The definitive DNS cache poisoning vulnerability. Dan Kaminsky discovered that all major DNS resolvers were susceptible to birthday-attack-style cache poisoning due to predictable transaction IDs and source ports. Coordinated industry patching in July 2008 deployed source port randomization as a partial fix; DNSSEC is the complete solution.
- **Operation Aurora (2009)**: While primarily an APT intrusion, spear-phishing via email spoofing was used in initial access, targeting Google and 34 other companies.
- **Ubiquiti BEC (2015)**: Ubiquiti Networks lost $46.7 million in a Business Email Compromise attack where attackers spoofed executive email identities to authorize fraudulent wire transfers.
- **BGP Hijacking / IP Prefix Spoofing**: The 2010 China Telecom incident rerouted ~15% of global internet traffic by announcing false BGP prefixes — a routing-layer spoofing variant. Not IP header spoofing, but the same conceptual deception applied to routing advertisements.
- **ARP Spoofing in Hotel Networks**: Demonstrated repeatedly at DEF CON; guests on shared hotel Wi-Fi or wired networks can be trivially MitM'd without dynamic ARP inspection.

### Detection Indicators

- Duplicate ARP announcements from different MAC addresses for the same IP.
- DNS responses arriving faster than expected (cached poison delivery) or from unexpected nameservers.
- Email authentication failures in mail server logs (`SPF=fail`, `DKIM=fail`).
- Network traffic appearing from RFC 1918 private addresses on external interfaces (ingress filtering violation).
- Asymmetric traffic patterns or unusual latency spikes (traffic being routed through a third party).

---

## Defensive Measures

### Layer 2 / ARP Defenses

- **Dynamic ARP Inspection (DAI)**: Enable on managed switches (Cisco IOS: `ip arp inspection vlan <vlan-id>`). DAI validates ARP packets against the DHCP snooping binding table, dropping packets with mismatched IP-MAC pairs.
- **DHCP Snooping**: Prerequisite for DAI. Enables `ip dhcp snooping` and marks trusted/untrusted ports. Untrusted ports can only send DHCP requests, not offers.
- **Static ARP entries**: For critical infrastructure (routers, servers), define static ARP entries in hosts to prevent cache modification: `arp -s 192.168.1.1 aa:bb:cc:dd:ee:ff`

### Layer 3 / IP Spoofing Defenses

- **BCP38 / Ingress Filtering**: ISPs should implement RFC 2827 ingress filtering, dropping packets from customer connections whose source IPs fall outside the customer's allocated ranges. Wide adoption would eliminate most IP spoofing.
- **Unicast Reverse Path Forwarding (uRPF)**: Configure on routers to verify that the source IP of incoming packets is reachable via the same interface it arrived on:
  ```
  interface GigabitEthernet0/0
   ip verify unicast source reachable-via rx
  ```
- **Firewall rules**: Block traffic with private source IPs arriving on external interfaces (anti-spoofing rules are a firewall baseline requirement).

### DNS Defenses

- **DNSSEC**: Cryptographically signs DNS records. Resolvers verify signatures, preventing cache poisoning. Enable via your DNS provider or authoritative server configuration.
- **DNS over HTTPS (DoH) / DNS over TLS (DoT)**: Encrypt DNS transport, preventing in-transit manipulation.
- **Source port randomization**: Randomize UDP source port in DNS queries (already implemented in modern resolvers post-Kaminsky) to increase attack difficulty.
- **Response Rate Limiting (RRL)**: Mitigates DNS amplification by throttling responses to the same source IP.

### Email Defenses

Configure all three email authentication standards for your domain:

```dns
# SPF Record (in DNS TXT)
v=spf1 include:_spf.google.com ~all

# DKIM (DNS TXT for selector "google")
google._domainkey IN TXT "v=DKIM1; k=rsa; p=<public-key>"

# DMARC (DNS TXT)
_dmarc IN TXT "v=DMARC1; p=reject; rua=mailto:dmarc@yourdomain.com; pct=100"
```

- **SP