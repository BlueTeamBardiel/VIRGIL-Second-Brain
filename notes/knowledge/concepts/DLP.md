# DLP

## What it is
Like a bouncer at a nightclub checking IDs at the door, DLP (Data Loss Prevention) inspects data leaving your network and decides what's allowed out based on predefined rules. It is a set of tools and policies that detect and prevent unauthorized transmission, exfiltration, or exposure of sensitive data — whether in motion (network), at rest (storage), or in use (endpoint).

## Why it matters
An insider threat at a healthcare company copies 50,000 patient records to a personal USB drive. A properly configured endpoint DLP solution detects the transfer, blocks it, and alerts the security team — preventing a HIPAA breach and a six-figure fine. Without DLP, the exfiltration goes unnoticed until a regulator or journalist finds the data on the dark web.

## Key facts
- DLP operates in three states: **data in motion** (network traffic), **data at rest** (stored files), and **data in use** (active endpoint activity)
- Common detection methods include **keyword matching**, **regular expressions** (e.g., SSN patterns: \d{3}-\d{2}-\d{4}), **file fingerprinting**, and **machine learning classification**
- DLP can operate in **monitor mode** (alerts only) or **block mode** (actively prevents transfer) — misconfigured block mode is a common cause of business disruption
- Cloud-based DLP (often delivered via CASB) extends protection to SaaS platforms like Google Drive and Microsoft 365
- DLP violations are a key data source for **UEBA** (User and Entity Behavior Analytics) and insider threat detection programs

## Related concepts
[[Data Classification]] [[CASB]] [[Insider Threat]] [[UEBA]] [[Endpoint Security]]