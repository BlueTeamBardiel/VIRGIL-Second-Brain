# H3C Magic B1

## What it is
Like a master key hidden under the doormat by the manufacturer, the H3C Magic B1 is a consumer Wi-Fi router that shipped with hardcoded default credentials and an unauthenticated remote code execution vulnerability in its web management interface. Specifically, CVE-2022-25075 (and related CVEs) affect this device, allowing attackers to execute arbitrary commands without authentication via a crafted HTTP request to the router's administrative endpoint.

## Why it matters
In 2022, the H3C Magic B1 was actively targeted by Mirai botnet variants that scanned for exposed management interfaces and used the unauthenticated RCE flaw to recruit routers into DDoS swarms. A homeowner or small business with this router exposed to the internet — even with a changed password — could have their device silently enslaved because the vulnerability bypassed authentication entirely, making credential hygiene irrelevant.

## Key facts
- **CVE-2022-25075**: Unauthenticated RCE via the `/goform/execCommand` endpoint; CVSS score rated Critical (9.8).
- The vulnerability stems from **improper input sanitization** in the router's CGI-based web interface, allowing OS command injection.
- H3C Magic B1 runs on a **MIPS architecture**, making it a prime target for Mirai-family malware compiled for MIPS.
- Default credentials (`admin/admin`) compound the risk, but the RCE exists **regardless of password changes** — a classic authentication bypass scenario.
- Patching required a **firmware update from the vendor**; no workaround existed short of disabling remote management and placing the device behind a firewall.

## Related concepts
[[Command Injection]] [[Mirai Botnet]] [[CVE Scoring (CVSS)]] [[IoT Security]] [[Default Credentials]]