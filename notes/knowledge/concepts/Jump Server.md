# jump server

## What it is
Think of it like a security checkpoint booth at a military base — you can't drive directly to the classified building; you must stop at the booth first, show credentials, and be escorted in. A jump server (also called a bastion host or jump box) is a hardened, single-purpose intermediary host used to access systems inside a secure or isolated network segment. Administrators connect *to* the jump server first, then pivot *from* it to reach internal targets.

## Why it matters
During the 2020 SolarWinds breach, attackers moved laterally through internal networks precisely because direct administrative access wasn't funneled through strict chokepoints. A properly configured jump server would have created a centralized audit log of all privileged sessions, making anomalous lateral movement far easier to detect and contain. It's both a preventive control (limiting attack surface) and a detective control (centralizing logs).

## Key facts
- Jump servers sit in a **DMZ or management VLAN**, never on the same flat network as the systems they protect
- They enforce **MFA and privileged access management (PAM)** — no direct SSH/RDP to production systems without going through the jump box first
- All sessions are typically **recorded and logged** (keystroke logging, session replay) for forensic audit trails
- A jump server should run **minimal services** — no email, no web browsing, hardened OS — to reduce its own attack surface
- If a jump server is compromised, an attacker gains a **"keys to the kingdom" pivot point**, so it must be treated as a Tier 0 critical asset

## Related concepts
[[bastion host]] [[network segmentation]] [[privileged access management]] [[DMZ]] [[lateral movement]]