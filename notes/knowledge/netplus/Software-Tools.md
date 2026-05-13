# Software Tools

## What it is

In **Metal Gear Solid**, Snake doesn't just kick down the door to Shadow Moses. He crouches behind a crate with a pack of cigarettes — the infrared from the smoke reveals trip lasers. He taps walls to draw guards toward sound. He calls Otacon on the codec to ask what a PAL card actually does. Every tool in his kit answers one question: *what's actually happening on the other side of that wall before I commit to a move?*

That's exactly what networking software tools do — they let you see what's happening on a wire, a port, or a route before you start swapping hardware or rebooting routers at 2am.

Technically, software tools for network troubleshooting are command-line utilities, protocol analyzers, and diagnostic applications that collect evidence about [[OSI Model]] layers 2 through 7. They tell you whether a host is reachable, what path packets take, what's listening on a port, what DNS actually returned, and what the wire looks like at the byte level. N10-009 Objective 5.5 expects you to know which tool answers which question.

## Why it matters

Ninety percent of network tickets are solved by three commands run in the right order. The tech who knows `ping`, `traceroute`, and `ipconfig` cold resolves tickets in three minutes. The tech who doesn't escalates everything and burns out in six months.

On the exam, CompTIA gives you a scenario — "user reports slow connection to internal server" — and four tools. You pick the right one. No partial credit for "I would also run Wireshark." Pick the tool that answers the specific question in the stem. Same discipline in the field: you don't capture 40GB of packets when a `ping` would have told you the host was off.

## Key facts

### The reachability layer — ping, traceroute, pathping

| Tool | What it does | Protocol | Reads as |
|---|---|---|---|
| **ping** | Sends ICMP echo request, waits for echo reply | ICMP | "Is it alive? How far away?" |
| **traceroute** (Linux/macOS) | Maps every hop using incrementing TTL | UDP by default | "Where does the path break?" |
| **tracert** (Windows) | Same as traceroute, but ICMP by default | ICMP | Same |
| **pathping** (Windows) | traceroute + ping at every hop over time | ICMP | "Which hop is dropping packets?" |

Ping tells you reachability and round-trip time. Traceroute tells you the path. If ping fails but traceroute makes it 12 hops in, the firewall at hop 13 is blocking ICMP echo to the host but allowing TTL-expired replies — classic ACL misconfiguration. *If your traceroute shows asterisks at every hop past hop 3, you're not finding the problem — the firewall is blocking your visibility tools.*

### The name resolution layer — nslookup and dig

[[DNS]] failures look like network failures. The user says "the internet is down" but they can ping 8.8.8.8 just fine.

- **nslookup** — Windows and Linux. `nslookup mail.company.com` returns the A record from your configured resolver. Use `nslookup mail.company.com 8.8.8.8` to bypass your local resolver — if the answer differs, your internal DNS is the problem.
- **dig** — Linux/macOS, more verbose. `dig +short`, `dig MX company.com`, `dig @8.8.8.8 company.com` for explicit resolver. Shows full DNS response including authority and additional sections that nslookup hides.

> **CompTIA exam trap:** nslookup and dig both query DNS, but dig is Linux-preferred and shows record TTLs and authority sections. If the question specifies "detailed DNS response on a Linux server," the answer is dig.

### The local-host layer — ipconfig, ifconfig, ip

| Command | OS | Shows |
|---|---|---|
| **ipconfig** | Windows | IP, mask, gateway, DNS. `/all` adds MAC and DHCP lease. `/release` `/renew` `/flushdns` |
| **ifconfig** | Older Linux/macOS | Interface IP, MAC, errors — being deprecated |
| **ip** | Modern Linux | `ip addr`, `ip route`, `ip link` — replaces ifconfig |

If `ipconfig` shows 169.254.x.x, the host failed to reach a [[DHCP]] server and self-assigned [[APIPA]]. That's a layer 2 problem masquerading as a layer 3 problem — check the cable, the switchport, the VLAN.

### The connection-state layer — netstat, arp

- **netstat** — active connections and listening ports. `netstat -an` is the workhorse. `netstat -rn` shows the routing table. `netstat -b` (Windows, admin) shows which process owns each socket. If a server is "slow," netstat tells you whether it has 40,000 connections in TIME_WAIT.
- **arp** — `arp -a` dumps the local ARP cache. If two hosts claim the same IP, ARP cache shows the MAC flapping — duplicate IP or ARP-spoofing attack.

### The wire-level layer — tcpdump, Wireshark

When you've ruled out the easy stuff, you read the packets.

- **tcpdump** — Linux CLI packet capture. `tcpdump -i eth0 -nn host 10.1.1.5 and port 443 -w capture.pcap`. Lightweight, runs on routers and servers, dumps to .pcap.
- **Wireshark** — GUI protocol analyzer. Opens the .pcap, decodes every protocol, lets you "follow TCP stream" to see the actual conversation. Filters are critical — `tcp.analysis.retransmission` instantly shows lossy flows.

A **protocol analyzer** doesn't fix anything. It tells you what's actually on the wire so you can prove the application team's "the network is dropping our packets" claim is wrong (or right). *The packet capture is your evidence. It ends arguments.*

### Discovery and security scanning — Nmap

**Nmap** scans hosts and ports. `nmap -sS -p- 10.1.1.0/24` does a SYN scan of all 65535 ports on a /24. Use cases: finding rogue devices, verifying a firewall blocks what you think it blocks, inventorying exposed services before an audit.

Nmap on a production network without change approval is a fireable offense at some shops. *Scan in a lab. Get written authorization for production. Document the window.*

### Wi-Fi analyzers and speed testers

- **Wi-Fi analyzer** — shows SSIDs, signal strength (RSSI in dBm), channel occupancy, overlap. The 2.4 GHz band only has three non-overlapping channels: 1, 6, 11. Eight neighboring APs on channel 3 is the problem. See [[Wireless Troubleshooting]].
- **Speed tester** — Ookla, fast.com test internet path to a CDN. iperf3 tests LAN throughput between two hosts you control. User says "my internet is slow"? Speedtest from their machine, then from a wired host on the same subnet. Wired fine and Wi-Fi slow means the AP or channel, not the WAN.

### Basic networking device commands (the show commands)

On Cisco IOS and most network OSes, `show` commands are read-only. Memorize these.

| Command | What it returns |
|---|---|
| **show config** / `show running-config` | Current device configuration in memory |
| **show interface** | Per-interface: up/down, errors, CRC, duplex, speed |
| **show mac-address-table** | MACs the switch has learned on which ports |
| **show arp** | IP-to-MAC mappings the router has resolved |
| **show route** / `show ip route` | Routing table — connected, static, learned |
| **show vlan** | VLAN database and port assignments |
| **show power** | PoE budget, per-port draw, faults — see [[PoE Standards]] |
| **show lldp neighbors** | What's connected to each port via [[LLDP]] |

`show lldp neighbors` tells you "port Gi0/4 connects to switch SW-FLOOR2-IDF, port Gi0/12" without walking the cable. This is how you map an undocumented network.

> **CompTIA exam trap:** `show mac-address-table` is on a switch (layer 2 — it learns MACs). `show arp` is on a router or any L3 device (layer 3 — it resolves IPs to MACs). Don't swap them.

### Hardware tools (briefly — they pair with software)

- **Cable tester** — verifies pinout continuity. Pairs with `show interface` showing CRC errors.
- **Toner and probe** — find which cable in the patch panel goes to which wall jack. First tool you grab in an undocumented closet.
- **Visual fault locator (VFL)** — red laser into a fiber. Where the light leaks out, the fiber is broken.
- **TAP (Test Access Point)** — physical inline device that mirrors traffic to a capture port without affecting flow. Professional alternative to SPAN/mirror ports for [[Packet Capture]]. A TAP can't drop frames under load; a SPAN port can.

### CompTIA exam traps

> **CompTIA exam trap:** ping uses **ICMP**. tracert (Windows) uses ICMP. traceroute (Linux) uses **UDP** by default. If a firewall blocks UDP high ports but allows ICMP, Linux traceroute fails where Windows tracert succeeds. CompTIA tests this exact scenario.

> **CompTIA exam trap:** netstat is being deprecated on modern Linux in favor of `ss`. The N10-009 still tests netstat — know both names exist, but netstat is the exam answer.

> **CompTIA exam trap:** A TAP and a SPAN/mirror port both copy traffic to an analyzer. TAP is hardware, passive, lossless. SPAN is a switch feature, software, can drop frames under load. If the stem says "must not miss frames," answer TAP.

## Helpdesk reality

- User says "the internet is down." First check: `ipconfig /all`. APIPA address? DHCP problem. Real IP, no gateway? Static config wrong. Real IP and gateway, can't ping gateway? Layer 1 or 2 — check the cable and the link light before you touch anything else.
- User says "this one website doesn't work, but everything else does." Run `nslookup` against the site. If DNS resolves but ping fails, the site is down — not your problem. Send the screenshot.
- User says "the VPN is slow." Speed test from their location to a known endpoint, then from inside the office. If their home internet is 8 Mbps, the VPN can't be faster. Don't promise an SLA you don't own.
- Never promise a fix time during active troubleshooting. "I'm investigating and I'll update you in 15 minutes" is the answer. *The user wants to be heard, not lied to.*
- If you've run ping, traceroute, nslookup, and ipconfig and the problem is upstream of the user's router, it's a network team ticket. Document what you ran, attach the output, escalate. The ticket with `traceroute` output attached gets worked first.

## Related concepts

[[OSI Model]] · [[DNS]] · [[DHCP]] · [[APIPA]] · [[Packet Capture]] · [[LLDP]] · [[PoE Standards]] · [[Wireless Troubleshooting]] · [[Network Troubleshooting Methodology]] · [[ICMP]] · [[Subnetting]]

*Source: VIRGIL knowledge base — 2026-05-11*