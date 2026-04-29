# Mail Gateway

## What it is
Think of it as a bouncer at a nightclub who checks IDs, searches for weapons, and turns away known troublemakers — all before anyone enters the building. A mail gateway is a security appliance or service that sits at the boundary of an organization's email infrastructure, inspecting all inbound and outbound messages for threats, policy violations, and spam before they ever reach the mail server or end user.

## Why it matters
In a Business Email Compromise (BEC) attack, threat actors spoof a CFO's email address to trick an employee into wiring funds. A properly configured mail gateway enforcing SPF, DKIM, and DMARC would reject or quarantine that spoofed message entirely, breaking the attack chain before the phishing email ever reaches the inbox. Without it, the organization relies entirely on user awareness — the weakest link.

## Key facts
- Mail gateways perform **anti-spam, anti-malware, content filtering, and DLP** (Data Loss Prevention) functions in a single chokepoint
- They enforce **SPF** (Sender Policy Framework), **DKIM** (DomainKeys Identified Mail), and **DMARC** to authenticate sender identity and reduce spoofing
- Can be deployed as on-premises hardware, virtual appliances, or **cloud-based services** (e.g., Proofpoint, Mimecast, Microsoft Defender for Office 365)
- Outbound scanning prevents **data exfiltration** via email and stops your domain from being used to send spam (protecting your IP reputation)
- On the Security+ exam, mail gateways appear under **secure network architecture** and **email security controls** — know that they operate at the **application layer (Layer 7)**

## Related concepts
[[SPF (Sender Policy Framework)]] [[DKIM]] [[DMARC]] [[Data Loss Prevention]] [[Phishing]]