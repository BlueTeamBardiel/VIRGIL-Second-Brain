# MITRE ATT&CK T1071.1

## What it is
Like a spy hiding secret messages inside ordinary postcards, adversaries smuggle command-and-control (C2) traffic inside standard HTTP/HTTPS requests so it blends invisibly with normal web browsing. T1071.1 describes the use of the Web Protocols application layer — HTTP (port 80) and HTTPS (port 443) — as a C2 communication channel to evade network defenses.

## Why it matters
During the APT41 campaigns, attackers used HTTPS-based C2 traffic that was virtually indistinguishable from legitimate browser traffic, allowing them to maintain persistent access through corporate firewalls that permitted outbound web traffic without deep inspection. Defenders countering this tactic deploy TLS inspection proxies and behavioral analytics to detect beaconing patterns — regular, clock-like C2 check-ins — even when payload content is encrypted.

## Key facts
- **Sub-technique of T1071** (Application Layer Protocol); other sub-techniques include DNS (T1071.4) and SMTP (T1071.3)
- Attackers exploit the fact that HTTP/HTTPS is almost universally allowed outbound, making firewall blocking impractical
- **Beaconing detection** is the primary hunting technique — C2 callbacks occur at suspiciously regular intervals (e.g., every 60 seconds), which legitimate browsers don't do
- HTTPS-based C2 defeats payload inspection but NOT traffic metadata analysis (JA3 fingerprinting can identify malicious TLS clients)
- Tools like **Cobalt Strike, Metasploit, and Covenant** use HTTP/HTTPS malleable C2 profiles specifically to mimic legitimate browser traffic patterns

## Related concepts
[[Command and Control]] [[Beaconing Detection]] [[TLS Inspection]] [[JA3 Fingerprinting]] [[Network Traffic Analysis]]