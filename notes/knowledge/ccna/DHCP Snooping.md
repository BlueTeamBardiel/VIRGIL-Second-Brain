# DHCP Snooping

## What it is

In Among Us, the imposter wins by pretending to be crew. A rogue DHCP server is the imposter — it sits on the LAN, waits for someone to yell "I need an IP!", and races to answer first with malicious settings (usually pointing the default gateway at itself). Now every packet the victim sends to the internet flows through the attacker's box. Classic man-in-the-middle.

DHCP Snooping is the emergency meeting. It's a switch feature that splits every port into two camps — **trusted** and **untrusted** — and enforces a simple rule: only trusted ports are allowed to speak as a DHCP server. If an untrusted port tries to send an OFFER, ACK, or NAK, the switch drops it on the floor before it ever reaches a victim.

The switch becomes a bouncer at UDP ports 67/68, inspecting every DHCP message and asking: "Did this come from a port I trust to be a server?" If no, and it's a server-type message, it dies at the switch.

## Why it matters

DHCP poisoning is brutally effective because clients are gullible — they accept the **first** OFFER they receive, no questions asked. A laptop plugged into a conference room jack running a rogue DHCP daemon can beat the real server by milliseconds and silently reroute every new device on that VLAN through itself. From there: SSL stripping, DNS redirection, credential capture, the full Watch Dogs 2 starter kit.

Port Security won't save you here. Port Security counts MAC addresses per port — it has zero opinion about what those MACs are *saying*. A rogue DHCP server only needs one MAC to ruin your day, and Port Security will happily let it through.

DHCP Snooping is also the foundation for other defenses. The **binding database** it builds (which MAC got which IP on which port) is what Dynamic ARP Inspection and IP Source Guard read from to catch ARP poisoning and IP spoofing. Turn off snooping and those features go blind.

## Key facts

### Trust model
- **Untrusted is the default** — every port starts suspicious, like every player in a Mafia game starts as a potential threat until proven otherwise.
- **Trusted ports must be manually configured** with `ip dhcp snooping trust` on the interface.
- **Trusted ports** go to: real DHCP servers, uplinks to the core, and trunk links between switches — anywhere a legit DHCP reply might travel.
- **Untrusted ports** go to: end users, printers, conference room jacks, anything a human can plug a laptop into.

### What gets filtered
- **Server-to-client messages** (OFFER, ACK, NAK) are **dropped** on untrusted ports. This is the whole point — no rogue servers allowed.
- **Client-to-server messages** (DISCOVER, REQUEST, DECLINE, RELEASE) are **allowed** on all ports. Clients need to be able to ask for addresses from anywhere.
- On untrusted client messages, the switch also **inspects the source MAC** and compares it to the CHADDR field inside the DHCP payload. Mismatch = drop. This stops DHCP exhaustion attacks where one attacker forges thousands of fake MACs to drain the address pool like a Diablo bot farming loot.
- Snooping only looks at **UDP 67/68**. Everything else passes through untouched.

### Configuration commands
- `ip dhcp snooping` — enables the feature globally. Without this, nothing else matters.
- `ip dhcp snooping vlan <list>` — activates snooping on specific VLANs. You need **both** the global toggle and the VLAN activation; one without the other is a no-op, like having a Steam account but no games installed.
- `ip dhcp snooping trust` — interface-level command to mark a port trusted.
- A configured VLAN won't actually snoop if the VLAN itself isn't active on the switch — check that the VLAN exists and is up.

### Option 82
- **DHCP Option 82** is metadata the switch staples onto DHCP messages as they pass through, identifying which switch and port the request came from. Think of it as the switch slipping a sticky note into the envelope before forwarding.
- Useful for the DHCP server to make port-aware decisions (e.g., assign different scopes based on location).
- Problem: some DHCP servers don't recognize Option 82 and **reject the message entirely** when they see unknown data attached.
- `no ip dhcp snooping information option` disables the insertion if your server is one of the picky ones.

### The binding database
- Snooping builds a table of **MAC → IP → VLAN → interface → lease time** as it watches DHCPACKs cross trusted ports.
- This binding table is the source of truth for **Dynamic ARP Inspection (DAI)** and **IP Source Guard**. Snooping is the foundation; those two are the upper floors.

### Verification commands
- `show ip dhcp snooping` — global status and which VLANs are configured.
- `show ip dhcp snooping interface` — per-port trust status and rate limits.
- `show ip dhcp snooping binding` — the learned MAC-to-IP mappings, your receipts.

## Related concepts
- [[Dynamic ARP Inspection (DAI)]]
- [[IP Source Guard]]
- [[Port Security]]
- [[DHCP]]
- [[DHCP Exhaustion Attack]]
- [[Man-in-the-Middle Attack]]
- [[Rogue DHCP Server]]
- [[DHCP Option 82]]