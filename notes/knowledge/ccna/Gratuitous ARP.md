# Gratuitous ARP

## What it is

A new player joins your Discord server and immediately pings @everyone with "Hey, I'm the new admin, send all DMs to me from now on" — and Discord just... believes them. No verification, no role check, no nothing. That's Gratuitous ARP.

Gratuitous ARP (GARP) is an unsolicited ARP reply that a device broadcasts to the entire local segment, announcing "this IP belongs to this MAC" without anyone having asked. Normal ARP is request-then-reply: a host shouts "who has 10.0.0.1?" and the owner answers. GARP skips the question entirely — it's just the answer, broadcast to everyone, with destination MAC `FF:FF:FF:FF:FF:FF`.

The kicker: ARP as defined in RFC 826 has zero authentication. There's no signature, no challenge, no "are you really who you say you are?" Most operating systems will happily overwrite their ARP cache with whatever GARP shows up, the same way an MMO would if `/whois` results just trusted whatever name a player typed into chat.

## Why it matters

This is the V's-favorite-quickhack of LAN attacks. In Cyberpunk 2077 terms, GARP is the breach protocol that lets you slot yourself between two devices that thought they were talking directly. An attacker on the same broadcast domain sends a GARP claiming "192.168.1.1 (the gateway) is at MY MAC address." Every host on the segment updates its ARP cache. Now all internet-bound traffic flows through the attacker's machine first — classic Man-in-the-Middle, no passwords cracked, no exploits deployed, just a forged announcement everyone believes.

But GARP isn't inherently evil. It's the same mechanism that keeps high-availability gateways alive. When a primary router dies and a backup takes over via VRRP or HSRP, the backup blasts a GARP saying "the virtual gateway IP is now at my MAC" — and failover happens in seconds instead of waiting for every host's ARP cache to time out. Same tool, opposite intent. Like a grenade in Helldivers 2: clears bugs or clears your squad depending on who's holding it.

## Key facts

- **Format**: An ARP reply with destination MAC `FF:FF:FF:FF:FF:FF` (broadcast), sent without a matching request. Source and target IP fields both contain the sender's own IP.
- **Trust model**: None. RFC 826 has no verification mechanism — ARP replies are accepted on faith, like a Among Us crewmate vouching for themselves.
- **Default OS behavior**: Windows, Linux, macOS all cache unsolicited GARP replies by default. Some distributions tightened this (Linux `arp_accept` sysctl), but the baseline is "trust whatever shows up."
- **Legitimate uses**:
  - **VRRP / HSRP failover**: backup router announces it now owns the virtual IP.
  - **IP address changes**: a host getting a new DHCP lease tells everyone to refresh.
  - **NIC replacement**: same IP, new MAC, GARP propagates the update.
- **Attack pattern**: Attacker broadcasts GARP claiming the gateway's IP maps to the attacker's MAC. Hosts update cache. Traffic destined for the internet now goes to the attacker, who forwards it on (MITM) — and can sniff, modify, or drop at will.
- **Weaponization tools**:
  - **arpspoof** (from dsniff suite) — minimalist, scriptable, the bolt-action rifle of ARP poisoning.
  - **Ettercap** — full GUI/TUI MITM framework, plugins for SSL stripping, DNS spoofing, the works.
- **Mitigation — Dynamic ARP Inspection (DAI)**: a switch feature that drops ARP packets whose IP-to-MAC mapping doesn't match the DHCP snooping binding table. Think of it as the bouncer cross-checking IDs against the guest list before letting the GARP through.
- **DAI dependency**: DAI relies on DHCP snooping being enabled first — without that binding table, there's nothing to validate against. Static entries are needed for hosts with manually assigned IPs.
- **Scope**: Layer 2 only. GARP can't cross a router, so the attack and its defenses both live within a single broadcast domain / VLAN.

## Related concepts

[[ARP]] · [[Dynamic ARP Inspection (DAI)]] · [[DHCP Snooping]] · [[ARP Poisoning]] · [[Man-in-the-Middle Attack]] · [[VRRP]] · [[HSRP]] · [[Ettercap]] · [[Broadcast Domain]] · [[RFC 826]]