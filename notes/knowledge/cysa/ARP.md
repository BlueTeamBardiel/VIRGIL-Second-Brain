# ARP — Address Resolution Protocol

## What it is

In **Rainbow Six Siege**, Thatcher tosses an EMP and every electronic on the wall — Mute jammers, Bandit batteries, Mira mirrors — goes dead. Now Thermite walks up and breaches the reinforced wall like it was never reinforced. The defense trusted the gadgets. The gadgets stopped being trustworthy the moment something on the same floor decided to lie to them. That's exactly what ARP does on your LAN — it's a trust-by-default protocol that assumes whoever shouts loudest about owning an IP actually owns it.

**ARP (Address Resolution Protocol)** maps Layer 3 IP addresses to Layer 2 MAC addresses on a local segment. When your workstation wants to send a packet to `10.0.0.1`, it broadcasts an ARP request — "who has 10.0.0.1?" — and whatever box replies first gets its MAC written into the requesting host's ARP cache. No authentication. No challenge. No signature. RFC 826, 1982, runs on every IPv4 network you've ever touched.

That trust-by-default behavior is the reason ARP shows up in CS0-003 Domain 1.2 — **indicators of potentially malicious activity**. Half the network-tier IoCs on the objective list (rogue devices, scans/sweeps, unexpected outbound traffic, unauthorized changes to communication paths) bottom out at ARP.

## Why it matters

ARP is the seam between routed and switched networks. Compromise it and you sit between any two hosts on the segment without touching a router, a firewall, or a host's credentials. It's the cheapest lateral-movement and credential-harvesting primitive in the playbook — Ettercap, Bettercap, arpspoof in dsniff, Responder's ARP module, Cain (vintage). Every red team carries it. Every blue team should be able to spot it.

For the CySA+ exam, ARP shows up under Objective **1.2** as the mechanism behind **rogue devices on the network**, **scans/sweeps**, **unusual traffic spikes**, **irregular peer-to-peer activity**, and **unauthorized changes to communication paths**. You will not be asked to read an ARP header on the exam, but you will be asked to interpret a packet capture or a SIEM alert and identify "ARP spoofing" or "ARP poisoning" as the cause.

In the real SOC, ARP-layer attacks are quiet. They don't trip antivirus. They don't generate Windows event 4625. They live in switch CAM tables, port-security violation logs, and the rare DAI (Dynamic ARP Inspection) drop counter — none of which most orgs pipe into the SIEM.

## Key facts

### How ARP works (one-pass refresher)

| Step | Action | Frame type |
|------|--------|------------|
| 1 | Host A needs MAC for IP X | Checks local ARP cache |
| 2 | Cache miss → broadcast | ARP Request (FF:FF:FF:FF:FF:FF) |
| 3 | Host owning IP X replies | ARP Reply (unicast) |
| 4 | Host A caches the IP↔MAC mapping | Cache TTL ~2 min (varies by OS) |

**Critical weakness:** ARP also accepts **gratuitous ARP** — an unsolicited reply announcing "I am IP X at MAC Y." Hosts cache it. No request required. This is the whole game.

### Attack variants you must recognize

**ARP spoofing / ARP poisoning** — attacker sends forged ARP replies binding the victim's gateway IP to the attacker's MAC. Victim's traffic to the gateway now flows through the attacker. Pair it with IP forwarding and you have a transparent MITM. Used for credential harvesting (downgrade attacks on Kerberos, NTLM relay), session hijacking, and [[SSL stripping]].

**ARP cache flooding** — overwhelms the switch CAM table with bogus MAC entries until the switch fails open and starts behaving like a hub. Now every port sees every frame. Tool of choice: `macof`. This is **MAC flooding** — closely related, often confused on the exam.

**ARP scanning / sweeping** — attacker pings every IP in the subnet via ARP requests to map live hosts. Shows up as a burst of ARP-Request broadcasts from one source MAC in a short window. CompTIA calls this a **scan/sweep** under Domain 1.2. Tools: `arp-scan`, `nmap -PR`, `netdiscover`.

**Rogue device announcement** — attacker plugs a Raspberry Pi or a dropbox into a conference-room jack, gets DHCP, starts ARPing. The new MAC OUI (vendor prefix) and unfamiliar hostname are your indicators. CompTIA calls this **rogue devices on the network**.

### Indicators of ARP-layer compromise

> **CompTIA exam trap:** "Two IP addresses sharing one MAC" and "one IP address claimed by two MACs" are *not the same thing*. **One MAC owning many IPs** is normal for a router or hypervisor. **One IP owned by two MACs** is the ARP spoofing signature. CompTIA will absolutely flip these in a distractor.

What you actually look for in pcap or switch logs:

- **Duplicate IP claims** — two different MACs replying for the same IP within seconds. Wireshark filter: `arp.duplicate-address-detected`
- **Unsolicited ARP replies** — replies without a matching request. Filter: `arp.opcode == 2` correlated against requests
- **Gratuitous ARP burst** — sudden flood of "I am the gateway" announcements
- **ARP request storm from one source** — scan/sweep behavior
- **Gateway MAC suddenly changes** — your default gateway's MAC is the most valuable spoof target; if it changes and there was no failover, assume compromise until proven otherwise
- **Switch port-security violations** — port saw more MACs than configured limit
- **DAI drops** — Dynamic ARP Inspection counter climbing on a switch interface

### Downstream IoCs that trace back to ARP

When the analyst sees these in the SIEM, ARP poisoning is on the differential:

| Observed IoC (CS0-003 1.2 language) | Why ARP could be the root cause |
|---|---|
| **Unexpected outbound traffic** | Victim traffic redirected through attacker, then re-egressed |
| **Beaconing** | Attacker on-path collecting C2 callbacks from compromised host |
| **Unusual traffic spikes** | MITM doubles east-west traffic — one flow becomes two |
| **Irregular peer-to-peer** | Hosts suddenly talking to a workstation MAC instead of the gateway |
| **Data exfiltration** | Attacker harvests cleartext credentials, files, tokens from mirrored flows |
| **Service interruption** | Bad spoof = blackhole. Victim can't reach gateway at all. |
| **Activity on unexpected ports** | Attacker proxies and re-emits traffic from their tooling ports |
| **Social engineering attacks** | Combine ARP MITM with a captive portal or fake login page |

### Defenses (know them by name)

- **Dynamic ARP Inspection (DAI)** — Cisco feature on managed switches. Validates ARP packets against the DHCP snooping binding table. Drops the lies. Pair with **DHCP snooping**, which builds the binding table.
- **Port security** — limits MACs per switchport, optionally sticky-learned. Stops MAC flooding cold.
- **Static ARP entries** — manually pin the gateway MAC on critical servers. Brittle, but bulletproof for that one mapping.
- **802.1X** — port-level authentication. The rogue Pi never gets a link in the first place.
- **Network segmentation / VLANs** — shrink the broadcast domain, shrink the blast radius.
- **ARP monitoring tools** — arpwatch, XArp, or a SIEM rule on switch syslog watching for DAI drops and port-security violations.

> **CompTIA exam trap:** ARP spoofing is a **Layer 2** attack confined to a **single broadcast domain**. It does not cross routers. If the question puts the attacker on a different subnet and asks about ARP poisoning, the answer is "not possible without an L2 foothold." DNS poisoning or BGP hijacking — different protocols, different layers — are the cross-segment equivalents.

> **CompTIA exam trap:** **ARP poisoning** and **ARP spoofing** are used interchangeably on the exam. **MAC flooding** is the CAM-table attack, separate concept. **MAC spoofing** is changing your own NIC's MAC. Three different things, easy to blur.

### IPv6 note

ARP is IPv4-only. The IPv6 equivalent is **NDP (Neighbor Discovery Protocol)** using ICMPv6. NDP has the same trust problem — see **NDP spoofing** and **RA guard** as the defense. CompTIA may test the equivalence.

## SOC reality

- The 3am alert is rarely "ARP spoofing detected." It's **"Splunk: spike in failed SMB auth from 10 hosts to one workstation IP"** or **"Cisco ISE: 38 port-security violations on access-switch-7 in 90 seconds."** You pivot from the symptom to the wire. *I once chased "intermittent gateway latency" for two days before someone thought to run arp-scan from the affected VLAN. The "gateway" was a Kali box in a wiring closet, plugged in by a contractor who left on Friday.*
- L1's first move: pull the switch port from the reported host, get the MAC table from the access switch (`show mac address-table`), get the ARP table from the gateway (`show ip arp`), look for duplicate IP claims and unexpected MAC OUIs. Don't reboot anything yet — you want the volatile state preserved.
- The IR lead asks three things: **"Is the attacker still on the wire? What did they see? Do we have packet capture for the window?"** If the answer to question three is no, that's a post-incident lesson — your TAP/SPAN coverage didn't reach the affected segment.
- Never promise leadership "we contained it" the moment you shut the port. The attacker may have already pivoted off-segment using harvested credentials. Containment of the ARP attack is not containment of the intrusion.
- Escalation: L1 isolates the port and preserves the switch state. L2 / network engineering pulls the device, images it, checks neighboring ports for the same OUI pattern. IR pulls authentication logs for every account that traversed the affected segment in the last 24 hours and forces resets. Legal gets a heads-up if cleartext PII or credentials were on the wire.

## Related concepts

[[MITM attack]] · [[MAC flooding]] · [[DHCP snooping]] · [[Dynamic ARP Inspection]] · [[Port security]] · [[802.1X]] · [[NDP spoofing]] · [[NTLM relay]] · [[SSL stripping]] · [[Network segmentation]] · [[Rogue device detection]] · [[Packet capture]] · [[Wireshark]] · [[NetFlow analysis]] · [[Lateral movement]] · [[Credential harvesting]] · [[Cyber Kill Chain]]

*Source: VIRGIL knowledge base — 2026-05-11*