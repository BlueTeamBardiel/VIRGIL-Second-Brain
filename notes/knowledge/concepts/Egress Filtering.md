# Egress Filtering

## What it is
Like a security guard who checks bags on the way *out* of a building — not just on the way in — egress filtering is the practice of inspecting and restricting outbound network traffic leaving an organization's network. It enforces rules on what data, protocols, and destinations are permitted to exit, complementing the more commonly deployed ingress filtering.

## Why it matters
During a ransomware intrusion, attackers frequently exfiltrate sensitive data before encrypting systems — a technique called "double extortion." Without egress filtering, a compromised endpoint can freely beacon to a command-and-control server or upload gigabytes of data via DNS tunneling or HTTPS to an attacker-controlled domain. Egress filtering would block or flag that unexpected outbound traffic, breaking the kill chain before data leaves the perimeter.

## Key facts
- **DNS tunneling detection**: Blocking or rate-limiting outbound DNS to unauthorized resolvers is a critical egress control, as attackers abuse port 53 to bypass firewalls.
- **RFC 2827 / BCP 38** recommends egress filtering at ISP boundaries to prevent IP spoofing — traffic claiming source IPs outside your assigned range should be dropped.
- Egress filtering helps detect **data exfiltration**, **reverse shells**, and **C2 beaconing** — all common post-exploitation behaviors.
- Many organizations mistakenly allow all outbound traffic by default (implicit permit-all egress), which is a significant security gap exploited by attackers.
- On the Security+/CySA+ exam, egress filtering appears in the context of **network segmentation**, **DLP controls**, and **firewall rule best practices** — know it as a *preventive and detective* control.

## Related concepts
[[Ingress Filtering]] [[Data Loss Prevention]] [[DNS Tunneling]] [[Command and Control (C2)]] [[Firewall Rules]]