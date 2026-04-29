# Zeek

## What it is
Think of Zeek as a court stenographer for your network — it doesn't stop traffic, it transcribes *everything* that happens into structured, searchable logs. Zeek (formerly Bro) is an open-source network traffic analysis framework that passively monitors network flows and generates rich, protocol-aware logs covering DNS, HTTP, SSL, files, and connections. Unlike signature-based IDS tools, Zeek is a scripting platform for behavioral analysis rather than simple alerting.

## Why it matters
During the SolarWinds breach, attackers used covert DNS tunneling to exfiltrate data blended into legitimate-looking queries. Zeek's DNS logs capture query names, response sizes, query types, and timing — exactly the artifacts that reveal tunneling patterns (abnormally long subdomains, high query frequency) that a firewall would pass without comment. A defender writing a Zeek script could flag these outliers automatically without needing a malware signature.

## Key facts
- Zeek operates out-of-band on a **SPAN port or network tap** — it sees a copy of traffic and never interrupts flows (passive monitoring)
- Generates **structured tab-separated log files** (conn.log, dns.log, http.log, ssl.log, etc.) that integrate natively with SIEM tools like Splunk and Elastic
- Uses its own **Turing-complete scripting language** (Zeek Script) to define custom detection logic, extract files, and create new log types
- The `conn.log` file captures **source/destination IP, port, protocol, bytes transferred, and connection state** — the foundation for network baseline analysis
- Zeek is **not a replacement for Snort/Suricata**; it complements signature-based IDS by providing session context and metadata rather than payload inspection alerts

## Related concepts
[[Network Traffic Analysis]] [[SIEM]] [[Intrusion Detection System]] [[DNS Tunneling]] [[PCAP Analysis]]