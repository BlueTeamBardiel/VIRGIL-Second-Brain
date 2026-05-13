# Troubleshooting Networks

## What it is

Your game freezes mid-raid. Discord drops. The browser spins. Phone says "Connected, no internet." Five symptoms, one question: where in the chain did the signal die?

A network is the machine's voice and ears. Troubleshooting it means walking the path the packet takes — from the NIC, through the switch or AP, to the router, out the modem, across the ISP, to the server, and back — and finding the spot where the conversation stops. The packet either gets there or it doesn't. Your job is to figure out where it gave up.

Most network problems are addressing problems. The cable's fine. The radio's fine. But the machine has the wrong IP, no gateway, a bad subnet mask, or it grabbed an APIPA address because DHCP ghosted it. CompTIA 220-1201 Objective 2.6 wants you to know IPv4, IPv6, public vs private, static vs dynamic, APIPA, subnet mask, and gateway — because every one of those is a layer where troubleshooting starts.

## Why it matters

Networking is the single largest bucket of helpdesk tickets after "I forgot my password." Users don't say "my default gateway is misconfigured" — they say "the internet is broken." You translate. You walk the OSI stack from physical up, or from application down, depending on what you see. CompTIA tests addressing fundamentals on Core 1 because if you can't read an `ipconfig` output and immediately spot what's wrong, you can't troubleshoot anything else.

This is also where the detective framework earns its keep. *Identify the problem, theorize, test, plan, fix, verify, document.* Skip steps and you'll spend an hour rebooting a router when the user's laptop had a static IP from their last job.

## In your build, in the enterprise

**Beat 1 — the addressing layer, technically.**

Every device on an IP network needs four things to reach the internet: an IP address, a subnet mask, a default gateway, and a DNS server. Miss any one and something breaks.

- **IPv4** — 32-bit, dotted decimal (192.168.1.50). Private ranges (RFC 1918) are 10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16. These never route on the public internet — your home router NATs them to a single public IPv4 your ISP assigns.
- **IPv6** — 128-bit, hex with colons (2001:db8::1). Solves IPv4 exhaustion. Link-local addresses start with `fe80::`. No NAT needed — every device gets a globally routable address.
- **Subnet mask** — tells the host which part of the IP is "network" and which is "host." 255.255.255.0 (or /24) means the first three octets identify the network. Get this wrong and the host thinks remote machines are local — packets go to ARP instead of the gateway and die.
- **Default gateway** — the router's LAN-side IP. The address the host sends packets to when the destination isn't on the local subnet. No gateway = no internet, full stop.
- **Static vs Dynamic** — static is hand-configured and never changes (servers, printers, network gear). Dynamic comes from DHCP — the router hands out leases. Most clients are dynamic.
- **APIPA (Automatic Private IP Addressing)** — 169.254.x.x. The host couldn't reach DHCP, so Windows made up an address. This is a diagnostic flag, not a working state. *If you see 169.254, DHCP failed.*

**Beat 2 — Feynman: it's raid night and the connection just died.**

You're three bosses deep into a mythic+ run. Discord cuts out. Game disconnects. Browser won't load.

**Step 1 — what's the scope?** Phone on Wi-Fi: also dead. Roommate yells from the other room: also dead. *Not your PC. Everyone's down.* If only your PC died, you'd start at the NIC. Whole house down? Start at the router or modem.

**Step 2 — check the lights.** Walk to the modem. Internet light is red. Router's WAN light is dark. *Physical layer says the ISP link is gone.* Reboot the modem. Wait 90 seconds. Lights come back green. Try again — back online.

**Step 3 — only your machine is dead.** Different scenario: your roommate's fine, your PC isn't. Open cmd, run `ipconfig`. You see `169.254.18.42`. *APIPA. DHCP didn't answer.* Could be the cable, the NIC, or the router's DHCP scope is exhausted. Unplug-replug the ethernet. Run `ipconfig /release` then `ipconfig /renew`. Real address comes back. Fixed.

**Step 4 — the sneaky one.** Connection "works" but games lag, web pages half-load. `ipconfig` shows a valid IP but the default gateway is blank, or wrong, or set to something from your last apartment because someone left a static config on. *Static configs from a previous network are the silent killer.* Set the NIC back to "Obtain an IP address automatically." Renew. Done.

*Four different symptoms, four different layers, same detective process.*

**Beat 3 — bridge to the enterprise.**

At home, you've got one router doing DHCP, NAT, DNS forwarding, and Wi-Fi. One device, one point of failure, one reboot fixes most things.

In an enterprise, those roles split across separate boxes. DHCP runs on a Windows Server with scopes per VLAN. DNS is its own server (often the same domain controller). The gateway is an enterprise router or layer-3 switch. NAT happens at the edge firewall. Each layer can fail independently, and each is monitored separately.

When a user at work says "the internet's broken," you check:

- **Is it just them, their floor, or the whole site?** Scope tells you the layer.
- **What does `ipconfig /all` show?** APIPA? DHCP scope is exhausted or the relay agent is down. Wrong subnet? They're on the wrong VLAN — switchport misconfigured. No DNS? DNS server is down or the DHCP option is wrong.
- **Can they ping the gateway?** Yes = local network is fine, problem is upstream. No = layer 2 problem, bad cable, dead port, or VLAN mismatch.
- **Can they ping 8.8.8.8 but not google.com?** DNS is broken. Internet works, name resolution doesn't.

Same questions as the gaming PC. Bigger blast radius.

**Beat 4 — the point.**

The packet path is the packet path. Home network or Fortune 500, you're asking *did the host get a valid address, does it know its gateway, can it reach the gateway, can the gateway reach the internet, can DNS resolve names.* Five questions. Walk them in order. The layer that says "no" is the layer you fix.

*Get this sequence into your bones. You'll run it ten thousand times.*

## Key facts

### The five-question network triage

| Question | Tool | If "no," the problem is |
|---|---|---|
| Does the host have a valid IP? | `ipconfig /all` | DHCP, NIC, or cable |
| Does it know its gateway? | `ipconfig /all` | DHCP option or static misconfig |
| Can it ping the gateway? | `ping <gateway>` | Local network — switch, cable, VLAN |
| Can it ping a public IP (8.8.8.8)? | `ping 8.8.8.8` | Gateway, WAN link, or ISP |
| Can it resolve names? | `nslookup google.com` | DNS |

### Addressing cheat sheet

| Range | Type | Meaning |
|---|---|---|
| 10.0.0.0/8 | Private IPv4 | RFC 1918, large networks |
| 172.16.0.0/12 | Private IPv4 | RFC 1918, medium networks |
| 192.168.0.0/16 | Private IPv4 | RFC 1918, home/SOHO default |
| 169.254.0.0/16 | APIPA | DHCP failed — diagnostic flag |
| 127.0.0.0/8 | Loopback | The host itself (127.0.0.1) |
| fe80::/10 | IPv6 link-local | Local segment only, not routed |
| 2000::/3 | IPv6 global unicast | Publicly routable |

### Static vs dynamic — when to use which

**Static:**
- Servers, printers, network gear, anything other devices need to find by IP
- Configure outside DHCP scope or via DHCP reservation
- Document every static IP — a spreadsheet beats a memory

**Dynamic (DHCP):**
- Every client device — laptops, desktops, phones, IoT
- Default behavior on every consumer OS
- Leases typically 8 hours (home) to 8 days (enterprise)

### Subnet mask — the one that trips people

`/24` = 255.255.255.0 = 256 addresses (254 usable). Your home network.
`/16` = 255.255.0.0 = 65,536 addresses. A whole campus.
`/30` = 255.255.255.252 = 4 addresses (2 usable). Point-to-point router links.

If the host has `192.168.1.50 / 255.255.255.0`, it thinks 192.168.1.1 through .254 are local. Anything else goes to the gateway. If the mask is wrong (say 255.255.0.0), the host tries to ARP for the gateway across a bigger range than it should — packets misroute and connections fail mysteriously.

### CompTIA exam traps

> **CompTIA exam trap: APIPA means "no DHCP," not "no network."** A host with 169.254.x.x can talk to other 169.254.x.x hosts on the same segment. It just can't reach a gateway or the internet. The exam will frame this as "user reports no internet, ipconfig shows 169.254" — the answer is always "DHCP server is unreachable."

> **CompTIA exam trap: private vs public IPv4.** A user pings their public IP from inside the network and asks why it doesn't work the way they expect. Private IPs are RFC 1918, never route on the public internet, and are translated by NAT at the router. The exam tests recognition of the three private ranges.

> **CompTIA exam trap: subnet mask mismatch.** Two hosts on the same wire with different masks may or may not be able to talk — depending on which direction. CompTIA will give you `192.168.1.10/24` and `192.168.1.20/25` and ask if they can communicate. Read the mask carefully.

> **CompTIA exam trap: IPv6 link-local addresses.** `fe80::` addresses exist on every IPv6-enabled interface automatically. They're not routable. Seeing one doesn't mean IPv6 is working end-to-end — it means the interface is up.

## Helpdesk reality

- **"The internet is down."** → Ask: just you, your team, or everyone? Scope tells you the layer before you touch a single tool.
- **"I can't reach the file server but the internet works."** → DNS is probably fine, gateway is fine, but the server might be down, on a different VLAN, or blocked by a firewall rule. Ping the server by IP first, then by name. The difference tells you if it's DNS or reachability.
- **"It was working yesterday."** → What changed? New laptop dock, new cable, new Wi-Fi password, IT pushed an update. Something always changed. Find it.
- **"I set a static IP at my last job and now nothing works at home."** → This happens constantly with users who think they're helping. Set the NIC back to DHCP. Renew. Move on.
- **Never promise a timeline on ISP outages.** "The provider is working on it" is the only honest answer. Don't guess.

## Related concepts

[[Configuring SOHO Networks]] · [[DHCP and DNS]] · [[Wireless Networking]] · [[Network Cables and Connectors]] · [[Common Networking Ports]] · [[Troubleshooting Methodology]] · [[Command Line Networking Tools]]

*Source: VIRGIL knowledge base — 2026-05-10*