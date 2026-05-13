# Command Line Tools

## What it is

In **NBA 2K**, when your MyTeam lineup is suddenly playing like trash, you don't rage-quit — you open the player card. Stamina bar. Hot zones. Badge loadout. Defensive matchup. You diagnose the breakdown one stat at a time until you find the rookie center your opponent is exploiting on every pick-and-roll. That's exactly what command line tools do for a network — they let you open the player card on every layer of the stack until you find the one that's bricked.

In plain English: command line tools are the diagnostic utilities a network tech uses to inspect, test, and probe a network from a terminal. Some live on every OS (`ping`, `traceroute`, `ipconfig`). Some live on switches and routers (`show interface`, `show mac-address-table`). Some are dedicated software like Nmap and tcpdump. Some are physical hardware you carry in a bag — cable testers, toners, Wi-Fi analyzers.

Technically: per N10-009 Objective 5.5, these are the **software tools, hardware tools, and basic device commands** a candidate must know to solve networking issues, mapped to the 7-step CompTIA troubleshooting methodology.

## Why it matters

Every network ticket eventually comes down to evidence collection. The user says "the internet is broken." That's a symptom. Your job is to convert symptom into root cause, and the command line is where that conversion happens. You cannot fix what you cannot see, and GUIs hide more than they show.

On the exam, CompTIA will hand you a scenario — packets dropping between two subnets, a workstation that gets an IP but can't resolve DNS, a switch port that's up but passing no traffic — and ask which tool you reach for first. Wrong tool = wrong answer. Knowing `dig` vs `nslookup`, `traceroute` vs `tracert`, `netstat` vs `ss`, and `show interface` vs `show mac-address-table` is the difference between a passing score and a re-test.

## Key facts

### Host-side commands (the ones on every laptop)

| Command | OS | What it does |
|---|---|---|
| `ping` | All | ICMP echo request/reply. Layer 3 reachability test. |
| `tracert` | Windows | Hop-by-hop path trace using ICMP. |
| `traceroute` | Linux/macOS | Same idea, uses UDP by default (Linux) or ICMP (macOS with `-I`). |
| `ipconfig` | Windows | Shows interface IP, mask, gateway, DNS. `/all` for MAC + DHCP lease. `/release` `/renew` `/flushdns`. |
| `ifconfig` | Linux/macOS (legacy) | Interface config. Deprecated on modern Linux. |
| `ip` | Linux (modern) | Replaces `ifconfig`. `ip addr`, `ip route`, `ip link`. |
| `arp` | All | Shows the [[ARP]] cache. `arp -a` lists IP-to-MAC mappings. |
| `nslookup` | All | DNS query tool. Interactive or one-shot. |
| `dig` | Linux/macOS (and Windows if installed) | Better DNS tool. More detail, scriptable output. |
| `netstat` | All | Active connections, listening ports, routing table. `-an` is the most useful flag. |
| `nmap` | All (install) | Port scanner. Host discovery, service detection, OS fingerprinting. |
| `tcpdump` | Linux/macOS | CLI packet capture. The protocol analyzer for terminals. |

**[[ping]]** is the first thing you run, always. It tells you if [[Layer 3]] reachability exists and gives you a rough latency number. `ping -t` on Windows runs continuously. `ping -c 4` on Linux limits count. *If ping to the default gateway fails, you're not getting off the subnet — stop debugging DNS.*

**[[traceroute]]/tracert** shows the path. Each hop is a router. Stars (`* * *`) mean a hop didn't respond to ICMP — not necessarily broken, just filtered. The hop where latency jumps from 10ms to 200ms and stays there is your problem hop. Path asymmetry is real: the return path can differ from the forward path, which is why traceroute sometimes lies about where the actual loss is.

**[[nslookup]] vs [[dig]]** — both query DNS. `nslookup` is universal and simpler. `dig` gives you full record data (TTL, authoritative section, query time) and is the pro tool on Linux. CompTIA wants you to know both exist and that they answer the question "is DNS resolving correctly for this name?"

**[[netstat]]** with `-an` shows every socket on the box — listening ports, established connections, foreign addresses. This is how you find that mystery process beaconing out to a sketchy IP. Modern Linux uses `ss` but CompTIA still tests `netstat`.

**[[ARP]]** cache poisoning is a real attack ([[On-Path Attack]]). `arp -a` shows the current mappings. Two IPs sharing one MAC, or the gateway MAC suddenly changing — those are red flags.

### Device-side commands (the ones on switches and routers)

These run on the CLI of a managed switch or router after you've SSH'd or consoled in.

| Command | What it shows |
|---|---|
| `show interface` | Port status, speed/duplex, errors, CRCs, input/output rates |
| `show mac-address-table` | MAC-to-port mapping — which device is on which switchport |
| `show arp` | Device's ARP cache — IP-to-MAC at L3 |
| `show route` (or `show ip route`) | Routing table — directly connected, static, OSPF, BGP routes |
| `show vlan` | [[VLAN]] assignments per port, trunk status |
| `show config` (or `show running-config`) | Current device config in memory |
| `show power` (on PoE switches) | Per-port [[PoE]] budget, draw, class |
| `show lldp neighbors` | [[LLDP]] discovery — what's plugged into the other end |

**`show interface`** is the single most useful switch command. If a port shows `down/down`, layer 1 is broken (cable, NIC, or SFP). If it shows `up/down`, layer 1 is fine but L2 isn't negotiating. CRC errors mean a bad cable, dirty fiber, or duplex mismatch. Input drops mean the port is oversubscribed.

**`show mac-address-table`** answers "which port is this MAC plugged into?" — essential when you're hunting a rogue device or chasing a [[MAC Flooding]] event.

**[[LLDP]]** (Link Layer Discovery Protocol) and Cisco's proprietary CDP let neighbor switches advertise themselves. `show lldp neighbors` tells you what's on the other end of every uplink — invaluable when the wiring closet is a snake pit and the labels fell off in 2017.

### Hardware tools (the ones in your bag)

| Tool | Use |
|---|---|
| **Cable tester** | Verifies pinout, continuity, and basic wire-map on copper. Catches miswires and breaks. |
| **Toner (tone generator + probe)** | Trace a cable through walls and bundles. Inject a tone on one end, find it with the wand on the other. |
| **Visual fault locator (VFL)** | Red laser injected into fiber. Light leaks at the break point. Quick L1 fiber check. |
| **Optical TDR (OTDR)** | The grown-up version of VFL. Measures fiber loss and pinpoints break distance. |
| **Wi-Fi analyzer** | Shows SSIDs, channels, signal strength, channel overlap. Free apps on phones; pro versions on laptops. |
| **Protocol analyzer (Wireshark + a tap)** | Captures and decodes packets. The GUI cousin of tcpdump. |
| **Network tap** | Hardware device inserted inline that mirrors traffic to a monitoring port. Better than [[SPAN]]/port mirror for high-traffic links. |
| **Speed tester** | Measures throughput against a server (speedtest.net, iperf3). Tests perceived bandwidth, not raw link speed. |

*A cable tester tells you the wires are connected. It does NOT tell you the cable meets Cat6 spec at 100m. For that you need a certifier — different tool, different price tag.*

### CompTIA exam traps

> **CompTIA exam trap:** `tracert` is Windows, `traceroute` is Linux/macOS. They use **different protocols by default** — Windows uses ICMP, Linux uses UDP high ports. If a firewall blocks UDP but allows ICMP, Linux traceroute fails where Windows tracert succeeds. CompTIA loves this.

> **CompTIA exam trap:** `nslookup` and `dig` both query DNS, but on the exam, if the answer choices include "get the authoritative server, TTL, and query time in one shot" — that's `dig`. `nslookup` is the cross-platform fallback.

> **CompTIA exam trap:** A **toner** finds the cable. A **cable tester** verifies the cable works. A **visual fault locator** finds breaks in fiber. They are three different tools and CompTIA will give you a scenario that fits exactly one.

> **CompTIA exam trap:** A **tap** is hardware that copies traffic passively. A **SPAN/port mirror** is a switch config that does the same in software. Taps don't drop packets under load; SPAN ports can. For forensic-grade capture, the answer is tap.

> **CompTIA exam trap:** `netstat -an` shows numeric addresses and ports. `netstat -r` shows the routing table. `netstat -b` (Windows) shows the binary that owns each socket. Know the flags.

## Helpdesk reality

- User says **"the internet is down."** You run `ipconfig /all`. They have a 169.254.x.x address — [[APIPA]]. DHCP isn't reaching them. Check the cable, then the switchport, then the DHCP scope.
- User says **"this one website is broken, everything else works."** You `ping` the site by name. Name fails. You `ping` it by IP. IP works. It's DNS. `nslookup` confirms. Flush their resolver, point to 8.8.8.8 as a test.
- User says **"my voice is choppy on Teams."** You don't open Teams. You run a continuous `ping` to the gateway, then to 8.8.8.8, then to the Teams edge. The hop where latency spikes and jitter appears is your suspect.
- Never promise **"five minutes"** to a user. The cable run from their desk to the IDF is 60 meters and you haven't been in that closet since the last hire. Promise an update window, not a fix time.
- Escalation rule: if `ping`, `tracert`, `ipconfig`, and `nslookup` from the client all look clean and the problem persists, it's not the client. Hand it to the network team with your evidence — the ticket moves faster when you've already ruled out the obvious.

## Related concepts

[[Ping]] · [[Traceroute]] · [[DNS]] · [[DHCP]] · [[ARP]] · [[Netstat]] · [[Nmap]] · [[Tcpdump]] · [[Wireshark]] · [[LLDP]] · [[VLAN]] · [[PoE]] · [[CompTIA Troubleshooting Methodology]] · [[OSI Model]] · [[Cable Testing]] · [[Wi-Fi Analyzer]] · [[SPAN and Port Mirroring]] · [[Network Taps]]

*Source: VIRGIL knowledge base — 2026-05-11*