# CCNA 200-301 — Index

## What it is

The skill tree screen in a sprawling RPG — Path of Exile, Elden Ring, Cyberpunk 2077 — where every node you unlock connects to three more, and you slowly realize the build is the entire game. That's this index. CCNA 200-301 is Cisco's associate-level networking certification, and this is the master node graph: 183 notes covering every required concept from "what is a cable" to "why does BGP exist and why is everyone always angry about it."

The exam itself is vendor-specific (Cisco IOS, Cisco hardware quirks) but the underlying knowledge is universal — IP, Ethernet, routing, switching, wireless, security, automation. Pass it and you can talk shop with any network engineer regardless of what gear they run.

## Why it matters

Networks are the dungeon every modern attack and every modern service runs through. Watch Dogs makes hacking look like a minigame; CCNA is the part where you learn what's actually behind the minigame — the switches that forward your packets, the routers that pick paths, the protocols that quietly fall over when someone misconfigures a trunk port.

For defenders, this is the floor. You can't secure what you can't diagram. For builders, automation and cloud (Terraform, Ansible, REST APIs) sit directly on top of these primitives. For gamers wondering why their ping spikes during a Marvel Rivals match — every concept in this index is a candidate suspect.

## Key facts

### Foundations — the tutorial zone
- **Network Devices** — routers, switches, firewalls, APs. The party composition before you pick a class.
- **Interfaces and Cables** — copper, fiber, the physical layer. Whether your mouse is plugged in.
- **OSI Model and TCP/IP Suite** — the seven-layer (or four-layer) reference frameworks. The HUD that tells you which layer is on fire.
- **Cisco IOS CLI** — the terminal you live in. No GUI safety net, just `enable`, `configure terminal`, and consequences.
- **Ethernet** — Layer 2 LAN tech. Hubs flood every port like a Helldivers 2 grenade with no aiming; switches forward by MAC address like a vending machine that knows which slot dispenses what.

### Layer 2 — switching and VLANs
- **Ethernet LAN Switching** — frames in, frames out, MAC table in the middle.
- **VLANs** — logical Layer 2 segmentation. Same physical switch, different broadcast domains, like separate Discord servers running on the same laptop.
- **STP / RSTP** — Spanning Tree Protocol prevents loops; Rapid STP converges faster. Without it, one bad cable creates a broadcast storm that nukes the whole LAN.
- **DTP** — Dynamic Trunking Protocol auto-negotiates trunk status between switches.
- **VTP** — VLAN Trunking Protocol syncs VLAN databases. Powerful, occasionally catastrophic.
- **EtherChannel** — bundles multiple physical links into one logical pipe. Two cables, one HP bar.
- **Port Security** — locks switch ports to specific MAC addresses.
- **CDP / LLDP** — neighbor discovery. CDP is Cisco-only; LLDP is the open standard.

### Layer 3 — IP addressing and routing
- **IPv4 Addressing** — 32-bit addresses, ~4.3 billion total, allegedly ran out years ago.
- **IPv6 Addressing** — 128-bit addresses, enough for every grain of sand to host its own Minecraft server.
- **IPv4 Header** — source, destination, TTL, protocol field. The shipping label.
- **Subnet Mask / CIDR / IP Subnet** — three views of the same idea: where the network part ends and the host part begins.
- **IPv4 Subnetting** — slicing a /24 into /26s, /27s, etc. The math problem that haunts every CCNA candidate.
- **Router and Switch Interfaces** — where Layer 1 meets Layer 2/3.
- **Routing Fundamentals / Routing Table** — longest-prefix match decides the next hop.
- **Static Routing** — you type the routes. No surprises, no scaling.
- **Dynamic Routing** — protocols learn the topology themselves.
  - **EIGRP** — Cisco's hybrid protocol, fast convergence.
  - **OSPF** — link-state, open standard, runs the internals of most large enterprises.
  - **BGP** — the protocol that holds the internet together with duct tape and policy.
- **FHRP / HSRP** — First Hop Redundancy. Two routers share a virtual gateway IP so your default route survives one of them dying mid-match.

### Services that quietly run everything
- **DHCP** — hands out IP addresses on demand. The check-in desk at a hotel.
- **DHCP Snooping** — switch-level filter that blocks rogue DHCP servers from poisoning the lobby.
- **ARP** — resolves IP to MAC at Layer 2. "Who has 10.0.0.1? Tell me your MAC."
- **Gratuitous ARP** — unsolicited ARP reply, used for failover or, less politely, attacks.
- **Dynamic ARP Inspection** — validates ARP messages against the DHCP snooping table.
- **NTP** — clock sync. Without it, your logs lie about when things happened.
- **SNMP** — pull telemetry from devices.
- **Syslog** — push log messages to a collector. Severity 0 is "the building is on fire."
- **TFTP / FTP / SSH** — file transfer (no auth / with auth) and encrypted remote shell. Telnet is dead; long live SSH.

### DNS — its own cinematic universe
- **DNS** — application-layer name resolution. The contact list for the internet.
- **DNSSEC / DNS validation / Cryptographic Signature** — signed records so you can detect tampering.
- **DNS over TLS** — encrypts queries in transit so your ISP stops reading your browser history.
- **DNS CAA Records** — restrict which CAs can issue certs for your domain.
- **DNS TXT Records** — free-form text; SPF, DKIM, domain verification all live here.
- **DNS Filtering / DNS Group Policy Settings** — block categories of domains, enforce client config.
- **Technitium DNS Server** — open-source self-hostable DNS implementation.
- **DNS attacks** — Spoofing, Cache Poisoning, Rebinding, Tunneling, Amplification, Enumeration, Hijacking. DNS is the most-abused service on the internet because everything trusts it by default.

### Security — the part that pays the bills
- **ACLs** — Access Control Lists, packet filters with line numbers.
- **NAT** — translates private IPs to public. The reason your Xbox needs UPnP to host a lobby.
- **Screened Subnet** — DMZ architecture, public-facing services isolated from the internal LAN.
- **VLAN Hopping / STP Manipulation** — Layer 2 attacks that exploit trunk misconfig and spanning-tree elections.
- **On-path attacks** — sit between two parties, read/modify traffic. The classic MITM.
- **Brand Impersonation / Token Impersonation / Windows Impersonation Token** — pretending to be someone you aren't, at varying levels of the stack.
- **Path Traversal / Uncontrolled Search Path Element / Unquoted Service Path** — file-system and Windows-service exploits.
- **Synchronizer Token Pattern** — anti-CSRF defense.
- **Subject Alternative Name** — cert field that lists all valid hostnames.
- **Signature-Based Detection / Threat Signature / Pattern Matching / Regex Pattern Matching** — IDS/IPS detect known-bad patterns. Misses novel attacks, catches script kiddies.
- **QoS** — prioritizes voice/video over bulk transfer. Your Zoom call jumps the queue ahead of a Steam download.
- **Nation-State Actors** — APTs with budgets, patience, and zero-days.
- **LastPass** — password manager, also a cautionary tale about vault breaches.

### Wireless
- **IEEE 802.11** — the Wi-Fi standard family (a/b/g/n/ac/ax/be).
- **Wireless LAN Fundamentals / Architectures / Configuration / Security** — RF basics, autonomous vs. controller-based APs, SSID setup, encryption.
- **WPA3-802.1X** — enterprise wireless auth using a RADIUS backend, no shared password.

### Modern stack — automation and cloud
- **LAN Architectures** — two-tier, three-tier, spine-leaf design patterns.
- **Cloud Computing** — IaaS/PaaS/SaaS, the rented dungeon model.
- **Network Automation** — replacing CLI tedium with code.
- **REST APIs** — HTTP-based programmability; how modern controllers expose config.
- **Data Formats** — JSON, YAML, XML. The save-file formats of automation.
- **Ansible** — agentless, push-based config management via SSH.
- **Terraform** — declarative infrastructure-as-code, you describe the end state and it diffs.

## Related concepts
[[OSI Model]] · [[TCP IP Suite]] · [[Ethernet]] · [[VLAN]] · [[Spanning Tree Protocol]] · [[OSPF]] · [[BGP]] · [[DHCP]] · [[DNS]] · [[NAT]] · [[Access Control Lists]] · [[IEEE 802.11]] · [[WPA3]] · [[Network Automation]] · [[REST APIs]] · [[Ansible]] · [[Terraform]] · [[Cisco IOS CLI]] · [[IPv4 Subnetting]] · [[IPv6 Addressing]]