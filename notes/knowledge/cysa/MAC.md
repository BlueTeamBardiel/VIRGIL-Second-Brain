# MAC — Media Access Control

## What it is

In **Cyberpunk 2077**, every car in Night City has a plate. When NCPD scans you, they don't care about your name, your gonk haircut, or whether you've got chrome in your skull — they pull the plate and the registration tied to it. Burn a plate, swap it, run stolen tags, and the dispatch AI loses the thread until somebody clocks the chassis manually. Same with cyberdecks: every netrunner you ICE-pick has a hardware signature the daemon traces back through the subnet. V can spoof a lot of things in that game. The physical address bolted to the network interface is the one identifier the city actually trusts at the gate.

That's exactly what a **MAC address** is — the plate on every network interface, burned in at the factory, used by switches to decide which port your frame leaves on.

**Technical definition:** A Media Access Control address is a 48-bit hardware identifier assigned to a network interface controller (NIC), operating at **Layer 2 (Data Link)** of the OSI model. Written as six hex octets (`00:1A:2B:3C:4D:5E`). The first three octets are the **OUI** (Organizationally Unique Identifier — vendor code, assigned by IEEE). The last three are the vendor-assigned host ID. Switches use MACs to build their **CAM table** (Content Addressable Memory) and forward frames. Routers don't care — they hand off to MACs only on the final hop within a broadcast domain.

For CySA+ you need to know MACs as a network architecture primitive: how they're used legitimately, how attackers abuse them, and how the SOC sees that abuse in logs.

## Why it matters

MAC addresses sit at the foundation of [[Network Architecture]] and show up in nearly every Domain 1.0 conversation about segmentation, [[NAC]] (network access control), and [[Zero Trust]]. They're also the cleanest example of an identifier that **looks authoritative but isn't** — every modern OS can spoof its MAC with a single command. A junior analyst who treats a MAC in a DHCP log as a confirmed device identity is the same analyst who later says "we're contained" when they're not.

CompTIA tests MAC concepts under **Objective 1.1** (system and network architecture) as part of [[Network Segmentation]], [[Identity and Access Management]], and infrastructure fundamentals. Expect questions on MAC flooding, MAC spoofing, port security countermeasures, and the difference between Layer 2 and Layer 3 identifiers when log correlation goes sideways.

In the SOC, MACs are forensic gold for the first 30 seconds of an incident and forensic garbage after that. Knowing which is which is the job.

## Key facts

### Address structure

| Field | Bits | Example | Meaning |
|---|---|---|---|
| OUI | 24 | `00:1A:2B` | IEEE-assigned vendor (lookup at standards.ieee.org) |
| NIC-specific | 24 | `3C:4D:5E` | Vendor-assigned host ID |
| I/G bit | 1 (in OUI) | 0 = unicast, 1 = multicast | Least-significant bit of first octet |
| U/L bit | 1 (in OUI) | 0 = universal (burned-in), 1 = locally administered | Second-least-significant bit of first octet |

The **U/L bit** is the spoofing tell. When that bit flips to 1, the MAC was set by software, not assigned by the manufacturer. Some EDR tools and NAC platforms flag locally administered MACs as suspicious by default. Worth knowing — and worth knowing why it's noisy, since modern phones randomize MACs for privacy on every Wi-Fi probe.

### Special MAC ranges

- **Broadcast:** `FF:FF:FF:FF:FF:FF` — every NIC on the segment processes it. ARP requests live here.
- **Multicast:** First octet has the I/G bit set (e.g., `01:00:5E:xx:xx:xx` for IPv4 multicast).
- **Unicast:** Everything else — point-to-point Layer 2.

### MAC vs IP — the layer split that trips people up

| Property | MAC | IP |
|---|---|---|
| OSI Layer | 2 (Data Link) | 3 (Network) |
| Scope | Local broadcast domain only | Routable globally |
| Persistence | Burned-in (or spoofed) | Assigned via DHCP or static |
| Forensic value | Identifies NIC within a subnet | Identifies host across subnets |
| ARP binds them | resolves IP → MAC on local segment | — |

Once a frame crosses a router, the source MAC is rewritten to the router's egress interface MAC. The original MAC is gone. **This is why MAC-based forensic correlation only works within a single broadcast domain.**

### Attacks targeting MAC

**MAC flooding (CAM table overflow).** Attacker floods a switch with fake source MACs until the CAM table fills. The switch then **fails open** — broadcasting all unknown-destination frames out every port like a dumb hub. Now the attacker sniffs everything on the segment. Tool of choice: `macof` from the dsniff suite.

> **CompTIA exam trap:** MAC flooding causes a switch to behave like a **hub**, not a router. The exam will offer "router" or "bridge" as plausible-sounding wrong answers. The switch fails open to broadcast mode — that's the hub behavior.

**MAC spoofing.** Attacker changes their NIC's MAC to impersonate an authorized device. Used to bypass MAC-filtering Wi-Fi, evade NAC posture checks, or pivot after stealing credentials from a printer's network jack. On Linux: `ip link set dev eth0 address xx:xx:xx:xx:xx:xx`. On Windows: registry edit under `HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972...}` — a [[Windows Registry]] artifact worth knowing for forensics.

**ARP spoofing / poisoning.** Attacker sends gratuitous ARP replies binding their MAC to the gateway's IP. Now all egress traffic from the subnet flows through them. Foundation of on-path (MitM) attacks on a LAN. Defenses: **Dynamic ARP Inspection (DAI)** on managed switches, plus **DHCP Snooping** to build the trusted binding table.

### Defenses — the port-security stack

- **Port security:** Limit MACs per switch port. Violation actions: `shutdown`, `restrict`, `protect`. Standard build for any port a user can physically touch.
- **802.1X:** Authenticate the device (and/or user) before the port becomes active. Pairs with RADIUS and a certificate-backed [[PKI]]. This is what real [[NAC]] looks like — MAC filtering is the kiddie version.
- **DHCP Snooping + DAI:** Trust only the ports where the real DHCP server lives; reject ARP responses that don't match the snooping table.
- **Private VLANs:** Segment hosts within the same subnet so they can't talk to each other directly — useful in guest networks and server VLANs where east-west traffic isn't legitimate.
- **MACsec (802.1AE):** Layer 2 encryption between switch and endpoint. Stops passive sniffing even if the CAM table is compromised. Pairs with the broader [[Encryption]] story for [[Network Architecture]].

### MAC in [[Zero Trust]] and [[NAC]]

Zero trust says **never trust the network identifier alone**. A MAC is a starting signal, not an authenticator. Modern NAC stacks (Cisco ISE, Aruba ClearPass, Forescout) use MAC as one signal in a posture decision that also includes:

- 802.1X authentication result
- Certificate validity from the [[PKI]]
- Endpoint posture from EDR (patch level, AV state, disk encryption)
- User identity via [[IAM]] / [[SSO]] / [[Federation]]
- Behavioral signals from [[SIEM]] correlation

A device with a known-good MAC but a failing posture check still gets quarantined to a remediation VLAN. MAC alone unlocks nothing.

### MAC randomization — the privacy era

iOS, Android, Windows 11, and macOS all randomize MAC per SSID (or per probe) by default. This breaks MAC-based asset tracking, breaks legacy MAC-filter Wi-Fi, and breaks lazy DHCP-log forensics. The fix is to stop treating MAC as identity. Enroll devices into MDM, issue certificates, and key your inventory off the cert — not the plate.

> **CompTIA exam trap:** MAC randomization is a **privacy feature**, not an attack. If the exam shows a device whose MAC changes between connections to different SSIDs, the answer is "expected behavior on a modern OS" — not "compromise" or "spoofing attack."

### Where MAC shows up in logs

| Source | Field | Value to the SOC |
|---|---|---|
| DHCP server | `chaddr` (client hardware address) | First sighting of a device on the network |
| Switch CAM table | MAC ↔ port mapping | Physical location — *which jack, which floor* |
| Wireless controller | Associated client MACs | Same, for Wi-Fi |
| NAC platform | Auth events, posture results | Whether the device was allowed in |
| EDR | Local NIC inventory | Ground truth from the endpoint itself |
| Firewall | Sometimes in connection logs (Layer 2 firewalls) | Rare, but useful when present |

The DHCP log + switch CAM table is the classic pivot: "alert fires on IP `10.4.12.88` at 02:14 — DHCP says MAC `b8:27:eb:...` (Raspberry Pi OUI — *interesting*), CAM table says port `Gi1/0/24` on the third-floor switch, physical map says that jack is in a conference room." That's the 90-second forensic chain. *Time synchronization across DHCP, switch, and SIEM is non-negotiable for this chain to hold — NTP drift turns this into a guessing game.*

## SOC reality

- The first thing you do with an unknown internal IP is resolve the MAC from DHCP logs, then OUI-lookup the vendor. A Raspberry Pi, Hak5 device, or unknown vendor in a corporate VLAN is a signal — sometimes a rogue device, sometimes IT didn't tell you about the new IoT pilot.
- L1 triage on a "rogue device" alert: confirm MAC against asset inventory, pull switch port from CAM table, check NAC for auth result, check EDR for an agent. Four signals, two minutes. If three of four say "unknown" — escalate.
- The CISO does not want to hear "the MAC checked out." They want to hear "the device authenticated via 802.1X with a valid cert and passed posture." MAC alone is a yearbook photo — useful for ID, not for authentication.
- Never promise leadership that a MAC-blocked device is "contained." A laptop with a USB Ethernet dongle has two MACs. A determined attacker has as many MACs as `ip link` will let them set.
- Post-incident, MAC evidence has a short half-life. CAM tables age out (default 300 seconds on Cisco). DHCP lease logs roll. *If you don't pull the binding within the lease window, the link between IP and physical port is gone — capture it during detection, not after containment.*

## Related concepts

[[Network Architecture]] · [[Network Segmentation]] · [[NAC]] · [[Zero Trust]] · [[PKI]] · [[IAM]] · [[SSO]] · [[Federation]] · [[MFA]] · [[Windows Registry]] · [[Encryption]] · [[SIEM]] · [[Log Ingestion]] · [[Time Synchronization]] · [[System Hardening]] · [[ARP Spoofing]] · [[DHCP Snooping]] · [[802.1X]]

*Source: VIRGIL knowledge base — 2026-05-11*