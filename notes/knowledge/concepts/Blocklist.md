# Blocklist

## What it is
Think of a blocklist like a club bouncer holding a "do not admit" list — anyone whose name appears on it gets turned away at the door, no questions asked. Precisely, a blocklist (formerly "blacklist") is a security control that explicitly denies access to known-bad entities — IP addresses, domains, file hashes, email senders, or applications — while allowing everything else by default.

## Why it matters
In 2016, the Mirai botnet used hundreds of thousands of compromised IoT devices to launch massive DDoS attacks; network defenders who had blocklisted known Mirai command-and-control IP addresses could drop malicious traffic before it overwhelmed their infrastructure. This illustrates both the power and the limitation of blocklists: they only stop threats you already know about.

## Key facts
- Blocklists operate on a **default-allow** model — everything not explicitly blocked is permitted, making them weaker than allowlists against zero-day threats
- **Threat intelligence feeds** (e.g., from ISACs, VirusTotal, or AlienVault OTX) are commonly used to dynamically populate and update IP/domain blocklists
- File hash blocklisting is used in endpoint security to prevent execution of known malware samples — a single bit change in a file produces a completely different hash, evading hash-based blocks
- Email security uses **domain blocklists** (DNSBLs) to reject mail from known spam or phishing sources at the MTA level
- Blocklists suffer from **false positives** (blocking legitimate traffic) and **stale entries** — a significant operational concern in enterprise environments

## Related concepts
[[Allowlist]] [[Threat Intelligence]] [[Intrusion Prevention System]] [[DNS Sinkhole]] [[Indicators of Compromise]]