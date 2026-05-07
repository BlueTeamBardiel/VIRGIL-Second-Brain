# DHCP Config

## What it is

Joining a new Discord server and instantly getting a role, nickname color, and access to the right channels — all without you typing anything — that's what DHCP does for a device joining a network. Plug in your laptop, and within a second it has an IP address, a subnet mask, a default gateway, and DNS servers. No manual config, no asking the network admin.

The mechanic underneath is a four-step handshake called **DORA**: Discover, Offer, Request, Acknowledge. The client shouts "anyone running DHCP?" into the void (Discover), one or more servers reply "I've got 10.0.0.42 if you want it" (Offer), the client picks one and says "I'll take it" (Request), and the server confirms "it's yours, here's the lease" (Acknowledge).

It runs over UDP — server listens on **port 67**, client listens on **port 68**. The first Discover packet is a broadcast because the client doesn't know anything yet, not even who to ask.

## Why it matters

DHCP is the silent backbone of every network you've ever connected to. Without it, every coffee shop Wi-Fi connection would involve a help desk ticket. But the same automation that makes it convenient makes it a juicy target — anyone who controls DHCP controls where your traffic goes, because they hand out the default gateway and DNS server. That's the keys to the kingdom dressed up as a housekeeping protocol.

Think of a rogue DHCP server like someone in Among Us pretending to be a crewmate while wearing the impostor's job — they hand out "helpful" configs that route you straight through their machine.

## Key facts

### What DHCP hands out
- IP address, subnet mask, default gateway, DNS servers — the full starter kit a device needs to actually use the network.
- Lease duration matters for incident response: when you're trying to figure out which user had `10.0.0.57` at 3:14 AM, the DHCP lease logs are your time-stamped receipts.
- **T1 renewal timer fires at 50% of lease duration** — like a Spotify subscription auto-renew nag, the client tries to extend its lease halfway through rather than waiting for it to expire.

### DORA handshake
- **Discover** — client broadcasts "anyone home?"
- **Offer** — server(s) reply with available IP.
- **Request** — client formally accepts one offer.
- **Acknowledge** — server locks it in and records the lease.

### Crossing routers
- DHCP Discover is a **broadcast**, and routers drop broadcasts by default. Your DHCP server in one VLAN won't hear clients in another VLAN.
- Fix: **DHCP relay agent**, configured on the router interface with `ip helper-address <dhcp-server-ip>`. The router catches the broadcast and unicasts it to the real server — like a bouncer relaying your name to the guest list manager inside the club.

### DHCP Starvation
- Attacker floods the server with **DHCPDISCOVER packets using spoofed MAC addresses**, each one claiming to be a new device. The server hands out leases until the entire pool is empty.
- Result: legitimate clients can't get IPs — a clean **denial-of-service**. Like a scalper bot buying every single concert ticket in the first 30 seconds. Tools like Yersinia automate this in seconds.

### Rogue DHCP Server
- Attacker stands up their own DHCP server on the LAN and **races the legitimate one** — whichever server's Offer reaches the client first wins the Request.
- The malicious config typically points the **default gateway and/or DNS to attacker-controlled boxes**. Now every web request the victim makes flows through the attacker (machine-in-the-middle) or resolves to attacker-chosen IPs.
- Critical detail: **DNS poisoning without ever touching the legitimate DNS server**. The attacker just tells victims "use *my* resolver instead." Watch Dogs-style traffic redirection, except no fancy pyramid puzzle required.
- Often combined with DHCP starvation — first exhaust the real server's pool, then the rogue server is the only one answering.

### DHCP Snooping (the defense)
- Switch-level feature that **whitelists which ports are allowed to send DHCP server messages** (Offer, Ack). Trusted ports = the uplink toward your real DHCP server. Everything else is untrusted.
- **Drops DHCP Offers and Acks arriving on untrusted ports** — a rogue server plugged into a random user port gets silenced before its packets reach any victim.
- Builds a **binding table** mapping `MAC ↔ IP ↔ port ↔ VLAN` for every legitimate lease. This table is the receipt of who got what.

### Dynamic ARP Inspection (DAI)
- Piggybacks on the DHCP snooping binding table. Every ARP packet on the wire is checked against the table — if an ARP reply claims an IP/MAC pairing the table doesn't recognize, DAI drops it.
- Kills ARP spoofing as a side effect of having DHCP snooping turned on. Two-for-one defense.

## Related concepts
[[ARP Spoofing]]
[[Dynamic ARP Inspection]]
[[DNS Poisoning]]
[[VLAN]]
[[UDP]]
[[Broadcast Domain]]
[[Machine-in-the-Middle Attack]]
[[Port Security]]
[[ip helper-address]]