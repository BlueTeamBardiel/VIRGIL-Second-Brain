# Data Loss Prevention

## What it is
Think of DLP like a security guard at a document shredding facility who checks every box leaving the building — if it contains social security numbers or blueprints, it doesn't walk out the door. Data Loss Prevention (DLP) is a set of tools and policies that monitor, detect, and block the unauthorized transmission, storage, or use of sensitive data. It inspects content in motion (network), at rest (storage), and in use (endpoints) to prevent accidental or malicious exfiltration.

## Why it matters
In 2019, a Capital One insider used misconfigured cloud access to exfiltrate 100 million customer records — a properly tuned DLP policy monitoring for bulk S3 bucket reads and outbound data transfers could have triggered an alert before the damage was done. DLP is also a frontline control against employees emailing customer PII to personal Gmail accounts or uploading proprietary source code to public GitHub repositories.

## Key facts
- DLP operates in three states: **data in motion** (network traffic), **data at rest** (stored files/databases), and **data in use** (active processes, clipboard, USB)
- Content inspection techniques include **keyword matching, regex patterns, exact data matching (EDM), and fingerprinting** to identify sensitive data like SSNs, credit card numbers, or PHI
- DLP can be **policy-based** (block all SSNs leaving the network) or **user behavior-based** (alert on anomalous bulk transfers)
- Endpoint DLP agents can block USB drives, control print jobs, and prevent screen captures of sensitive documents
- DLP is a required control under compliance frameworks including **HIPAA, PCI-DSS, and GDPR** for protecting regulated data categories

## Related concepts
[[Data Classification]] [[Insider Threat]] [[Exfiltration Techniques]] [[Cloud Access Security Broker]] [[Information Rights Management]]