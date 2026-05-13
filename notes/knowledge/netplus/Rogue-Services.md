# Rogue Services

## What it is

In **DOTA**, you queue for a ranked match and the matchmaker drops you on a server. Halfway through the laning phase, a second "courier" appears in your base that you didn't buy — it's been delivering items to the wrong player, sometimes the enemy. Nobody summoned it. It just showed up, pretending to be yours, and your team trusted it because couriers look like couriers. By the time you notice, your carry has been fed three items meant for the offlaner and you've lost mid.

That's exactly what a rogue service does — it's an unauthorized DHCP server, DNS resolver, or time source on your network that clients trust by default, hand their traffic to, and obey. The legitimate service is still running. The rogue is louder, faster, or just first to answer.

**Technical definition (N10-009 Objective 3.4):** A rogue service is any unauthorized network infrastructure service — most commonly DHCP, DNS, or NTP — operating on a network segment without administrative approval. Because the foundational protocols (DHCPDISCOVER, DNS queries, NTP requests) are broadcast or trust-on-first-response, clients accept replies from whoever answers first. A rogue server that answers faster than the real one wins the client.

## Why it matters

Rogue services are the textbook example of **trust-by-default protocols** failing in adversarial conditions. DHCP, DNS, and NTP in their base forms have no authentication. The N10-009 exam tests this because rogue DHCP is the single most common helpdesk-escalated network outage caused by an end user — somebody plugged a home router into a wall jack with the WAN and LAN ports reversed, and now half the floor is getting 192.168.1.x addresses from a Linksys instead of the corporate DHCP scope.

Every network admin will troubleshoot a rogue DHCP in their first two years. Every security analyst will see a rogue DNS resolver used as the pivot for a MITM attack. CompTIA ties rogue services together because these three can take down a network silently — clients don't error, they just route through the attacker.

*A rogue DHCP server is faster to break a network than a cut cable. Users get IPs. Pings work. Nothing resolves. The L1 guys check cables for an hour before anyone thinks to run `ipconfig /all` and notice the gateway is wrong.*

## Key facts

### Rogue DHCP — the most common offender

[[DHCP]] hands out IPs via **DORA** — Discover, Offer, Request, Acknowledge. The client broadcasts DISCOVER. Any DHCP server on the segment can OFFER. The client takes the first valid offer. That last sentence is the whole problem.

| Component | Legitimate DHCP | Rogue DHCP |
|---|---|---|
| Scope | Defined by admin, matches subnet | Random; often 192.168.x.x from a home router |
| Default gateway | Real router IP | Rogue's own IP (MITM) or wrong gateway (DoS) |
| DNS servers | Corporate resolvers | Attacker-controlled or random |
| Lease time | Hours to days | Often very short, forces re-pull |
| Exclusions/Reservations | Respected | Ignored |

**How rogues get on your network:** user plugs a SOHO router with cables reversed; attacker plugs a Raspberry Pi running `dnsmasq` into a conference room jack; a VM with DHCP enabled gets bridged to the physical NIC; a server with DHCP role gets enabled by mistake.

**Defenses:**
- **DHCP Snooping** on the switch — trusted ports (uplink to real DHCP) vs. untrusted ports. Drops OFFER/ACK from untrusted ports.
- **Port Security** — limit MACs per port, shut down on violation
- **Dynamic ARP Inspection (DAI)** — pairs with snooping to prevent ARP poisoning
- **802.1X** — authenticate the device before it gets a port at all

> **CompTIA exam trap:** DHCP snooping is configured on **switches**, not on the DHCP server. The DHCP server can't stop a rogue — it doesn't see the rogue's traffic. The switch is the only device positioned to drop unauthorized OFFER/ACK packets.

### Rogue DNS — the silent pivot

[[DNS]] resolves names to addresses. A rogue DNS server, once a client is pointed at it (via rogue DHCP, hosts file tampering, or router hijacking), can return whatever address it wants for any query.

**Record types the exam expects cold:**

| Record | Purpose |
|---|---|
| **A / AAAA** | Hostname → IPv4 / IPv6 address |
| **CNAME** | Canonical name (alias → real hostname) |
| **MX** | Mail exchange |
| **NS** | Nameserver (authoritative for zone) |
| **PTR** | IP → hostname (reverse lookup) |
| **TXT** | Arbitrary text (SPF, DKIM, verification) |

**Zone types:** Forward (name → IP) vs. reverse (IP → name, uses PTR, lives under `in-addr.arpa` or `ip6.arpa`). Primary is read-write; secondary is read-only and pulls via zone transfer.

**Authoritative** servers host the zone. **Non-authoritative** answers come from cache or recursion. **Recursive** resolvers walk the DNS tree for the client; **iterative** returns "ask this other server." A rogue resolver typically pretends to be recursive — it'll happily "resolve" anything, just to wrong answers.

**Defenses:**
- **[[DNSSEC]]** — cryptographically signs DNS records. Resolvers validate signatures. Doesn't encrypt — just authenticates.
- **DNS over HTTPS (DoH)** — DNS tunneled inside HTTPS to a known resolver (1.1.1.1, 8.8.8.8). Port 443. Defeats local rogues because the client isn't asking the LAN.
- **DNS over TLS (DoT)** — same idea, dedicated port 853. Easier for admins to see and control than DoH.
- **Hosts file hygiene** — `C:\Windows\System32\drivers\etc\hosts` and `/etc/hosts` are checked before DNS. Malware drops entries here.

> **CompTIA exam trap:** DNSSEC provides **authentication and integrity**, not confidentiality. The query and answer are still in plaintext. For query privacy from a network observer, the answer is DoH or DoT. For preventing DNS spoofing, the answer is DNSSEC.

### Rogue DHCP delivering rogue DNS

The combination is the actual attack. The rogue DHCP server hands out itself as the DNS server. Every name lookup goes to the attacker. The attacker returns `bank.com → 10.0.0.66` (their box), proxies the real bank, harvests credentials, and the user sees a working login page. This is why **DHCP Option 6** (DNS servers) is a sensitive field.

| Option | Purpose |
|---|---|
| **1** | Subnet mask |
| **3** | Default gateway |
| **6** | DNS servers |
| **15** | Domain name |
| **51** | Lease time |
| **66** | TFTP server (boot image) |

**SLAAC** is IPv6's alternative to DHCP — the host generates its own address from the router's advertised prefix. Rogue **Router Advertisements (RA)** are the IPv6 equivalent of rogue DHCP — mitigated with **RA Guard** on the switch.

### Rogue NTP — the time bomb

[[NTP]] (UDP 123) synchronizes clocks. Rogue NTP shifts client clocks. Why it matters:

- **Kerberos** tickets fail if clock skew exceeds 5 minutes — break time, break logins
- **TLS certificates** validate against current time — break time, all HTTPS breaks
- **Log timestamps** become useless for forensics
- **TOTP / MFA tokens** depend on time

**Defenses:** **NTS (Network Time Security)** cryptographically authenticates NTP responses — the modern answer. **PTP (IEEE 1588)** delivers sub-microsecond accuracy for trading floors, broadcast, industrial — typically on isolated VLANs. Authenticated NTP with symmetric keys still works. Point clients at internal NTP servers that sync to vetted stratum-1 sources.

> **CompTIA exam trap:** NTP is UDP 123. PTP uses UDP 319 (event) and 320 (general). NTS extends NTP, doesn't replace it. Don't confuse PTP (sub-microsecond) with NTP (millisecond, internet-grade) — different problems.

### Detection — how you find a rogue

- `ipconfig /all` on Windows, `ip addr` and `cat /etc/resolv.conf` on Linux — check gateway, DNS, lease source
- **DHCP server logs** — if your real server isn't issuing the lease, somebody else is
- **Wireshark** — filter `bootp` (DHCP) or `dns`, watch for OFFER packets from unexpected MACs
- **Switch CAM table** — find the port the rogue MAC is on, walk the cable, find the device
- **`nslookup` against a known-good external resolver vs. local** — divergent answers = rogue DNS

## Helpdesk reality

- User says: *"The internet's slow"* or *"Nothing's loading."* Reality: they got a 192.168.1.x address from someone's Apple TimeCapsule and their gateway is unreachable. First check: `ipconfig /all` — does the gateway match the subnet?
- User says: *"My laptop works on Wi-Fi, not Ethernet."* Reality: the Ethernet port is on a different VLAN where a rogue DHCP took over.
- Never promise *"It'll be fixed when I unplug it."* Until you find the cable, you don't know what "it" is. A rogue can be in a ceiling, under a desk, in a locked closet someone gave keys to in 2019.
- Walk the CAM table. The switch knows which port the rogue MAC is on. The port label tells you the wall jack. The wall jack tells you the room. Go to the room.
- If you've confirmed a rogue DHCP and can't immediately find it: shut the port at the switch. Service restoration first, archaeology second.

## Related concepts

[[DHCP]] · [[DNS]] · [[DNSSEC]] · [[NTP]] · [[DHCP Snooping]] · [[Dynamic ARP Inspection]] · [[802.1X]] · [[Port Security]] · [[SLAAC]] · [[RA Guard]] · [[DoH and DoT]] · [[PTP]] · [[NTS]] · [[Man-in-the-Middle Attacks]] · [[DNS Poisoning]]

*Source: VIRGIL knowledge base — 2026-05-11*