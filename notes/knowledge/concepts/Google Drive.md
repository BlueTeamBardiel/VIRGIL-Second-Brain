# Google Drive

## What it is
Think of Google Drive like a postal service that also acts as your filing cabinet — except the building is owned by Google, the mailman reads your labels, and anyone with the right link can walk in. Precisely, Google Drive is a cloud-based file storage and collaboration platform that stores data on Google's infrastructure, accessible via browser, API, or synced desktop client.

## Why it matters
Attackers regularly abuse Google Drive as a **C2 channel and malware distribution hub** because outbound HTTPS traffic to `drive.google.com` is rarely blocked by corporate firewalls — it blends into normal business traffic. In documented campaigns (e.g., APT29/Cozy Bear), threat actors stored encrypted payloads or exfiltrated data through shared Drive links, knowing defenders struggle to inspect TLS traffic to trusted Google IPs without breaking legitimate workflows.

## Key facts
- **Sharing misconfiguration** is the #1 risk: files set to "Anyone with the link" are publicly indexed and discoverable via Google Dorks (`site:drive.google.com confidential`).
- Google Drive uses **AES-256 encryption at rest** and **TLS in transit**, but Google holds the encryption keys — not the user (no zero-knowledge encryption by default).
- OAuth tokens granting Drive access persist even after a user's password is changed, making **token revocation** a critical incident response step.
- Drive activity logs are available in **Google Workspace Admin Console** and can be forwarded to a SIEM for DLP monitoring.
- Data exfiltration via Drive can bypass traditional **DLP tools** that only inspect email gateways, requiring API-level inspection or CASB integration.

## Related concepts
[[Cloud Storage Security]] [[OAuth 2.0]] [[Data Loss Prevention (DLP)]] [[CASB]] [[Command and Control (C2)]]