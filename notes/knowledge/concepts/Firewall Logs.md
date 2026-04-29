# Firewall Logs

## What it is
Like a nightclub bouncer keeping a ledger of everyone who was let in, turned away, and thrown out — firewall logs are timestamped records of every connection attempt a firewall evaluates, including the verdict (allow, deny, drop) and the reasoning behind it. They capture source/destination IPs, ports, protocols, and rule matches for every packet the firewall inspects.

## Why it matters
During the 2013 Target breach, attackers pivoted from a third-party HVAC vendor's network segment into the cardholder data environment. Properly reviewed firewall logs would have revealed anomalous lateral movement — traffic crossing network boundaries that should never communicate — days before 40 million credit cards were exfiltrated. Firewall logs are often the earliest forensic artifact showing an attacker's reconnaissance or pivot attempts.

## Key facts
- **Implicit deny logs** are critical: most firewalls have a default "deny all" rule at the bottom; logging hits on this rule surfaces unauthorized access attempts and port scanning.
- Firewall logs distinguish between **denied** (firewall sent a reject response) and **dropped** (firewall silently discarded the packet) — "drop" is stealthier and preferred to not reveal firewall presence to attackers.
- **Log correlation** with IDS/IPS and SIEM tools (like Splunk or QRadar) transforms raw firewall data into actionable threat intelligence through pattern matching.
- Key fields for CySA+ analysis: **src IP, dst IP, src port, dst port, protocol, action, bytes transferred, timestamp, and rule/policy triggered**.
- Firewall logs support **baseline deviation analysis** — unusually high connection volumes to a single external IP can indicate data exfiltration (beaconing behavior).

## Related concepts
[[Network Security Monitoring]] [[SIEM]] [[Intrusion Detection System]] [[Log Management]] [[Network Segmentation]]