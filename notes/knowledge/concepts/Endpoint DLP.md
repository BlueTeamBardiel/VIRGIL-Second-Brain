# Endpoint DLP

## What it is
Think of it like a customs officer stationed inside your laptop — inspecting every piece of data trying to leave through USB ports, email clients, or cloud uploads before it crosses the border. Endpoint Data Loss Prevention (DLP) is software installed directly on user devices that monitors, detects, and blocks unauthorized transmission of sensitive data based on predefined policies, regardless of network connectivity.

## Why it matters
A disgruntled HR employee at a healthcare company plugs in a personal USB drive and attempts to copy 50,000 patient records before resigning. Endpoint DLP intercepts the file transfer, blocks it based on regex patterns matching Social Security and medical record numbers, and simultaneously alerts the security team — preventing both a HIPAA breach and a costly notification process.

## Key facts
- Endpoint DLP operates **at the device level**, meaning it enforces policy even when users are off-network (on home Wi-Fi or airplane mode), unlike network DLP which only sees traffic passing through a gateway
- Common enforcement actions include **block, quarantine, encrypt, alert, and log** — policies can be graduated so low-risk transfers warn users while high-risk transfers are hard-blocked
- **Content inspection methods** include keyword matching, regular expressions, exact data matching (EDM), and fingerprinting of structured data like database exports
- Endpoint DLP agents typically integrate with **Active Directory/LDAP** to apply role-based policies (e.g., finance staff can export spreadsheets; contractors cannot)
- For Security+/CySA+: DLP maps directly to the **protect function of the NIST CSF** and is a primary control for preventing **data exfiltration** in insider threat scenarios

## Related concepts
[[Data Loss Prevention]] [[Insider Threat]] [[Data Classification]] [[USB Blocking]] [[UEBA]]