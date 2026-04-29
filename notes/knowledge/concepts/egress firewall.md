# egress firewall

## What it is
Like a security guard who checks what employees carry *out* of a building rather than just who walks *in*, an egress firewall filters outbound network traffic leaving an internal network. It enforces policy on connections initiated from inside, blocking unauthorized destinations, protocols, or data exfiltration attempts.

## Why it matters
During the SolarWinds supply chain attack, compromised systems needed to phone home to attacker-controlled C2 servers. Organizations with strict egress filtering — allowing only approved destinations on approved ports — could detect or block that outbound beaconing, even though the malware was already inside the perimeter. Egress control turns a perimeter breach into a contained incident rather than a full compromise.

## Key facts
- Most organizations over-invest in ingress filtering and neglect egress, leaving attackers free to exfiltrate data once inside
- DNS and HTTPS (port 443) are the most commonly abused egress channels because they're almost never blocked — DNS tunneling tools like **dnscat2** exploit this directly
- Egress filtering is a core control in **NIST SP 800-41** and is referenced in CIS Control 13 (Network Monitoring and Defense)
- A default-deny egress policy (allowlist approach) is far stronger than blocking known-bad destinations (denylist) — attackers simply use uncategorized or newly registered domains
- On Security+/CySA+, egress filtering appears in the context of **data loss prevention (DLP)**, C2 traffic containment, and network segmentation questions

## Related concepts
[[ingress firewall]] [[data loss prevention]] [[command and control traffic]] [[DNS tunneling]] [[network segmentation]]