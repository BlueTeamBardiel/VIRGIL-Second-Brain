# DNS

## What it is

When you type `netflix.com` into your browser, your computer has no idea where that actually lives. It needs an IP address — the actual street address of the server. DNS (Domain Name System) is the contact list your phone keeps so you can text "Mom" instead of memorizing her phone number. You type the friendly name, DNS hands back the digits.

Technically, DNS is a hierarchical, distributed protocol that resolves human-readable domain names into IP addresses. Hierarchical because it's organized like a tree — root servers at the top, then TLDs (`.com`, `.net`, `.org`), then domains (`netflix.com`), then subdomains (`api.netflix.com`). Distributed because no single server holds the whole list; resolvers chain queries upward until they find an authority that knows the answer, then cache it so they don't have to ask again next time.

It runs primarily over **UDP port 53** — fire-and-forget, fast, low overhead. Most lookups are tiny (a few hundred bytes), so the connection setup of TCP would be wasteful. **TCP port 53** kicks in for two cases: zone transfers (entire DNS records being copied between servers) and any response over 512 bytes that won't fit in a single UDP datagram.

## Why it matters

DNS is the trust layer underneath everything. Every login, every banking session, every game server connection starts with a DNS lookup. If that lookup lies to you, the padlock in your browser is meaningless — you connected securely to the wrong server. It's the equivalent of a Watch Dogs 2 ctOS hack where Marcus reroutes a target's GPS: the victim follows the instructions perfectly, just to the wrong destination.

DNS is also one of the most abused protocols on the internet because firewalls almost always let it through. Blocking port 53 outbound would break the entire network, so attackers treat DNS as a reliable smuggling tunnel out of restricted environments.

## Key facts

### Core protocol
- **UDP/53** for standard queries — fast, stateless, the default.
- **TCP/53** for zone transfers and responses larger than 512 bytes — when UDP can't carry the payload, it falls back to TCP like a download switching from "preview" to "full file."

### DNS poisoning (cache poisoning)
- An attacker injects forged records into a resolver's cache so future queries return the attacker's IP. Like editing the contact "Mom" in someone's phone to point to your number — every call from now on goes to you, and they never notice.
- The **2008 Kaminsky vulnerability** is the canonical example. Dan Kaminsky discovered that DNS transaction IDs were predictable and resolvers accepted answers for queries they hadn't even made, given the right timing. A single attacker could poison an ISP's resolver and silently redirect millions of customers — every bank, every email login — through their server. Industry-wide emergency patching followed.

### DNSSEC
- DNSSEC cryptographically signs DNS records using public-key crypto. The resolver verifies the signature against a chain of trust rooted at the DNS root — if the signature is invalid, the record is rejected.
- This is the tamper-evident sticker on a delivery box. You can still read what's inside (DNSSEC does **not encrypt**), but you can prove nobody swapped the contents in transit.
- Provides **integrity and authenticity**, not confidentiality. Your ISP can still see every domain you look up.

### DNS zone transfers as recon
- A zone transfer (AXFR) dumps every record in a DNS zone — every subdomain, every internal host name. If `Styx Networking` misconfigures their DNS server to allow public AXFR, an attacker pulls down a full map of their infrastructure: `vpn.styx.com`, `dev-staging.styx.com`, `backup-server.styx.com`. It's the reconnaissance equivalent of finding the full base layout in Escape from Tarkov before the raid even starts.

### DNS tunneling
- Data gets encoded into DNS query names. `aGVsbG8gd29ybGQ.attacker.com` looks like a weird subdomain lookup, but the prefix is base64-encoded stolen data. The attacker's authoritative server decodes it and replies, often with more encoded data in the response.
- Used for **data exfiltration** and **command-and-control (C2)** channels. Malware on an internal host phones home through DNS queries, receiving instructions in TXT or CNAME responses.
- Why it works: firewalls almost universally permit outbound DNS, because breaking DNS breaks everything. It's smuggling messages inside library returns when the guards only check the front gate.

### DoH and DoT (encrypted DNS)
- **DNS over HTTPS (DoH)** wraps DNS queries inside HTTPS — port 443, indistinguishable from normal web traffic.
- **DNS over TLS (DoT)** wraps DNS queries inside a TLS tunnel on port 853 — encrypted but identifiable as DNS traffic by port.
- Both prevent **ISP-level tracking** of which sites you visit. Without them, even with HTTPS protecting the page contents, your ISP sees every domain you query in plaintext — they know you went to `pokemon-leaks.com` even if they can't read what you did there.
- DoH is harder for network operators to block or monitor because it blends with regular HTTPS; this is great for privacy and inconvenient for enterprise security teams trying to inspect traffic.

## Related concepts
[[DNSSEC]]
[[DNS over HTTPS (DoH)]]
[[DNS over TLS (DoT)]]
[[Cache poisoning]]
[[Kaminsky attack]]
[[Zone transfer (AXFR)]]
[[DNS tunneling]]
[[Command and Control (C2)]]
[[UDP]]
[[TCP]]
[[Public Key Infrastructure (PKI)]]