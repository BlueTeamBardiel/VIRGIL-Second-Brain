# Fail-Open

## What it is
Like a security guard who waves everyone through when their badge scanner breaks, a fail-open system defaults to *allowing* access or traffic when it encounters an error or failure. Precisely: a fail-open design permits operations to continue unrestricted when a security control malfunctions, prioritizing availability over security.

## Why it matters
In 2003, a misconfigured IDS inline sensor failed and defaulted to fail-open — the network stayed up, but all traffic passed uninspected for hours during a targeted intrusion. Attackers who understand that systems fail open will deliberately trigger resource exhaustion or errors (like flooding a WAF until it crashes) to create an unguarded window for their actual payload.

## Key facts
- **Fail-open vs. fail-closed (fail-secure):** Fail-open preserves availability; fail-closed blocks all traffic on failure. Security-first designs prefer fail-closed.
- **Common locations:** Firewalls, IDS/IPS sensors, authentication gateways, and content filters are frequently misconfigured to fail-open to avoid business disruption.
- **Attack vector:** Deliberately crashing or overwhelming a security control to trigger fail-open behavior is a known bypass technique — sometimes called a "failover attack."
- **Availability vs. security tradeoff:** Fail-open is sometimes *intentional* in life-safety systems (e.g., hospital networks where blocking treatment data is worse than a breach).
- **Security+ context:** Exam questions often frame fail-open/fail-secure as a design decision requiring risk acceptance documentation — choosing fail-open means formally accepting the residual security risk.

## Related concepts
[[Fail-Closed]] [[Defense in Depth]] [[Availability Triad]] [[IDS vs IPS]] [[Risk Acceptance]]