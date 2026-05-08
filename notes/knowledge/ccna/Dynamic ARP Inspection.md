# Dynamic ARP Inspection

## What it is

In Tomb Raider, Lara navigates ruins where pressure plates and trip-wires don't ask who you are — step on one and the spikes fire, no questions asked. ARP works the same way: when your laptop asks "who has 10.0.0.1?", any device on the LAN can shout back "that's me!" and your laptop dutifully updates its ARP table. No password, no signature, no second opinion. This is how attackers achieve man-in-the-middle: they spam **gratuitous ARP replies** claiming to own the gateway's IP, every host on the segment overwrites their ARP cache, and now all upstream traffic flows through the attacker's machine first.

Dynamic ARP Inspection (DAI) is the puzzle mechanism that checks the artifact's weight before retracting the spikes — wrong artifact, the trap stays armed. Before a switch forwards an ARP message arriving on an untrusted port, DAI cross-references the sender's IP-MAC pair against a known-good list. If the pairing isn't on the list, the frame gets dropped and never reaches its victims.

That known-good list isn't something you maintain by hand — DAI piggybacks on the [[DHCP Snooping]] binding table. When DHCP Snooping watches legitimate DHCP exchanges happen, it records "MAC X got IP Y on port Z." DAI then uses that ledger to judge ARP traffic. No DHCP Snooping, no ledger, no DAI.

## Why it matters

Port Security and DHCP Snooping each look like they should stop ARP poisoning, and neither does. Port Security is checking how many players are in the lobby, not whether they're cheating. DHCP Snooping only inspects DHCP packets — ARP frames sail right past it because ARP is encapsulated directly in Ethernet with no IP header at all, living in its own layer-2 lane.

Without DAI, an attacker plugged into your access layer can quietly become the gateway for everyone in their VLAN. Credentials, session cookies, internal API calls — all of it routes through their laptop first. DAI is the specific control that closes this gap, and it's basically free once you've already deployed DHCP Snooping for other reasons.

## Key facts

### Why ARP is exploitable
- **No authentication** — ARP has zero built-in identity checks, like a Discord server with no roles where anyone can pin messages.
- **Encapsulated directly in Ethernet** — no IP header means ACLs and L3 firewalls can't filter it the normal way.
- **Gratuitous ARP** — unsolicited "hi, I'm 10.0.0.1 at MAC aa:bb:cc..." replies that overwrite existing cache entries with no question asked. HSRP routers legitimately use these during failover to announce a MAC change, which is why DAI has to handle them carefully.
- **Port Security doesn't help** — it caps MAC addresses per port but never validates that a MAC actually owns the IP it's claiming.

### How DAI decides
- Runs **per VLAN**, enabled with `ip arp inspection vlan <vlan-list>`.
- Every port in that VLAN is **untrusted by default** — guilty until proven innocent, like spawning into Tarkov where everyone is a threat.
- **Untrusted ports**: every ARP frame is checked against the DHCP Snooping binding table. IP-MAC mismatch = dropped.
- **Trusted ports**: ARP forwarded with no inspection. Mark uplinks to other switches and to your DHCP server as trusted with `ip arp inspection trust` under the interface.
- **Trust is feature-specific** — a port trusted for DAI is not automatically trusted for DHCP Snooping, and vice versa. Each feature keeps its own guest list.

### The DHCP Snooping dependency
- DHCP Snooping needs two commands: `ip dhcp snooping` (global) and `ip dhcp snooping vlan X`.
- DAI's status only flips to **Active** when both DAI and DHCP Snooping are enabled on the VLAN. Configure DAI alone and it sits there inert.
- Gratuitous ARP replies are validated the same as standard request/response pairs by default.

### Static IPs (the devices DHCP can't see)
- Servers, printers, network gear with hardcoded IPs never appear in the DHCP binding table, so DAI would drop their ARP messages.
- Fix: a **Static ARP ACL** that whitelists their IP-MAC pair.
- Syntax: `permit ip host <ip> mac host <mac>` inside an `arp access-list`, then attached to the VLAN.

### Rate limiting
- An attacker flooding ARP frames is a DoS vector even if every frame gets dropped — the switch CPU still burns inspecting them.
- DAI **rate-limits ARP messages per port per second**. Exceed the limit and the port goes to **errdisable**, the network equivalent of getting kicked from the lobby.
- Recovery: `shutdown` then `no shutdown` on the interface (or configure errdisable auto-recovery).

### Verification commands
- `show ip arp inspection` — global status per VLAN.
- `show ip arp inspection vlan <vlan>` — detailed status for one VLAN.
- `show ip arp inspection interfaces` — trust status of every port.
- `show ip arp inspection statistics` — forwarded vs. dropped counts. Spiking drops on a specific port = something on that port is lying about an IP.

## Related concepts
- [[ARP Poisoning]]
- [[DHCP Snooping]]
- [[Port Security]]
- [[HSRP]]
- [[Errdisable Recovery]]
- [[Gratuitous ARP]]
- [[Man-in-the-Middle Attacks]]
- [[Switch Security Hardening]]