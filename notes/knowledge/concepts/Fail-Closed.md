# Fail-Closed

## What it is
Like a bank vault door that locks itself shut during a power failure rather than swinging open, a fail-closed system defaults to **denying access** when it encounters an error or unexpected state. Precisely: a fail-closed design ensures that when a security control fails, it blocks all traffic or access rather than permitting it, prioritizing security over availability.

## Why it matters
In 2003, the Slammer worm exploited a firewall misconfiguration where a device failed open during a software crash — traffic flooded through the "broken" gate unfiltered. A fail-closed firewall in that same scenario would have dropped all packets on failure, containing the worm at the cost of temporary downtime. This tradeoff — security over uptime — is the defining tension fail-closed systems must justify.

## Key facts
- **Fail-closed = deny by default on failure**; fail-open = permit by default on failure (the dangerous alternative)
- IDS/IPS devices configured inline (as an IPS) are often set fail-closed so a device crash doesn't create an unmonitored gap
- Fail-closed is preferred in **high-security environments** (military, financial); fail-open is acceptable where availability outweighs confidentiality (e.g., a hospital monitoring network that must stay up)
- The term maps directly to **security vs. availability tradeoffs** in the CIA Triad — fail-closed sacrifices availability to preserve confidentiality and integrity
- On Security+/CySA+ exams, fail-closed behavior is associated with **default-deny firewall rules** and the principle of least privilege applied to system failure states

## Related concepts
[[Fail-Open]] [[Defense in Depth]] [[Default-Deny Policy]] [[Intrusion Prevention System]] [[CIA Triad]]