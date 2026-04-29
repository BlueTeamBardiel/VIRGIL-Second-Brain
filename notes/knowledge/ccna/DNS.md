# DNS

## What it is
Think of DNS as the internet's phone book — you look up a name (google.com) and get back a number (142.250.80.46) so your device knows where to actually call. More precisely, DNS (Domain Name System) is a hierarchical, distributed protocol that resolves human-readable domain names into IP addresses. It operates primarily over UDP port 53, with TCP used for larger responses or zone transfers.

## Why it matters
DNS poisoning (cache poisoning) is a classic attack where an adversary injects forged DNS records into a resolver's cache, redirecting victims to malicious servers — even when they type a perfectly legitimate URL. The 2008 Kaminsky vulnerability demonstrated this at scale, allowing attackers to redirect entire ISP customer bases. DNSSEC was developed specifically to cryptographically sign DNS records and defeat this class of attack.

## Key facts
- DNS operates over **UDP port 53** by default; **TCP port 53** is used for zone transfers (AXFR) and responses exceeding 512 bytes
- **DNS zone transfers** are a significant reconnaissance risk — misconfigured servers can hand attackers a complete map of internal hostnames
- **DNS tunneling** abuses DNS queries to exfiltrate data or establish C2 channels, often bypassing firewall rules that permit DNS traffic
- **DNSSEC** adds digital signatures to DNS records but does *not* encrypt them — it provides integrity and authenticity, not confidentiality
- **DNS over HTTPS (DoH)** and **DNS over TLS (DoT)** encrypt DNS queries, preventing eavesdropping and ISP-level tracking

## Related concepts
[[DNSSEC]] [[DNS Poisoning]] [[DNS Tunneling]] [[Zone Transfer]] [[DNS over HTTPS]]