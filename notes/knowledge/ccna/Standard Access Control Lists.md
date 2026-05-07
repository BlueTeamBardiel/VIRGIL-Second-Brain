# Standard Access Control Lists

## What it is

A bouncer at a club who only checks one thing: where you came from. Doesn't care what you're wearing, what you want to drink inside, or who you're meeting — just your origin. If your source address is on the list, you're in (or out). That's a Standard ACL.

Technically, a Standard Access Control List is a router-level filter that permits or denies IPv4 traffic based **only on the source IP address**. It's a sequential list of rules (Access Control Entries, or ACEs), processed top-to-bottom, stopping at the first match — like resolving a Magic: The Gathering stack, the first effect that lands wins and nothing below it fires.

Standard ACLs come in two flavors:
- **Numbered**: ranges `1-99` and `1300-1399`
- **Named**: created with `ip access-list standard <name>`

And then there's the bigger sibling — **Extended ACLs** — which check source IP, destination IP, protocol, and ports. Numbered `100-199` and `2000-2699`, or named with `ip access-list extended <name>`. Same family, more interrogation questions.

## Why it matters

Every ACL ends with an **implicit deny any** — an invisible final rule that drops everything not explicitly permitted. It's the Dark Souls of networking: if you don't unlock the door, you're not getting through. Forget to add a single `permit` statement and you've just firewalled your entire network into oblivion.

Placement also matters more than people think:

- **Standard ACLs go close to the destination.** Because they only see source IP, placing them too early would nuke that source's traffic to *every* destination — like banning a player from the entire game server when you only wanted to kick them from one lobby.
- **Extended ACLs go close to the source.** Since they can be precise about destination and port, you stop unwanted traffic before it wastes bandwidth crossing your network. No reason to let a packet sprint through three routers just to die at the finish line.

Get the direction wrong and you either over-block or waste CPU. Get the order wrong inside the ACL and a broad `permit` higher up will shadow a specific `deny` below it — the rule never even gets read.

## Key facts

### The Wildcard Mask (the part everyone trips on)

Subnet masks tell you what part of an IP is the network. Wildcard masks are their **photo negative** — flip every bit.

- Bit `0` = **must match exactly** (locked)
- Bit `1` = **don't care** (free)

Quick formula: `255.255.255.255 - subnet mask = wildcard mask`.

| Subnet | Subnet Mask | Wildcard Mask | Matches |
|---|---|---|---|
| /32 | 255.255.255.255 | 0.0.0.0 | a single host |
| /24 | 255.255.255.0 | 0.0.0.255 | 256 addresses |
| /16 | 255.255.0.0 | 0.0.255.255 | 65,536 addresses |
| /8 | 255.0.0.0 | 0.255.255.255 | a /8 block |
| 0.0.0.0 | — | 255.255.255.255 | everything (`any`) |

Shortcuts the IOS gives you so you don't have to type those out:
- **`host 10.0.0.5`** = `10.0.0.5 0.0.0.0` (single address)
- **`any`** = `0.0.0.0 255.255.255.255` (all addresses)

### Standard ACL behavior

- Source IP only — that's the entire personality.
- Lightweight and fast (one field to check, like a turnstile vs. airport security).
- Top-down processing, first match wins, then exit. The implicit `deny any` lives silently at the bottom.
- **At least one `permit` statement is required** or you've built a wall, not a filter.
- Apply **inbound on the interface closest to the destination**.

### Extended ACL behavior

- Filters on protocol + source IP + destination IP + port.
- Sees TCP, UDP, ICMP, OSPF, and other IP-layer protocols.
- Slower per-packet — more fields to match — but vastly more surgical.
- Apply **outbound on the interface closest to the source** for efficiency (some designs go inbound on the source interface; the principle is "stop it early").
- A single host needs `host 1.2.3.4` or the `/32` wildcard `0.0.0.0`. You can't just type a bare IP.
- The `eq` keyword matches a specific port: `eq 443` = HTTPS only.

### Direction matters

- **Inbound**: filters traffic *entering* an interface, **before** the routing table lookup. Drop it before the router even thinks about where it's going. Saves CPU.
- **Outbound**: filters traffic *leaving* an interface, **after** routing has already happened. The packet already did the work of crossing the router; the ACL is the last gate.

### Editing — the painful difference

- **Numbered ACLs cannot be edited.** Want to fix line 2 of ACL 10? You delete the whole thing with `no access-list 10` and rebuild it. It's like a save file with no mid-mission checkpoints — one mistake and you redo the whole run.
- **Named ACLs can be edited by sequence number.** Add, delete, or insert individual ACEs. `no <sequence-number>` removes one line. Resequencing lets you slot a new rule between existing ones — proper save scumming.

### Common ports and protocol numbers worth memorizing

| Port/Number | Service |
|---|---|
| TCP 23 | Telnet |
| TCP 80 | HTTP |
| TCP 443 | HTTPS |
| UDP 53 | DNS |
| IP protocol 1 | ICMP |
| IP protocol 6 | TCP |
| IP protocol 17 | UDP |

### Useful commands

- `ip access-list standard <name>` — enter named standard ACL config
- `ip access-list extended <name>` — enter named extended ACL config
- `ip access-group <acl> {in|out}` — apply ACL to an interface
- `show access-lists` — view ACLs and **hit counts** (which rules are actually firing — like checking your kill feed to see if your traps worked)
- `show ip interface` — see which ACLs are bound to which interfaces
- `no access-list <number>` — nuke a numbered ACL
- `no ip access-list standard|extended <name>` — nuke a named ACL

### Style tip

End every ACL with an explicit `permit any` or `deny any` — even though the implicit deny is already there. It makes `show access-lists` output readable and the hit counter on the explicit rule tells you how much traffic is hitting that catch-all. Implicit rules don't show counters, so you're flying blind otherwise.

### Example wildcard logic in action

To match everything in `10.0.0.0/24`:
```
permit 10.0.0.0 0.0.0.255
```
The `0.0.0` says "first three octets must be exactly 10.0.0", the `.255` says "last octet, anything goes." Match anything from 10.0.0.0 through 10.0.0.255.

To match a single host (Beatrice's workstation at 10.0.0.42):
```
permit host 10.0.0.42
```

## Related concepts

[[Extended Access Control Lists]]
[[Wildcard Masks]]
[[Subnet Masks and CIDR]]
[[Named vs Numbered ACLs]]
[[Implicit Deny]]
[[Inbound vs Outbound Interface Direction]]
[[Router Packet Forwarding Process]]
[[TCP and UDP Port Numbers]]
[[IPv4 Protocol Numbers]]
[[ACL Placement Strategy]]
[[Firewall Fundamentals]]
[[Control Plane vs Data Plane Filtering]]