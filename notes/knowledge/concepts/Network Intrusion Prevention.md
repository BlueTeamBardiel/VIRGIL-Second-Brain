# Network Intrusion Prevention

## What it is
Like a bouncer at a club who doesn't just watch troublemakers but physically blocks them at the door, a Network Intrusion Prevention System (NIPS) sits **inline** on the network and actively drops or rejects malicious traffic in real time — not just alerting on it. It is a security control that inspects packets, compares them against known attack signatures and behavioral baselines, and takes automated blocking action before the traffic reaches its target.

## Why it matters
In 2021, attackers exploited the ProxyLogon vulnerability (CVE-2021-26855) in Microsoft Exchange servers by sending specially crafted HTTP requests. Organizations with a properly tuned IPS inline on their perimeter had those exploit payloads matched against signatures and dropped before they ever touched the vulnerable server, while companies relying only on IDS received alerts they often couldn't act on fast enough to prevent compromise.

## Key facts
- **IDS detects and alerts; IPS detects and blocks** — this inline vs. passive distinction is a core Security+ exam point
- IPS uses three detection methods: **signature-based** (known patterns), **anomaly-based** (deviations from baseline), and **policy-based** (explicit rule violations)
- A **false positive** in an IPS is operationally dangerous — it drops legitimate traffic, potentially causing outages; this is why tuning matters more than in IDS
- IPS can be **network-based (NIPS)** or **host-based (HIPS)**; HIPS protects individual endpoints even after traffic passes the network perimeter
- **Fail-open vs. fail-closed**: if the IPS hardware fails, fail-open passes all traffic (availability prioritized); fail-closed drops all traffic (security prioritized) — know which is appropriate for each environment

## Related concepts
[[Intrusion Detection System]] [[Signature-Based Detection]] [[Anomaly-Based Detection]] [[Unified Threat Management]] [[Defense in Depth]]