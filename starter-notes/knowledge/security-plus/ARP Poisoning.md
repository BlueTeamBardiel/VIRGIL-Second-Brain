---
domain: "network-security"
tags: [attack, mitm, layer2, network, spoofing, security-plus]
---

# ARP Poisoning

**ARP Poisoning** (also called **ARP Spoofing** or **ARP Cache Poisoning**) is a [[Layer 2]] attack in which a malicious actor sends forged [[Address Resolution Protocol|ARP]] messages onto a local network to associate their **MAC address** with the **IP address** of another host — typically the default gateway. The result is a classic [[Man-in-the-Middle Attack|Man-in-the-Middle (MitM)]] position that enables traffic interception, modification, session hijacking, and denial of service on any [[IPv4]] LAN segment.

---

## Overview

The [[Address Resolution Protocol|Address Resolution Protocol (ARP)]], defined in [[RFC 826]] (1982), resolves 32-bit IPv4 addresses to 48-bit Ethernet MAC addresses so that frames can be delivered on a local broadcast domain. ARP was designed in an era of trusted LANs and contains **no authentication, no integrity checks, and no sequence numbers**. Any host on the segment can claim to own any IP address simply by broadcasting an ARP reply, and most operating systems will update their ARP cache based on unsolicited ("gratuitous") replies.

ARP poisoning exploits this fundamental design weakness. An attacker connected to the same [[Broadcast Domain]] as the victim floods the network with crafted ARP responses that map the gateway's IP to the attacker's MAC (and, symmetrically, the victim's IP to the attacker's MAC on the gateway). Once both caches are corrupted, all traffic between victim and gateway transits the attacker's machine, where it can be passively sniffed or actively manipulated.

Historically, ARP poisoning was the workhorse of LAN attackers in the 1990s and 2000s, enabled by tools like **dsniff**, **Cain & Abel**, and later [[Ettercap]] and [[Bettercap]]. While the rise of [[HTTPS]] and [[TLS]] has reduced the value of passive sniffing, ARP poisoning remains potent for **SSL stripping**, **DNS spoofing**, [[Credential Harvesting]], **session cookie theft** on misconfigured services, and enabling follow-on attacks like [[LLMNR Poisoning]] or [[NTLM Relay]].

ARP poisoning is strictly a **LAN-local attack** — it cannot cross a [[Router]] because ARP traffic is confined to the broadcast domain. This constraint makes it especially relevant in environments like corporate Wi-Fi, university networks, coffee shops, shared office subnets, and [[VLAN]]s without proper segmentation. Note that [[IPv6]] uses the [[Neighbor Discovery Protocol|Neighbor Discovery Protocol (NDP)]] instead of ARP; analogous attacks exist (NDP spoofing / RA flooding) but use different mechanics.

## How It Works

The attack depends on two ARP protocol quirks: (1) most hosts accept **unsolicited ARP replies** and update their cache, and (2) ARP has no state — a reply without a matching request is still processed.

**Step-by-step attack flow:**

1. **Reconnaissance**: The attacker enumerates the LAN with tools like `arp-scan`, `nmap -sn`, or `netdiscover` to identify the victim's IP (e.g., `192.168.1.50`) and the default gateway (e.g., `192.168.1.1`).
2. **IP forwarding**: The attacker enables packet forwarding so traffic flows through rather than being dropped:
   ```bash
   echo 1 > /proc/sys/net/ipv4/ip_forward
   # or
   sysctl -w net.ipv4.ip_forward=1
   ```
3. **Bidirectional poisoning**: The attacker sends forged ARP replies to both parties:
   - To the victim: "`192.168.1.1` is at `aa:bb:cc:dd:ee:ff`" (attacker's MAC)
   - To the gateway: "`192.168.1.50` is at `aa:bb:cc:dd:ee:ff`"
4. **Interception**: Frames now flow victim → attacker → gateway and back. The attacker can run [[Wireshark]], [[tcpdump]], or [[sslstrip]] to capture or modify traffic.
5. **Maintenance**: ARP entries time out (typically 60 seconds on Linux, ~10 minutes on Windows), so the attacker must continuously re-poison.

**Example using `arpspoof` (dsniff suite):**
```bash
# Poison victim, telling them we are the gateway
arpspoof -i eth0 -t 192.168.1.50 192.168.1.1

# In another terminal, poison the gateway
arpspoof -i eth0 -t 192.168.1.1 192.168.1.50
```

**Example using Ettercap (fully automated):**
```bash
ettercap -T -q -M arp:remote /192.168.1.50// /192.168.1.1//
```

**Example using Bettercap:**
```bash
bettercap -iface eth0
> set arp.spoof.targets 192.168.1.50
> arp.spoof on
> net.sniff on
```

The ARP packet itself is simple: opcode `2` (reply), sender hardware address = attacker's MAC, sender protocol address = spoofed IP. Because ARP replies are broadcast-capable and trusted blindly, a single crafted frame can poison every host on the segment — a technique called **gratuitous ARP flooding**.

## Key Concepts

- **ARP Cache**: Local table mapping IP → MAC addresses. View with `arp -a` (Windows/macOS) or `ip neigh` (Linux). Entries are usually dynamic and time out.
- **Gratuitous ARP (GARP)**: An unsolicited ARP announcement, legitimately used for failover/duplicate-address detection but abused for poisoning.
- **Bidirectional (Full-Duplex) Poisoning**: Spoofing both victim and gateway so traffic traverses the attacker in both directions — required for true MitM.
- **Half-Duplex Poisoning**: Only one side is poisoned; useful for passive reconnaissance or DoS but not full interception.
- **MAC Flooding**: A related but distinct attack that overwhelms a switch's [[CAM Table]], causing it to fail-open (broadcast all frames), enabling sniffing without ARP spoofing.
- **Broadcast Domain**: The scope within which ARP operates — bounded by routers/L3 devices, not by switches or [[VLAN]]s at the same tag.
- **IP Forwarding**: Kernel feature that routes packets between interfaces; attacker must enable it to avoid creating a blackhole.

## Exam Relevance

For [[Security Plus SY0-701|Security+ SY0-701]], expect ARP poisoning under **Objective 2.4 (network attacks)**:

- Know that ARP poisoning is a **Layer 2**, **LAN-only** attack and a prerequisite/enabler for [[On-Path Attack|on-path (MitM) attacks]].
- **Distinguish** ARP poisoning (spoofs IP↔MAC mappings) from **MAC flooding** (overflows switch CAM table) from **[[DNS Poisoning]]** (corrupts name resolution).
- Recognize defensive controls by name: **[[Dynamic ARP Inspection|Dynamic ARP Inspection (DAI)]]**, **[[DHCP Snooping]]**, **[[Port Security]]**, **static ARP entries**, and **802.1X**.
- Know CompTIA calls MitM attacks **"on-path attacks"** in the 701 objectives.
- Common gotcha: ARP does **not** traverse routers, so ARP poisoning cannot reach hosts on a different subnet.
- Symptoms on a question stem: duplicate IPs, gateway MAC changing rapidly, users seeing certificate warnings on the same LAN.

## Security Implications

Successful ARP poisoning enables a wide attack surface:

- **Credential theft** from unencrypted protocols: [[Telnet]], [[FTP]], [[HTTP]], POP3, [[SNMP]] v1/v2c.
- **SSL stripping** via `sslstrip` — downgrading HTTPS to HTTP where HSTS is absent.
- **DNS spoofing** injection, redirecting users to phishing pages.
- **Session hijacking** by stealing cookies or tokens.
- **Denial of service** by pointing the gateway IP at a nonexistent MAC (blackhole).
- **Lateral movement enablement**: captured hashes fuel [[Pass-the-Hash]] or [[NTLM Relay]] attacks.

**Real-world incidents**: ARP poisoning has been documented in espionage cases (e.g., malicious insiders on corporate LANs), hotel Wi-Fi attacks (the "DarkHotel" APT used adjacent techniques), and countless penetration test reports. Tools like **Cain & Abel** (discontinued but still circulated), [[Ettercap]], [[Bettercap]], and the [[Metasploit]] `auxiliary/spoof/arp/arp_poisoning` module make the attack trivial to execute.

**Detection signatures**:
- Sudden changes in the MAC address associated with the gateway IP.
- Duplicate IP warnings in OS event logs.
- Tools like **ArpWatch**, **XArp**, or **Arpalert** monitor MAC/IP binding changes.
- [[IDS|Intrusion detection systems]] like [[Snort]] and [[Suricata]] have rules for ARP anomalies (e.g., Snort's `arpspoof` preprocessor).

## Defensive Measures

**Switch-level (most effective):**
- **[[Dynamic ARP Inspection]] (DAI)** on Cisco/Juniper/Arista switches validates every ARP packet against a trusted binding table (populated by [[DHCP Snooping]]). Invalid ARP packets are dropped.
  ```
  ! Cisco IOS
  ip dhcp snooping
  ip dhcp snooping vlan 10
  ip arp inspection vlan 10
  interface Gi0/1
    ip dhcp snooping trust
    ip arp inspection trust
  ```
- **[[Port Security]]**: limit MAC addresses per port and sticky-learn them.
- **Private VLANs** isolate hosts that shouldn't talk directly.
- **802.1X** with dynamic VLAN assignment ensures only authenticated devices join.

**Host-level:**
- **Static ARP entries** for critical hosts (gateway, domain controllers):
  ```bash
  # Linux
  arp -s 192.168.1.1 00:11:22:33:44:55
  # Windows
  netsh interface ipv4 add neighbors "Ethernet" 192.168.1.1 00-11-22-33-44-55
  ```
- **Endpoint detection agents** that alert on ARP cache changes.
- **Encrypted protocols everywhere**: [[HTTPS]] with [[HSTS]], [[SSH]], [[TLS]]-wrapped services, [[VPN]] tunnels — these make MitM positions far less useful.
- **[[Network Segmentation]]**: smaller broadcast domains limit blast radius.

**Monitoring:**
- Deploy **ArpWatch** to email on MAC/IP changes.
- SIEM rules for DA