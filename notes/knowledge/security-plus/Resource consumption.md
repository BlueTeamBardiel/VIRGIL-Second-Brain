# Resource consumption

## What it is
Like a prankster who orders 10,000 pizzas to one address just to jam up the delivery system, resource consumption attacks deliberately exhaust a target's finite assets — CPU cycles, memory, bandwidth, or disk space — until legitimate users get nothing. Precisely: it's a category of availability attack where an adversary forces a system to spend more resources processing malicious input than the system can sustain.

## Why it matters
The 2016 Mirai botnet attack against Dyn DNS consumed so much bandwidth through coordinated UDP floods that major platforms like Twitter, Reddit, and Netflix went offline for hours — not because any system was "hacked," but because legitimate packets couldn't compete with the flood. Defenders counter this by implementing rate limiting, traffic scrubbing, and connection timeouts to starve the attack before it can exhaust capacity.

## Key facts
- **ReDoS (Regular Expression Denial of Service)** exploits "catastrophic backtracking" in regex engines — one crafted string can consume 100% CPU for seconds or minutes
- **SYN floods** half-open TCP connections, exhausting the server's connection table (backlog queue) without completing the handshake
- **Slowloris** attacks exhaust web server thread pools by sending HTTP headers *extremely slowly*, keeping connections open indefinitely
- Resource exhaustion attacks target the **CIA Triad's Availability** pillar and map to **CWE-400** (Uncontrolled Resource Consumption)
- Mitigations include **connection rate limiting**, **CAPTCHA challenges**, **timeout tuning**, **load balancing**, and upstream **scrubbing centers** (e.g., Cloudflare, Akamai)

## Related concepts
[[Denial of Service]] [[Distributed Denial of Service]] [[SYN Flood]] [[Slowloris Attack]] [[Rate Limiting]]