# Cisco Unity Connection

## What it is
Think of it as a voicemail post office embedded directly inside a corporate network — it receives, stores, and routes audio messages just like a mail server handles email. Cisco Unity Connection (CUC) is a unified messaging and voicemail platform that integrates with Cisco Unified Communications Manager (CUCM), allowing users to access voicemail via phone, email clients, or a web interface. It runs on a hardened Linux appliance (Cisco UCS hardware) or as a virtual machine.

## Why it matters
In 2012, a critical SQL injection vulnerability (CVE-2012-4655) was discovered in the CUC web interface, allowing unauthenticated attackers to extract voicemail credentials and potentially pivot into the broader corporate network. This is a perfect example of how unified communications platforms expand the attack surface beyond traditional IT systems — voicemail servers now become entry points for credential harvesting and lateral movement.

## Key facts
- Runs on **Cisco's VOSS (Voice Operating System)**, a hardened Linux derivative — direct OS access is restricted by design
- Default admin interface runs on **HTTPS port 443** and the Cisco Unified Serviceability portal on port **8443**
- Historically vulnerable to **path traversal, SQL injection, and privilege escalation** attacks via its web-based admin GUI
- Supports **LDAP integration** for authentication, meaning a compromised AD account can grant voicemail access
- Voicemail messages are stored as **.wav files** on the server — if accessed, they may contain sensitive spoken credentials or business intelligence

## Related concepts
[[Unified Communications Security]] [[VoIP Security]] [[LDAP Injection]] [[Cisco Unified Communications Manager]] [[Privilege Escalation]]