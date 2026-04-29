---
domain: "networking"
tags: [bandwidth, qos, traffic-shaping, network-management, performance, security]
---
# Bandwidth Management

**Bandwidth management** is the process of measuring, controlling, and optimizing the allocation of network capacity across users, applications, and services to ensure efficient and equitable use of available resources. It relies on techniques such as **traffic shaping**, **Quality of Service (QoS)**, and **rate limiting** to prioritize critical traffic and prevent congestion. In cybersecurity contexts, bandwidth management is essential for both maintaining service availability and detecting anomalous traffic patterns indicative of attacks like [[DDoS Attacks]] or [[Data Exfiltration]].

---

## Overview

Bandwidth management emerged as a practical necessity in the early days of shared internet connections, where a single heavy user could degrade performance for an entire network segment. As networks scaled, the need for systematic controls grew beyond simple physical capacity upgrades. Today, bandwidth management is a foundational component of network engineering and security architecture in enterprise, ISP, and homelab environments alike.

At its core, bandwidth management addresses the reality that network links have finite capacity — measured in bits per second (bps) — and that not all traffic deserves equal treatment. A VoIP call requires low latency and consistent delivery, while a background software update can tolerate delays. Without management, networks default to best-effort delivery where all packets compete equally, leading to jitter, dropped calls, and degraded interactive sessions during periods of high utilization.

Modern bandwidth management combines hardware and software mechanisms. Routers and switches implement QoS at the packet level using header fields to classify and prioritize traffic. Dedicated appliances or software-defined networking (SDN) platforms handle more granular policies. At the ISP level, bandwidth management is a commercial and regulatory concern — providers throttle or prioritize certain traffic types, raising ongoing net neutrality debates.

From a security perspective, bandwidth management tools serve a dual purpose. They enforce usage policies to prevent abuse, and they provide visibility into traffic flows that can reveal intrusions, botnet activity, or insider threats. Sudden bandwidth spikes, unexpected destinations, or unusual protocol distributions are all detectable through bandwidth monitoring and can serve as early warning indicators in a security operations context.

---

## How It Works

### Traffic Classification

Before bandwidth can be managed, traffic must be classified. Classification happens at multiple layers:

- **Layer 2 (Data Link):** 802.1Q VLAN tags and 802.1p CoS (Class of Service) bits (3 bits in the VLAN tag, values 0–7) allow switches to prioritize frames.
- **Layer 3 (Network):** The IP header contains the **DSCP (Differentiated Services Code Point)** field — 6 bits within the former ToS byte — allowing 64 possible classifications. Common DSCP values include:
  - `EF (101110)` — Expedited Forwarding, used for VoIP
  - `AF41 (100010)` — Assured Forwarding, used for video streaming
  - `CS0 (000000)` — Best effort (default)
- **Layer 4–7 (Transport/Application):** Deep Packet Inspection (DPI) engines examine port numbers, protocol signatures, and even payload content to classify traffic by application.

### Queuing Mechanisms

Once classified, packets enter queues that determine scheduling behavior:

- **FIFO (First In, First Out):** The simplest queue — no prioritization. All packets processed in arrival order. Prone to head-of-line blocking.
- **WFQ (Weighted Fair Queuing):** Assigns weights to flows so higher-priority flows receive proportionally more bandwidth, while still ensuring lower-priority flows are not completely starved.
- **CBWFQ (Class-Based WFQ):** Extends WFQ by allowing administrators to define traffic classes and assign minimum bandwidth guarantees.
- **LLQ (Low Latency Queuing):** Adds a strict priority queue to CBWFQ, ensuring delay-sensitive traffic (VoIP) is always serviced first before other classes.
- **PQ (Priority Queuing):** Four fixed queues (High, Medium, Normal, Low). Higher queues are always drained first — lower priority traffic can starve entirely under load.

### Traffic Shaping vs. Policing

These are the two primary enforcement mechanisms:

| Feature | Traffic Shaping | Traffic Policing |
|---|---|---|
| Exceeds-rate behavior | Buffers excess traffic | Drops or re-marks excess packets |
| Latency impact | Introduces delay/jitter | No additional delay |
| Typical use case | WAN egress smoothing | Inbound rate enforcement |
| Token bucket | Uses token bucket with buffer | Uses token bucket, no buffer |

**Token bucket algorithm:** Tokens accumulate at a defined rate (CIR — Committed Information Rate) up to a maximum burst size (CBS). Each packet consumes tokens equal to its size. If tokens are available, the packet is forwarded; if not, it is shaped (delayed) or policed (dropped).

### Cisco IOS Configuration Example (CBWFQ + LLQ)

```ios
! Define class maps for traffic classification
class-map match-any VOIP
 match dscp ef
class-map match-any VIDEO
 match dscp af41
class-map match-any BULK
 match protocol ftp
 match protocol bittorrent

! Define policy map with bandwidth allocations
policy-map WAN-POLICY
 class VOIP
  priority 512          ! LLQ: strict priority, 512 kbps guaranteed
 class VIDEO
  bandwidth percent 30  ! 30% of interface bandwidth
 class BULK
  bandwidth percent 10  ! 10% for bulk transfers
  shape average 1000000 ! Shape bulk to 1 Mbps max
 class class-default
  fair-queue            ! WFQ for all other traffic

! Apply policy to WAN interface
interface GigabitEthernet0/0
 service-policy output WAN-POLICY
```

### Linux Traffic Control (tc) Example

On Linux systems, the `tc` (traffic control) utility implements the kernel's queuing disciplines (qdiscs):

```bash
# Add HTB (Hierarchical Token Bucket) root qdisc on eth0
tc qdisc add dev eth0 root handle 1: htb default 30

# Create parent class with total bandwidth ceiling
tc class add dev eth0 parent 1: classid 1:1 htb rate 100mbit

# High-priority class (VoIP) - 10 Mbps guaranteed
tc class add dev eth0 parent 1:1 classid 1:10 htb rate 10mbit ceil 20mbit prio 1

# Default traffic - 30 Mbps
tc class add dev eth0 parent 1:1 classid 1:30 htb rate 30mbit ceil 100mbit prio 3

# Add SFQ (Stochastic Fair Queuing) leaf to default class
tc qdisc add dev eth0 parent 1:30 handle 30: sfq perturb 10

# Create filter to match VoIP (DSCP EF = 0xb8 in TOS field)
tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 \
  match ip tos 0xb8 0xfc flowid 1:10

# View current configuration
tc -s qdisc show dev eth0
tc -s class show dev eth0
```

### Bandwidth Monitoring Tools

Real-time monitoring feeds management decisions:

```bash
# iftop - per-connection bandwidth display
sudo iftop -i eth0 -n

# nload - interface aggregate throughput graphs
nload eth0

# nethogs - per-process bandwidth breakdown
sudo nethogs eth0

# vnstat - historical traffic statistics
vnstat -i eth0 -h   # hourly statistics
vnstat -i eth0 -d   # daily statistics

# iperf3 - measure actual available bandwidth
iperf3 -s                          # server mode
iperf3 -c 192.168.1.100 -t 30     # client, 30-second test
iperf3 -c 192.168.1.100 -u -b 10M # UDP test at 10 Mbps
```

---

## Key Concepts

- **QoS (Quality of Service):** A broad set of techniques that guarantee performance levels for specific traffic classes, measured in terms of bandwidth, latency, jitter, and packet loss. QoS policies define what traffic receives priority treatment and under what conditions.

- **DSCP (Differentiated Services Code Point):** A 6-bit field in the IPv4/IPv6 header used to mark packets with their traffic class. DSCP marking enables end-to-end QoS across routing domains without requiring per-flow state in every router — a scalable approach defined in RFC 2474.

- **CIR (Committed Information Rate):** The guaranteed minimum bandwidth contracted or configured for a traffic class or customer. Traffic at or below the CIR is forwarded with high probability; traffic exceeding CIR is subject to shaping or policing.

- **Burst Size (CBS/EBS):** The maximum amount of data above the CIR that can be transmitted for a short period without being penalized. CBS (Committed Burst Size) defines the normal burst allowance; EBS (Excess Burst Size) allows occasional larger bursts at the cost of re-marking excess packets.

- **Traffic Shaping:** A rate-limiting technique that buffers excess packets and releases them at a controlled rate, smoothing bursty traffic flows. Shaping introduces queuing delay but avoids the packet loss associated with policing, making it preferable for TCP traffic where loss triggers retransmission.

- **HTB (Hierarchical Token Bucket):** A Linux kernel queuing discipline that implements class-based bandwidth allocation with borrowing between classes. Parent classes define ceilings; child classes define guaranteed rates and can borrow unused capacity from siblings up to the ceiling.

- **Bandwidth Throttling:** The intentional slowing of specific traffic flows, often applied by ISPs to manage congestion or enforce fair-use policies. From a security standpoint, throttling can also be applied to limit the damage from compromised hosts generating excessive outbound traffic.

- **WAN Optimization:** Techniques including compression, deduplication, caching, and protocol acceleration that effectively increase available bandwidth by reducing the amount of data transmitted. Products like Riverbed Steelhead and Cisco WAAS implement these techniques at the application layer.

---

## Exam Relevance

**Security+ SY0-701** addresses bandwidth management primarily within the domains of **network security** and **infrastructure security**. Key exam areas include:

**QoS and Traffic Prioritization:**
- Understand that QoS is a *availability* control — it ensures critical services remain usable during congestion
- Know the difference between traffic shaping (buffers) vs. policing (drops/marks)
- DSCP values and 802.1p CoS are commonly tested in the context of VoIP security and network segmentation

**Bandwidth and Attack Recognition:**
- **DoS/DDoS attacks** consume bandwidth as a primary goal — bandwidth management controls are a mitigating control
- Exam questions often ask you to identify which control type (preventive, detective, corrective) bandwidth monitoring represents
- Rate limiting at network perimeters is a standard answer for mitigating volumetric attacks

**Common Question Patterns:**
- *"Which technology would you use to prioritize VoIP traffic?"* → QoS/DSCP/LLQ
- *"A user is consuming all available internet bandwidth with streaming video, degrading VoIP calls. What should you implement?"* → Traffic shaping or QoS policy
- *"Which attack type is directly mitigated by bandwidth rate limiting at the network perimeter?"* → DDoS/volumetric attacks

**Gotchas:**
- QoS does **not** increase total bandwidth — it only manages allocation of existing capacity. Exam distractors may suggest QoS as a solution to chronic under-provisioning.
- Traffic shaping and policing are often confused — remember: shaping *delays* traffic, policing *drops or re-marks* it.
- DSCP markings can be set by endpoints and may not be trustworthy — enterprise networks often re-mark traffic at the perimeter.

---

## Security Implications

### Bandwidth-Based Attack Vectors

**Volumetric DDoS Attacks** are the most direct bandwidth security threat. Attack traffic — UDP floods, ICMP floods, DNS amplification attacks, NTP amplification — consumes link capacity, rendering legitimate services unreachable. DNS amplification attacks (exploiting open resolvers) can achieve amplification factors of 28–54x, meaning a 1 Gbps source can generate 28–54 Gbps of attack traffic toward the victim. The 2016 Dyn DNS attack (peaking at ~1.2 Tbps, attributed to Mirai botnet) and the 2018 GitHub attack (1.35 Tbps via memcached amplification) demonstrate the scale of real-world volumetric threats.

**Data Exfiltration via Bandwidth Abuse:** Attackers with persistent access to internal networks may exfiltrate large datasets over extended periods to avoid detection. Slow, low-volume exfiltration may evade threshold-based alerts; anomaly-based detection using bandwidth baselines is more effective. The 2013 Target breach involved structured exfiltration of 40 million payment card records.

**Bandwidth Exhaustion as a Denial-of-Service:** Even without an external attacker, misconfigured internal systems — backup jobs, software updates, or worm propagation — can saturate internal links. The 2003 SQL Slammer worm doubled in size every 8.5 seconds and generated ~75 GB/s of UDP traffic globally within 10 minutes, causing widespread bandwidth exhaustion.

**QoS Manipulation:** Attackers with network access can mark their own traffic with high-priority DSCP values, effectively conducting a low-level QoS abuse attack. If DSCP trust policies are not enforced, an attacker can starve other traffic by marking bulk transfers as `EF` (Expedited Forwarding).

**Traffic Analysis (Passive):** Encrypted tunnels carrying exfiltration may be identifiable by their bandwidth characteristics even when content cannot be inspected — timing, volume, and destination patterns remain visible to network monitoring tools.

### CVEs and Incidents

- **CVE-2020-10110 / SNMP Amplification:** Misconfigured SNMP agents used in reflection/amplification DDoS, achieving up to 650x amplification factor.
- **CVE-2013-5211 (NTP monlist):** NTP servers with `monlist` enabled could be abused for ~556x amplification DDoS attacks.
- **Memcached CVE-2018-1000115:** Unauthenticated UDP access to memcached servers enabled the 1.35 Tbps GitHub attack via ~51,000x amplification.

---

## Defensive Measures

### Network-Level Controls

**1. Implement QoS with DSCP Trust Boundaries:**
Configure network edges to re-mark or strip inbound DSCP markings from untrusted sources. Only trust DSCP markings from internal, managed devices.

```ios
! Cisco: Set DSCP trust on access ports for managed IP phones only
interface FastEthernet0/1
 mls qos trust device cisco-phone
 mls qos trust dscp
```

**2. Rate Limiting at Network Perimeter:**
Apply inbound/outbound rate limits on internet-facing interfaces to cap the impact of both incoming attacks and outbound anomalies:

```ios
! Cisco: Police inbound traffic to 100 Mbps on WAN interface
policy-map INBOUND-POLICE
 class class-default
  police rate 100000000 bps burst 1500000 byte
   conform-action transmit
   exceed-action drop

interface GigabitEthernet0/1
 service-policy input INBOUND-POLICE
```

**3. uRPF (Unicast Reverse Path Forwarding):**
Drops packets with spoofed source addresses, mitigating reflection/amplification attack sources:

```ios
interface GigabitEthernet0/1
 ip verify unicast source reachable-via rx
```

**4. BGP Blackholing / RTBH:**
For large-scale DDoS, configure Remote Triggered Black Hole (RTBH) routing to null-route attack traffic upstream at the BGP level, in coordination with your ISP.

### Host and Application Controls

**5. Linux tc Rate Limiting for Servers:**
Prevent individual servers from consuming excessive uplink bandwidth (e.g., during compromise):

```bash
# Limit total egress from a server to 100 Mb