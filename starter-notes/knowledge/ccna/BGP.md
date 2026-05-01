# BGP

## What it is
Think of BGP as the postal service's master routing agreement — thousands of post offices (autonomous systems) negotiating with each other about which roads to use to deliver mail, based entirely on trust and peer agreements. Border Gateway Protocol (BGP) is the exterior routing protocol that governs how traffic is directed between autonomous systems (AS) across the internet. It makes decisions based on path attributes and policy, not speed or efficiency.

## Why it matters
In 2010, China Telecom briefly advertised BGP routes that redirected roughly 15% of global internet traffic through Chinese servers — a classic BGP hijacking attack. An attacker who can announce false route prefixes can intercept, inspect, or black-hole traffic at massive scale. Defenders mitigate this using RPKI (Resource Public Key Infrastructure), which cryptographically ties IP prefixes to authorized AS numbers.

## Key facts
- BGP operates over **TCP port 179** and forms peer relationships called "sessions" between neighboring routers
- BGP hijacking occurs when a malicious AS announces ownership of IP prefixes it doesn't legitimately control, redirecting traffic
- BGP is a **path-vector protocol** — it passes lists of AS hops (AS_PATH) to prevent routing loops
- There is **no built-in authentication** in classic BGP; trust is implicit between peers, making it inherently vulnerable
- **RPKI** and **BGPsec** are the primary defenses: RPKI validates prefix ownership, BGPsec adds cryptographic signatures to path announcements
- BGP misconfigurations (not just attacks) cause major outages — the 2021 Facebook outage was triggered by a BGP route withdrawal

## Related concepts
[[PKI]] [[Autonomous Systems]] [[Route Hijacking]] [[DNS Poisoning]] [[Man-in-the-Middle Attack]]
