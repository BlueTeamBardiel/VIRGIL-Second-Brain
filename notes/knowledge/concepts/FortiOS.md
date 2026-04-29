# FortiOS

## What it is
Think of FortiOS as the brain inside a Swiss Army knife for network security — it's the operating system that runs on Fortinet's FortiGate appliances, orchestrating every security function from a single platform. Precisely, FortiOS is a purpose-built, hardened OS that powers FortiGate next-generation firewalls (NGFWs), enabling unified management of firewall rules, VPN, IPS, web filtering, and SSL inspection from one interface.

## Why it matters
In 2022, CISA issued emergency directives after threat actors (including nation-state groups) mass-exploited CVE-2022-40684 — a critical authentication bypass in FortiOS that allowed unauthenticated attackers to perform admin operations via crafted HTTP requests. Organizations running unpatched FortiGate devices had their configurations hijacked and backdoor accounts planted, demonstrating how a flaw in a security appliance's OS can turn your perimeter defense into an entry point.

## Key facts
- FortiOS vulnerabilities frequently appear in CISA's Known Exploited Vulnerabilities (KEV) catalog, making patch cadence critical for compliance frameworks like NIST CSF
- FortiOS supports SSL/TLS deep packet inspection, allowing it to decrypt, inspect, and re-encrypt HTTPS traffic to detect threats hidden in encrypted channels
- The OS uses Security Processing Units (SPUs/ASICs) — custom Fortinet hardware chips — to accelerate threat inspection without degrading throughput
- FortiOS integrates with Fortinet's Security Fabric, enabling coordinated telemetry and response across endpoints, switches, and cloud environments (relevant to XDR concepts)
- Default admin credentials and exposed management interfaces on port 443 or 8443 are a common misconfiguration vector flagged in CySA+ scenarios

## Related concepts
[[Next-Generation Firewall]] [[SSL Inspection]] [[CVE Exploitation]] [[Network Segmentation]] [[Security Fabric]]