# DNS Configuration

## What it is

You type `steamcommunity.com` into your browser. Your machine has no idea what that means. It's a string of letters. The internet runs on numbers — IP addresses like `23.45.112.190`. Something has to translate.

That something is **DNS — the Domain Name System.** It's the phonebook of the internet. You give it a name, it gives you back an address. Without DNS, you'd be memorizing IPs like phone numbers in 1987.

DNS is a hierarchical, distributed database. No single server knows every name on the internet — that would be insane. Instead, queries walk a chain: your local resolver asks a root server, root points to the TLD server (`.com`, `.org`), TLD points to the authoritative server for that domain, and the authoritative server hands back the actual record. Cached at every step so the next lookup is instant.

DNS records aren't just name-to-IP. They're a whole record system: **A** (IPv4 address), **AAAA** (IPv6 address — pronounced "quad-A"), **CNAME** (alias pointing one name at another), **MX** (mail exchanger — where email for this domain goes), and **TXT** (free-form text, used for everything from domain ownership proof to email anti-spam policy).

The TXT records are where modern DNS stops being just a phonebook and becomes part of your security posture. **SPF, DKIM, and DMARC** all live in TXT records and tell the world how to verify legitimate email from your domain. Misconfigure them and your invoices land in spam — or worse, attackers spoof your domain freely.

## Why it matters

DNS is the dependency nobody thinks about until it breaks. When DNS fails, *nothing* works — not email, not web, not Active Directory logins, not license activation, not your VPN. The classic helpdesk pattern is "the internet is down" → ping `8.8.8.8` works → ping `google.com` fails → DNS is broken.

Objective 220-1201 2.4 puts DNS, DHCP, VLAN, and VPN together because these four are the load-bearing pillars of every network you'll ever touch. CompTIA tests record types relentlessly — A vs AAAA vs CNAME vs MX vs TXT — and they test the email-auth trio (SPF, DKIM, DMARC) because spoofing and phishing are the #1 attack vector in the field.

## In your build, in the enterprise

**Beat 1 — Technical depth.** DNS runs on UDP/53 for queries and TCP/53 for zone transfers and large responses. Records have a TTL (time-to-live) that controls how long resolvers cache them — short TTL means changes propagate fast but generate more query traffic, long TTL means stale records linger after you change something. The record types you must know cold:

| Record | Purpose |
|---|---|
| **A** | Hostname → IPv4 address |
| **AAAA** | Hostname → IPv6 address |
| **CNAME** | Alias — points one name at another name (not an IP) |
| **MX** | Mail exchanger — receives email for the domain, has priority value |
| **TXT** | Arbitrary text — used for SPF, DKIM, DMARC, domain verification |
| **NS** | Name server — which servers are authoritative for this zone |
| **PTR** | Reverse lookup — IP → hostname |

The email-auth trio, all stored as TXT records:
- **SPF (Sender Policy Framework)** — TXT record listing which IPs are allowed to send mail as your domain. Receiving servers check inbound mail's source IP against this list.
- **DKIM (DomainKeys Identified Mail)** — cryptographic signature on outbound mail. The public key lives in a TXT record at `selector._domainkey.yourdomain.com`. Receivers verify the signature against the published key.
- **DMARC (Domain-based Message Authentication, Reporting, and Conformance)** — a TXT record at `_dmarc.yourdomain.com` that tells receivers what to do when SPF or DKIM fails (none, quarantine, reject) and where to send aggregate reports.

**Beat 2 — Feynman example via gaming/personal build.** You buy a domain for your homelab — `mylab.dev`. Now you're the DNS admin.

**The first record:** You point `mylab.dev` at your home server's public IP with an **A record**. Type the name in a browser, the page loads. *DNS is working.*

**The alias trick:** You want `plex.mylab.dev`, `jellyfin.mylab.dev`, and `nextcloud.mylab.dev` to all hit the same reverse proxy. You make one A record for `home.mylab.dev` and three **CNAMEs** pointing at it. Now if your IP changes, you update one record instead of four. *CNAMEs are how you stop repeating yourself.*

**The IPv6 awakening:** Your ISP gives you IPv6. You add **AAAA records** alongside the A records. Modern clients prefer AAAA. *Same name, two address families, both work.*

**The mail disaster:** You set up a mail server on your homelab to send notifications. Every email lands in spam. Why? No SPF, no DKIM, no DMARC. Gmail looks at mail from `mylab.dev`, sees zero authentication records, assumes spoofing, dunks it into the spam folder. You add an SPF TXT record listing your mail server's IP, generate DKIM keys and publish the public key, then add a DMARC record set to `p=none` so you can monitor before enforcing. Inbox delivery returns. *DNS isn't just addresses — it's identity.*

**Beat 3 — Bridge from gaming homelab to enterprise.** Same fundamental question — "how does this name resolve?" — different scale.

At home: one domain, maybe ten records, you edit them in your registrar's web UI when the mood strikes. DNS for your LAN is whatever your router hands out.

In a 5,000-user enterprise: hundreds of domains and subdomains, internal DNS for Active Directory (every domain controller is also a DNS server — AD literally cannot function without DNS), split-horizon DNS so internal users get internal IPs and external users get the public IP, dynamic DNS for clients that get DHCP leases and need their hostnames registered automatically. Changes go through change management. SPF, DKIM, and DMARC are mandatory because finance won't accept invoices that fail authentication, and the SOC monitors DMARC reports for spoofing attempts against the company brand.

**Beat 4 — The point.** Same fundamental question, different scale, different right answers. *Get this question into your bones — "how does this name resolve, and who's authoritative for it?" You'll ask it for the rest of your career, on every troubleshooting call that touches the network.*

## Key facts

### DNS record types — exam-tier mastery

| Record | What it does | Example |
|---|---|---|
| **A** | IPv4 address for a hostname | `web.example.com → 192.0.2.10` |
| **AAAA** | IPv6 address for a hostname | `web.example.com → 2001:db8::10` |
| **CNAME** | Alias — points to another name, not an IP | `www.example.com → example.com` |
| **MX** | Mail server for the domain (with priority) | `example.com → 10 mail.example.com` |
| **TXT** | Arbitrary text — SPF, DKIM, DMARC, verification | `"v=spf1 include:_spf.google.com ~all"` |
| **NS** | Authoritative name server for the zone | `example.com → ns1.cloudflare.com` |
| **PTR** | Reverse — IP back to hostname | `10.2.0.192.in-addr.arpa → web.example.com` |

### Email authentication trio (all TXT records)

- **SPF** — "These IPs are allowed to send mail as me." Published as a TXT record on the domain itself.
- **DKIM** — "This message was cryptographically signed by me." Public key published as TXT at `selector._domainkey.domain.com`.
- **DMARC** — "If SPF or DKIM fail, here's what receivers should do, and here's where to send reports." TXT record at `_dmarc.domain.com`. Policies: `none` (monitor only), `quarantine` (spam folder), `reject` (bounce).

### CompTIA exam traps

> **CompTIA exam trap:** A vs AAAA. A is IPv4 (32-bit). AAAA is IPv6 (128-bit, four times the bits — hence four A's). They tested this on the old exam and they test it on the new one. Don't lose this point.

> **CompTIA exam trap:** CNAME points to a *name*, not an IP. If the question says "alias one hostname to another," it's CNAME. If it says "map a hostname to an address," it's A or AAAA. CNAMEs cannot exist at the zone apex (the bare domain) in standard DNS — only on subdomains.

> **CompTIA exam trap:** MX records have a *priority* value. Lower number = higher priority (tried first). This catches people who assume higher number = more important.

> **CompTIA exam trap:** SPF, DKIM, and DMARC are all TXT records. CompTIA loves to ask "which record type holds the SPF policy?" The answer is TXT. There used to be a dedicated SPF record type — it was deprecated. TXT is correct.

> **CompTIA exam trap:** DMARC stands for **Domain-based Message Authentication, Reporting, and Conformance.** Memorize the expansion. They will ask.

### DNS troubleshooting tools

| Tool | Platform | Use |
|---|---|---|
| `nslookup` | Windows, Linux, macOS | Quick lookup, interactive mode for changing servers |
| `dig` | Linux, macOS (Windows via install) | Detailed query output, the pro tool |
| `ipconfig /flushdns` | Windows | Clears local resolver cache |
| `ipconfig /displaydns` | Windows | Shows cached entries |

When DNS misbehaves, flush the cache first. Then query against `8.8.8.8` (Google) or `1.1.1.1` (Cloudflare) directly to bypass your local resolver. If public DNS resolves and your internal DNS doesn't, the problem is your DNS server — not the internet.

### Home vs enterprise DNS

| Aspect | Home / homelab | Enterprise |
|---|---|---|
| **Public records** | Edited in registrar web UI | Managed via IPAM tools, change-controlled |
| **Internal DNS** | Whatever the router does | Active Directory–integrated DNS on domain controllers |
| **Split-horizon** | Not a thing | Internal and external views of same domain |
| **Email auth** | Often skipped (and mail goes to spam) | SPF + DKIM + DMARC mandatory |
| **Monitoring** | You notice when it breaks | SOC monitors DMARC aggregate reports daily |
| **Redundancy** | One DNS provider | Multiple authoritative servers, secondary DNS provider for failover |

In an enterprise, every domain controller is a DNS server. AD logins, group policy, Kerberos — none of it works without functional DNS. "DNS is broken" in an AD environment is a five-alarm fire.

## Helpdesk reality

- **"The internet is down."** Ping `8.8.8.8`. Works? It's DNS. Doesn't work? It's the connection. This is the first 30 seconds of every "internet down" ticket.
- **"I can get to the website on my phone but not on my laptop."** Phone is on cellular (different DNS), laptop is on Wi-Fi using the company DNS server. Company DNS is having a moment. Try `ipconfig /flushdns`, then escalate to network team if it persists.
- **"My emails to this client are going to spam."** Check the domain's SPF, DKIM, and DMARC records with an online checker. Nine times out of ten, marketing added a new sending platform (HubSpot, Mailchimp) and nobody updated SPF to authorize it.
- **"I changed my website's IP yesterday and some people still see the old version."** TTL caching. Their resolvers cached the old A record. Wait for TTL to expire or have them flush DNS.
- **Never promise "DNS changes are instant."** Propagation is real. TTL is real. ISP resolvers cache aggressively. "Allow up to 24 hours" is the honest answer, even if it usually finishes in minutes.

## Related concepts

[[DHCP]] · [[VLAN]] · [[VPN]] · [[IPv4 vs IPv6]] · [[Active Directory]] · [[Network Troubleshooting]] · [[Email Protocols (SMTP IMAP POP3)]] · [[Phishing and Email Spoofing]]

*Source: VIRGIL knowledge base — 2026-05-10*