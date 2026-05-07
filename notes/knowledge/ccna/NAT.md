# NAT

## What it is

A Discord server with one public invite link but hundreds of members inside — outsiders only see the link, not the individual users. NAT (Network Address Translation) works the same way: your home network might have a dozen devices (phone, laptop, PS5, smart fridge), but the wider internet only sees one public IP address. The router sits at the door doing the bouncer work, remembering which internal device asked for what so replies get routed back to the right place.

Technically, NAT rewrites the source (and sometimes destination) IP address fields in packet headers as traffic crosses the boundary between your private network and the public internet. To track who asked for what, the NAT device maintains a **translation table** — basically a spreadsheet of active conversations mapping `internal IP:port` ↔ `external IP:port`.

There are three flavors:

- **Static NAT** — a permanent 1-to-1 mapping. Like reserving a specific gamertag for a specific account forever. One private IP, one public IP, no sharing.
- **Dynamic NAT** — a pool of public IPs that internal hosts grab as needed, like checking out a controller from a shared bin. When you're done, it goes back in the pool.
- **PAT (Port Address Translation)**, also called **NAT Overload** — many internal hosts share one public IP, distinguished by source port numbers. This is the one in your home router right now.

## Why it matters

IPv4 only has ~4.3 billion addresses, and we burned through those years ago. PAT is the duct tape holding the internet together. Without it, your ISP would need to hand out a unique public IP for every device in your house, every IoT sensor, every phone — which is mathematically impossible.

But NAT comes with baggage. It **breaks end-to-end connectivity** — the original vision of the internet where any host could directly reach any other host. This is why hosting a Minecraft server from your bedroom requires port forwarding gymnastics, and why peer-to-peer games like Dark Souls invasions sometimes fail with cryptic NAT type errors (Strict/Moderate/Open). The matchmaking server can see you, but two players behind separate NATs can't directly punch through to each other without help.

A critical misconception: **NAT is not a firewall.** It looks like one because unsolicited inbound traffic gets dropped (there's no translation entry for it), but that's a side effect, not security. NAT doesn't inspect payloads, doesn't enforce policy, and doesn't care if the traffic is malware or a cat video. Treating NAT as your security layer is like assuming your apartment is safe because the lobby has a confusing layout — it's obscurity, not defense.

And if an attacker compromises the NAT device itself? They get the master translation table. That's the entire internal network map handed over — every device, every active connection, every internal IP. Game over for reconnaissance.

## Key facts

### Private address ranges (RFC 1918)
These are the IP ranges that are not routable on the public internet — they only exist inside private networks, like a LAN party where everyone picks a nickname that only matters inside the room.
- **10.0.0.0/8** — the big one, used by enterprises with lots of hosts
- **172.16.0.0/12** — the middle child, common in mid-sized networks
- **192.168.0.0/16** — the home router default (192.168.1.1 should look familiar)

### How PAT actually works
PAT differentiates connections using **source port numbers**. The router rewrites both the source IP and the source port, then logs the mapping.

Example translation table entry:
- Your laptop `192.168.1.50:51234` → public `203.0.113.5:62000`
- Your phone `192.168.1.51:51234` → public `203.0.113.5:62001`

Both internal hosts happened to use port 51234, but the NAT box assigns unique external ports so return traffic isn't ambiguous. With ~65,000 ports available, **a single public IP can theoretically support thousands of simultaneous connections** from internal hosts.

### What NAT does NOT do
- Does **not** inspect packet payloads (no deep packet inspection)
- Does **not** enforce access control policies (that's a firewall's job)
- Does **not** authenticate users
- Does **not** detect malware
- Does **not** log application-layer activity

### Compatibility issues
- **IPsec AH** (Authentication Header) cryptographically signs the IP header, including the source IP. NAT rewrites that header, which invalidates the signature — like editing a contract after both parties signed. AH and NAT are fundamentally incompatible without **NAT Traversal (NAT-T)** workarounds, which typically wrap IPsec in UDP.
- **VoIP protocols** like SIP embed IP addresses inside the payload (the SIP signaling tells the other end "call me back at 192.168.1.50"). NAT rewrites the outer header but not the embedded address, so the callback goes to a private IP that's unreachable from the internet. Fixes include SIP ALG, STUN, TURN, and ICE.
- Any peer-to-peer protocol that assumes direct reachability suffers similar issues.

### Security reality check
- Compromising the NAT device exposes the **entire internal network map** via the translation table — every active connection, every internal IP, every port in use. Treat your edge router's admin credentials accordingly.

## Related concepts

- [[RFC 1918 Private Addressing]]
- [[IPv4 Address Exhaustion]]
- [[IPv6]]
- [[Port Forwarding]]
- [[NAT Traversal (STUN, TURN, ICE)]]
- [[IPsec and NAT-T]]
- [[Stateful Firewall]]
- [[CGNAT (Carrier-Grade NAT)]]
- [[Hairpinning / NAT Loopback]]
- [[Defense in Depth]]