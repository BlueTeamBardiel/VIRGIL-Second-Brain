# UDP port 514

## What it is
Think of it as a one-way postal drop box where every device in your network tosses its diary entries — nobody signs for delivery, and the box never confirms receipt. UDP port 514 is the traditional transport for the **Syslog protocol**, used to ship event logs from routers, firewalls, switches, and servers to a centralized log collector (syslog server).

## Why it matters
An attacker who compromises a network device can forge syslog messages to a SIEM, injecting false log entries that obscure a breach or frame innocent hosts — a technique sometimes called **log injection**. Conversely, defenders configure syslog collection at this port to feed a SIEM (like Splunk or a Security Onion stack), making centralized log analysis possible for threat hunting and incident response.

## Key facts
- **UDP 514** is the legacy syslog port; RFC 5424 also defines **TCP 514** and **TCP/UDP 6514** (syslog over TLS) for reliability and encryption
- Syslog messages are **unencrypted and unauthenticated** by default — anyone on the network path can read or tamper with them
- Syslog severity levels run from **0 (Emergency)** to **7 (Debug)** — Security+ expects you to know this 0–7 scale
- Because it uses **UDP**, syslog provides no delivery guarantee; log entries can be silently dropped under network load
- Blocking or disrupting UDP 514 is a common attacker tactic to **prevent evidence collection** during an intrusion

## Related concepts
[[Syslog Protocol]] [[SIEM]] [[Log Management]] [[Network Forensics]] [[TLS Encryption]]