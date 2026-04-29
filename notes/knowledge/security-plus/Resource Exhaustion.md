# resource exhaustion

## What it is
Imagine a single-lane bridge where a prankster sends an endless parade of slow-moving tractors — no one else gets through, even though nothing is broken. Resource exhaustion is a denial-of-service technique where an attacker consumes a finite system resource (CPU cycles, memory, file descriptors, network connections, or bandwidth) faster than it can be replenished, making the service unavailable to legitimate users.

## Why it matters
The 2016 Mirai botnet attack against Dyn DNS flooded DNS resolvers with UDP traffic, exhausting connection-handling capacity and taking down Twitter, Reddit, and Netflix for hours. Defenders responded by implementing rate limiting, traffic scrubbing via upstream providers, and anycast routing to distribute load — all direct countermeasures to resource exhaustion at scale.

## Key facts
- **SYN flood** is a classic resource exhaustion attack: the attacker sends thousands of TCP SYN packets without completing the handshake, filling the server's half-open connection table until it drops legitimate requests.
- **CPU exhaustion** can be triggered by hash collision attacks (CWE-407), where crafted inputs force worst-case algorithmic performance — a known attack against PHP and Java web apps.
- **Defense mechanisms** include connection rate limiting, CAPTCHA challenges, timeout tuning, resource quotas (ulimits), and Web Application Firewalls (WAF).
- **Amplification attacks** (DNS, NTP, SSDP reflection) are a form of resource exhaustion where small spoofed requests generate disproportionately large responses, overwhelming the victim's bandwidth.
- On Security+/CySA+, resource exhaustion falls under **availability** attacks within the CIA triad and maps to the **Denial of Service (DoS/DDoS)** threat category.

## Related concepts
[[denial of service]] [[SYN flood]] [[amplification attack]] [[rate limiting]] [[botnet]]