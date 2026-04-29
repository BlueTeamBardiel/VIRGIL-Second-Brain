# Passive Scanning

## What it is
Like a spy sitting in a café reading discarded newspapers rather than asking questions, passive scanning collects information about a target network by observing traffic that already exists — never sending a single packet of your own. It is the practice of gathering reconnaissance data (open ports, OS fingerprints, services, hosts) by capturing and analyzing ambient network traffic, DNS responses, or public records without directly probing the target system.

## Why it matters
During a red team engagement, an attacker uses passive scanning tools like **Wireshark** or **p0f** to silently fingerprint every host on a subnet by watching broadcast traffic and ARP requests — zero detection risk because no anomalous packets hit the wire. Defensively, a SOC analyst might use passive scanning via a network tap to build an asset inventory without disrupting production systems or triggering IDS alerts on the monitoring tool itself.

## Key facts
- **No packets sent to the target** — this is the defining characteristic that separates passive from active scanning; it produces no entries in the target's connection logs
- **p0f** is a classic passive OS fingerprinting tool that identifies operating systems solely by analyzing TCP/IP header quirks in captured traffic
- Passive scanning is often combined with **OSINT** (Shodan, Censys, DNS history) to build a target profile before any active probing begins
- **Stealth trade-off**: passive scanning is far less detectable but also less complete — it can only discover hosts and services that are actively communicating
- On Security+/CySA+ exams, passive reconnaissance is associated with the **planning/pre-engagement phase** and is contrasted with active scanning techniques like Nmap SYN scans

## Related concepts
[[Active Scanning]] [[Network Reconnaissance]] [[OSINT]] [[Traffic Analysis]] [[OS Fingerprinting]]