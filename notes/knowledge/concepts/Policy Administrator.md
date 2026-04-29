# Policy Administrator

## What it is
Think of the Policy Administrator as the bouncer at an exclusive club who checks IDs at the door — but the ID rules come from a separate manager (the Policy Engine) telling the bouncer who's allowed in tonight. In Zero Trust Architecture (ZTA), the Policy Administrator is the component responsible for establishing or shutting down the communication path between a subject and a resource, translating the Policy Engine's access decisions into actual allow/deny actions. It communicates those decisions to the Policy Enforcement Point (PEP), which physically enforces them.

## Why it matters
In a Zero Trust deployment, an attacker who compromises a legacy VPN can often move laterally at will — but if a Policy Administrator is in play, every session requires a fresh access decision. For example, if a user's risk score spikes mid-session (due to anomalous behavior detected by a UEBA tool), the Policy Engine reassesses and instructs the Policy Administrator to tear down the active session — something traditional perimeter security cannot do dynamically.

## Key facts
- The Policy Administrator is distinct from the Policy Engine: the Engine *decides*; the Administrator *acts* on that decision.
- It generates session tokens or credentials used by the subject to access the requested resource.
- It communicates with the Policy Enforcement Point (PEP), which sits between the subject and resource.
- In NIST SP 800-207 (the ZTA standard), the Policy Administrator is explicitly defined as a core control plane component.
- It can both establish *and* terminate sessions, enabling continuous verification rather than one-time authentication.

## Related concepts
[[Policy Engine]] [[Policy Enforcement Point]] [[Zero Trust Architecture]]