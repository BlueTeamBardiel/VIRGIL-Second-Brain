# DNS TXT Records

## What it is
Think of TXT records as the sticky notes plastered to the front door of a building — anyone walking by can read them, and building owners use them to broadcast short public messages. Precisely defined, DNS TXT records are arbitrary plaintext entries stored in a domain's DNS zone that allow domain owners to publish machine-readable or human-readable strings queryable by anyone on the internet. Originally designed for human annotation, they've become a critical mechanism for email authentication, domain ownership verification, and — unfortunately — attacker abuse.

## Why it matters
Attackers use DNS TXT records as a covert **command-and-control (C2) channel** in a technique called DNS tunneling — malware on a compromised host queries attacker-controlled TXT records to receive encoded commands, bypassing firewalls that allow DNS traffic. Defenders counter this by monitoring for unusually long or high-entropy TXT record responses (legitimate TXT records are short and readable; tunneled commands are not).

## Key facts
- **SPF records live here**: `v=spf1 include:... ~all` — a TXT record that specifies which mail servers are authorized to send email for a domain, directly preventing email spoofing
- **DKIM** publishes its public keys as TXT records under a selector subdomain (e.g., `selector._domainkey.example.com`), enabling receiving servers to verify email signatures
- **DMARC policy** is also published as a TXT record at `_dmarc.example.com`, instructing receivers what to do with SPF/DKIM failures (quarantine, reject, none)
- TXT records have a **255-character limit per string**, but multiple strings can be concatenated; total record size can reach ~4KB
- DNS TXT queries can be made with `nslookup -type=TXT domain.com` or `dig TXT domain.com` — standard recon tools used in both pentesting and threat hunting

## Related concepts
[[SPF Email Authentication]] [[DNS Tunneling]] [[DMARC Policy]]
