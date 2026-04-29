# Hunchly

## What it is
Like a dashcam that automatically records everything your browser sees during an investigation, Hunchly is a Chrome extension designed for OSINT investigators that silently captures, timestamps, and hashes every web page visited during a session. It creates a legally defensible, tamper-evident record of your online investigation without requiring you to manually screenshot or save anything.

## Why it matters
During a criminal investigation into a suspected fraud network, an analyst using Hunchly can prove they visited a specific webpage on a specific date — and that the content hasn't been altered since — because each captured page is paired with a cryptographic hash. This is critical when website owners delete or modify content after becoming aware of an investigation, as the original capture becomes admissible evidence.

## Key facts
- Hunchly automatically captures pages in the background using a browser extension, requiring no manual intervention — reducing investigator error and omission
- Every captured page is assigned a **SHA-256 hash**, creating a cryptographic fingerprint that proves content integrity at time of capture
- Sessions are exportable as **case files** containing pages, selectors (filters), and a full activity log — supporting chain of custody documentation
- **Selectors** allow investigators to flag and track specific identifiers (emails, usernames, IP addresses) across all captured pages automatically
- Designed specifically for **OSINT and cyber threat intelligence (CTI)** workflows, not general forensics — it captures what the investigator *browsed*, not disk artifacts

## Related concepts
[[OSINT]] [[Chain of Custody]] [[Cryptographic Hashing]] [[Digital Forensics]] [[Threat Intelligence]]