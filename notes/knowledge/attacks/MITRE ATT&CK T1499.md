# MITRE ATT&CK T1499

## What it is
Like a mob of people all hitting a single ATM simultaneously until it crashes and nobody can withdraw cash, T1499 (Endpoint Denial of Service) describes adversaries overwhelming a specific system, application, or service with traffic or requests until it becomes unavailable to legitimate users. Unlike network-layer flooding, this technique targets the endpoint itself — exhausting CPU, memory, or application threads rather than just saturating bandwidth.

## Why it matters
During the 2016 Dyn DNS attack, botnets executing application-layer flood techniques rendered major websites unreachable by targeting DNS resolvers specifically — not just raw bandwidth. Defenders must distinguish volumetric attacks (L3/L4) from application-layer exhaustion (L7) because the mitigations differ: rate limiting and WAF rules address application floods, while upstream scrubbing centers handle volumetric attacks.

## Key facts
- **Four sub-techniques exist**: OS Exhaustion Flood (T1499.001), Service Exhaustion Flood (T1499.002), Application Exhaustion Flood (T1499.003), and Application or System Exploitation (T1499.004)
- Application-layer attacks (e.g., HTTP flood, Slowloris) are harder to detect because individual requests appear legitimate
- T1499 is an **Impact** tactic — goal is disruption, not data theft or persistence
- Slowloris attacks work by holding HTTP connections open with incomplete requests, starving the server of available threads without high bandwidth
- Key mitigations include **load balancers, WAFs, rate limiting, connection timeouts**, and CAPTCHAs for web services

## Related concepts
[[Denial of Service T1498]] [[Botnet Infrastructure]] [[Web Application Firewall]] [[Network Intrusion Detection]] [[Impact Tactic]]