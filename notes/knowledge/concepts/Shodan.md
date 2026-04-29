# Shodan

## What it is
If Google indexes web pages, Shodan is the search engine that indexes *everything else* — the webcams, industrial controllers, routers, and servers that respond to network probes without ever being "browsed." Precisely, Shodan is an internet-wide search engine that continuously scans all routable IPv4 addresses, collects banner information from open ports, and makes that data searchable by service, version, location, or vulnerability.

## Why it matters
A penetration tester assessing an organization's external attack surface can query Shodan for the company's IP ranges and immediately discover an exposed Elasticsearch database returning customer records — no authentication required, because the developer assumed "nobody would find it." Defensively, security teams use Shodan Monitor to receive alerts when their own assets appear with newly opened ports or outdated service banners, effectively watching their exposure the same way an attacker would.

## Key facts
- Shodan scans all 65,535 ports across IPv4 space and collects **banner grabs** — raw text responses that reveal software name, version, and configuration details
- Searches can filter by **CVE number**, meaning an attacker can find every internet-exposed host running a vulnerable version of OpenSSH or Apache in seconds
- Shodan indexes **ICS/SCADA devices** (Modbus, DNP3, BACnet protocols), making it a primary reconnaissance tool for critical infrastructure threats
- The free tier allows limited searches; **API access** is used in automated red team tooling and threat intelligence platforms like Maltego and Recon-ng
- Shodan data is passive from the *user's* perspective — querying it generates **no traffic toward the target**, making it a pure OSINT activity

## Related concepts
[[OSINT]] [[Banner Grabbing]] [[Attack Surface Management]] [[Passive Reconnaissance]] [[Network Scanning]]